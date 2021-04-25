#!/bin/bash

set -e

version=${1}

image=docker-registry.7onetella.net/7onetella/builder:"${version}"

docker rm -f builder || true

docker run -d --name builder ${image}