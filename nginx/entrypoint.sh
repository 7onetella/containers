#!/bin/bash -e

sudo /etc/init.d/ssh restart

nginx -g 'daemon off;'