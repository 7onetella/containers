#!/bin/bash

set -e

cp ~/.ssh/authorized_keys .ssh/

version=${1}

docker build -t docker-registry.7onetella.net/7onetella/codeserver:"${version}" .

docker push docker-registry.7onetella.net/7onetella/codeserver:"${version}"

vag docker deploy builder-dev:"${version}"
