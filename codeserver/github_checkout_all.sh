#!/bin/bash -e

set -x

for repo in $(cat repositories.txt)
do
    git clone $repo
done