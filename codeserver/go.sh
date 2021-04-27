#!/bin/bash

set -e

alloc_id=$(curl -s http://nomad.7onetella.net:4646/v1/job/codeserver/allocations | jq -r '.[0].ID')

ip=$(curl -s "http://nomad.7onetella.net:4646/v1/allocation/${alloc_id}" | jq -r '.Resources.Networks[0].IP')
port=$(curl -s "http://nomad.7onetella.net:4646/v1/allocation/${alloc_id}" | jq -r '.Resources.Networks[0].DynamicPorts[] | select(.Label == "ssh") | .Value')

ssh -p ${port} -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no coder@${ip}
