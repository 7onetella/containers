#!/bin/bash -e

set -x

service=serbot

group=public

version=$(vag docker version patch ${service}-${group})

docker build -t docker-registry.7onetella.net/7onetella/${service}:${version} .

docker push docker-registry.7onetella.net/7onetella/${service}:${version}

vag docker deploy docker-registry.7onetella.net/7onetella/${service}-${group}:${version}
