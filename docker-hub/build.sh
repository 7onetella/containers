#!/bin/bash

version=${1}

docker build -t docker-registry.7onetella.net:5000/7onetella/docker-hub:"${version}" .

docker push docker-registry.7onetella.net:5000/7onetella/docker-hub:"${version}"

vag docker deploy docker-hub-dev:"${version}"
