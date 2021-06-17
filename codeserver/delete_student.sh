#!/bin/bash -e

# set -x

username=$1

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd $SCRIPT_DIR

echo --------------------------------------------
echo deleting from gitea    
vag gitea delete-user-repo ${username} project || true 
vag gitea delete-user ${username} || true

echo --------------------------------------------
echo deleting from nomad    
nomad job stop -purge vscode-${username} || true

echo 
echo --------------------------------------------
echo deleting from database 
vag cx delete-user ${username}