#!/bin/bash

sudo /etc/init.d/ssh restart

sudo chown root:docker /var/run/docker.sock

dumb-init /usr/bin/code-server --bind-addr 0.0.0.0:8080 /home/coder/workspace