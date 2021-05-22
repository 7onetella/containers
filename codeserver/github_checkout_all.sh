#!/bin/bash -e

set -x

cd /home/coder/workspace

for repo in $(cat repositories.txt)
do
    git clone $repo
done