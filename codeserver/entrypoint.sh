#!/bin/bash -e

set -x

echo -e "whoami = $(whoami)"

sudo /etc/init.d/ssh restart

sudo chown root:docker /var/run/docker.sock

nohup /home/coder/.local/bin/github_checkout_all.sh &

nohup /home/coder/.local/bin/runtime_install.sh &

dumb-init /usr/bin/code-server --bind-addr 0.0.0.0:9991 /home/coder/workspace