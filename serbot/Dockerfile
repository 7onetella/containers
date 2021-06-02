FROM docker-registry.7onetella.net/7onetella/base:1.0.0

RUN apt-get update --fix-missing  && \
    apt-get -q -y  install           \
      python3                        \
      python3-pip                    

# app.py dependencies
RUN pip3 install slackclient slackeventsapi

WORKDIR /root

# install serbot app
COPY app.py        /
COPY entrypoint.sh /

RUN  chmod +x /entrypoint.sh

EXPOSE 22
EXPOSE 3000

CMD /entrypoint.sh