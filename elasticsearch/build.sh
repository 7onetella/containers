#!/bin/bash

version=${1}

docker build -t docker-registry.7onetella.net:5000/7onetella/elasticsearch:"${version}" .

docker push docker-registry.7onetella.net:5000/7onetella/elasticsearch:"${version}"

vag docker deploy elasticsearch-dev:"${version}"
