#!/bin/bash

version=${1}

docker build -t docker-registry.7onetella.net:5000/7onetella/kibana:"${version}" .

docker push docker-registry.7onetella.net:5000/7onetella/kibana:"${version}"

vag docker deploy kibana-dev:"${version}"
