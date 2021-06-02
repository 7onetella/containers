#!/bin/bash

service-serbot

group=backend

version=$(vag docker version patch ${service}-${group})

docker build -t docker-registry.7onetella.net/7onetella/serbot:"${version}" .

docker push docker-registry.7onetella.net/7onetella/serbot:"${version}"

vag docker deploy docker-registry.7onetella.net/7onetella/serbot-dev:"${version}"
