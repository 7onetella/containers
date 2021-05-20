#!/bin/bash -e

set -x

userid=$1    

password=$2

service=vscode-${userid}

group=public

version=$(vag docker version patch ${service}-${group})

cat config.yml.tpl | sed 's/__secret__/'"${password}"'/g' > config.yml

docker build -t docker-registry.7onetella.net/7onetella/${service}:"${version}" .

docker push docker-registry.7onetella.net/7onetella/${service}:"${version}"

export DOCKER_REGISTRY=docker-registry.7onetella.net

vag docker deploy ${service}-${group}:"${version}"

rm config.yml
