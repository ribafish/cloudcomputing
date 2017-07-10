#!/bin/bash

# Check parameters
test $# = 1 || { echo "Need 1 parameter: Name of the stack to create"; exit 1; }
STACK="$1"

# Create the stack using server-landscape.yaml and defining all necessary parameters
openstack stack create -t server-landscape.yaml $1 \
--wait \
--parameter "key_pair=group06key" \
--parameter "external_net=tu-internal" \
--parameter "flavor=Cloud Computing" \
--parameter "image=ubuntu-16.04" \
--parameter "zone=Cloud Computing 2017"

