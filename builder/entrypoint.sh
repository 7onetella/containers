#!/bin/bash

export SSH_PORT=$(curl -s "http://consul.7onetella.net:8500/v1/health/service/builder-dev-builder-service?dc=dc1" | jq -r ".[0].Service.TaggedAddresses.lan_ipv4.Port")
export HOST_IP=$(curl -s "http://consul.7onetella.net:8500/v1/health/service/builder-dev-builder-service?dc=dc1" | jq -r ".[0].Service.Address")
export UUID=$(uuid)
export TERM=xterm

/etc/init.d/ssh restart

echo SSH_PORT=$SSH_PORT
echo HOST_IP=$HOST_IP
echo UUID=$UUID

sleep 1000000000000000
