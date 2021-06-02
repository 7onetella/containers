#!/bin/bash -e

set -x

service=codeserver-base

tools_version=${1:-1.0.2}

version=${2:-1.0.3}

docker build --build-args TOOLS_VERSION=${tools_version} --no-cache -t docker-registry.7onetella.net/7onetella/${service}:"${version}" .

docker push docker-registry.7onetella.net/7onetella/${service}:"${version}"


# chnagelog
# 1.0.1 - reverting code server back to 3.10.0 to fix python plugin click through issue
# 1.0.2 - adding sorenisanerd/gotty web terminal app