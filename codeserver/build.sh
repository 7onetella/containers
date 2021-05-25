#!/bin/bash -e

userid=$1    

password=$2

email=$3

service=vscode-${userid}

group=public

set -x

version=$(vag docker version patch ${service}-${group})

cat profile-${userid}.yml | vag docker pre-build ${userid} ${password} ${email}

docker build -t docker-registry.7onetella.net/7onetella/${service}:"${version}" .

docker push docker-registry.7onetella.net/7onetella/${service}:"${version}"

nomad job stop -purge ${service} || true

vag docker deploy docker-registry.7onetella.net/7onetella/${service}-${group}:"${version}"

vag docker post-build ${service}