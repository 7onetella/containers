#!/bin/bash

service=kibana

group=backend

version=$(vag docker version patch ${service}-${group})

docker build -t docker-registry.7onetella.net/7onetella/kibana:${version} .

docker push docker-registry.7onetella.net/7onetella/kibana:${version}

vag docker deploy docker-registry.7onetella.net/7onetella/${service}-${group}:${version}
