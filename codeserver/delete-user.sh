#!/bin/bash -e

clear

set -x

username=$1

vag cx delete-user ${username}

vag gitea delete-user-repo ${username} project

vag gitea delete-user ${username}
