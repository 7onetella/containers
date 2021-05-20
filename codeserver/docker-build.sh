#!/bin/bash -e

set -x

password=$1

service=codeserver-f121

group=public

version=1.0.0

# version=$(vag docker version patch codeserver-public)

touch config.yml

cat config.yml.tpl | sed 's/__secret__/'"${password}"'/g' > config.yml

docker build -t docker-registry.7onetella.net/7onetella/${service}:"${version}" .

docker push docker-registry.7onetella.net/7onetella/${service}:"${version}"

vag docker deploy ${service}-${group}:"${version}"
