#!/bin/bash -e

userid=$1 

ide=${2:-vscode}

service=${ide}-${userid}

group=public

set -x

version=$(vag docker version patch ${service}-${group})

vag cx get-profile ${userid} ${ide} | vag docker pre-build 

docker build -t docker-registry.7onetella.net/7onetella/${service}:${version} .

docker push docker-registry.7onetella.net/7onetella/${service}:${version}

nomad job stop -purge ${service} || true

vag docker deploy docker-registry.7onetella.net/7onetella/${service}-${group}:${version}

vag docker post-build ${service}