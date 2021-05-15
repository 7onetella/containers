#!/bin/bash -e

version=${1}

docker build -t docker-registry.7onetella.net/7onetella/codeserver:"${version}" .

docker push docker-registry.7onetella.net/7onetella/codeserver:"${version}"

vag docker deploy codeserver-dev:"${version}"
