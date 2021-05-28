#!/bin/bash -e

set -x

cd /home/coder/workspace

cat ~/.git-ssh-config >> ~/.ssh/config

for repo in $(cat /home/coder/.local/bin/repositories.txt)
do
    git clone $repo
done