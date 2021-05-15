#!/bin/bash

export SSH_PORT=$(curl -s "http://consul.7onetella.net:8500/v1/health/service/codeserver-dev-codeserver-service?dc=dc1" | jq -r ".[0].Service.TaggedAddresses.lan_ipv4.Port")
export HOST_IP=$(curl -s  "http://consul.7onetella.net:8500/v1/health/service/codeserver-dev-codeserver-service?dc=dc1" | jq -r ".[0].Service.Address")
export UUID=$(uuid)
export TERM=xterm

sudo /etc/init.d/ssh restart

echo SSH_PORT=$SSH_PORT
echo HOST_IP=$HOST_IP
echo UUID=$UUID

# this deosn't work during docker build time
sudo chown root:docker /var/run/docker.sock

dumb-init /usr/bin/code-server --bind-addr 0.0.0.0:8080 /home/coder/workspace