from slackeventsapi import SlackEventAdapter
import subprocess
import slack
import os
from time import sleep, time
import asyncio
import threading
import logging
from flask import Flask, request, Response


app = Flask(__name__)

# Our app's Slack Event Adapter for receiving actions via the Events API
slack_signing_secret = os.environ["SLACK_SIGNING_SECRET"]
slack_events_adapter = SlackEventAdapter(slack_signing_secret, "/serbot/slack/events")

# Create a SlackClient for your bot to use for Web API requests
slack_bot_token = os.environ["SLACK_BOT_TOKEN"]
slack_client = slack.WebClient(token=slack_bot_token)

events = []


@slack_events_adapter.on("app_mention")
def handle_mention(event_data):
    logger.info("event {}".format(event_data))
    events.append(event_data)


def process_commands():
    while True:
        sleep(0.05)
        while len(events) > 0:
            try:
                event_data = events.pop(0)
                event = event_data['event']
                channel = event["channel"]
                channel_info = slack_client.conversations_info(channel=channel)
                channel_name = channel_info['channel']['name']
                user = event["user"]
                user_info = slack_client.users_info(user=user)
                user_name = user_info['user']['name']
                event_text = event['text']
                # clean up “ and ” from 
                event_text = event_text.replace('“', '').replace('”', '')
                tokens = event_text.split()[1:]
                logger.info('---------------------------------------------------------------')
                logger.info('channel : {} {}'.format(channel, channel_name))
                logger.info('user    : {} {}'.format(user, user_name))
                logger.info('command : {}'.format(tokens))
                logger.info('')
                
                cmd_str = ' '.join(tokens)
                slack_client.chat_postMessage(channel=channel, text='*executing:* `{}`  *requested by:* {}'.format(cmd_str, user_name))

                # use api_app_id as encryption key
                custom_env = get_custom_env(event_data['api_app_id'])

                completed = subprocess.run(tokens, capture_output=True, env=custom_env)    
                if completed.returncode != 0:
                    output = '''
:feelsbadman: process returned with exit code {}
```
args : {} 
{} 
{}```'''.format(completed.returncode, completed.args, completed.stdout.decode().strip(), completed.stderr.decode().strip())
                    logger.error(output)
                    slack_client.chat_postMessage(channel=channel, text=output)
                    continue

                s = completed.stdout.decode().strip()
                reply = 'empty output'
                if len(s) == 0:
                    reply = 'empty output'
                else:
                    reply = "```\n{}```".format(s)
                logger.info(reply)
                logger.info('')
                slack_client.chat_postMessage(channel=channel, text=reply)
            except Exception as e:
                s = 'error while processing your request'
                logger.error(s)
                logger.error('')
                logger.error(e)
                slack_client.chat_postMessage(channel=channel, text=s)


def get_custom_env(key):
    custom_env = os.environ.copy()
    custom_env["PATH"] = os.environ.get('PATH') + ":/root/.local/bin"
    return custom_env


@slack_events_adapter.server.route('/health', methods=['GET'])
def health():
    return Response('UP')


@slack_events_adapter.server.route('/', methods=['GET'])
def root():
    return Response('OK')


thread = threading.Thread(target=process_commands, args=())
thread.daemon = False
thread.start()


logger = logging.getLogger("__name__")  # or __name__ for current module
logger.setLevel(logging.INFO)


# Once we have our event listeners configured, we can start the
# Flask server with the default `/events` endpoint on port 3000
slack_events_adapter.start(host='0.0.0.0', port=3000)


