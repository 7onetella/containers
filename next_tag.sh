#!/bin/bash

# credit: https://stackoverflow.com/questions/28320134/how-can-i-list-all-tags-for-a-docker-image-on-a-remote-registry

if [ $# -lt 1 ]
then
cat << HELP

dockertags  --  list all tags for a Docker image on a remote registry.

EXAMPLE: 
    - list all tags for ubuntu:
       dockertags ubuntu

    - list all php tags containing apache:
       dockertags php apache

HELP
fi

# set -x

image="$1"
tags=`curl -s https://docker-registry.7onetella.net/v2/${image}/tags/list | sed -e 's/[][]//g' -e 's/"//g' -e 's/ //g' | tr '}' '\n'  | awk -F: '{print $3}'`

if [ -n "$2" ]
then
    tags=` echo "${tags}" | grep "$2" `
fi

echo "${tags}" | python3 -c "import sys; s=sys.stdin.read().split('.'); print(f'{s[0]}.{s[1]}.{int(s[2])+1}')"