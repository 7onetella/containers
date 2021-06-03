#!/bin/bash -e

set -x

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd $SCRIPT_DIR

service=serbot

group=public

base_version=${1}

version=$(../next_tag.sh 7onetella/serbot)

docker build --build-arg BASE_VERSION=${base_version} -t docker-registry.7onetella.net/7onetella/${service}:${version} .

docker push docker-registry.7onetella.net/7onetella/${service}:${version}

nomad job stop -purge ${service} || true

vag docker deploy docker-registry.7onetella.net/7onetella/${service}-${group}:${version}
