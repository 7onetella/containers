#!/bin/bash

set -xe

version=${1}

image=docker-registry.7onetella.net/7onetella/builder:"${version}"

docker run -d --name builder ${image}