#!/bin/bash -e

set -x

sudo /etc/init.d/ssh restart

nginx -g 'daemon off;'