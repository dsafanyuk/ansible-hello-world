#!/bin/bash

set -o errexit -o nounset -o pipefail

pushd ansible-hello-world/

apk update
apk add python3 python3-dev py3-openssl py3-pip

pip3 install --upgrade pip
pip3 install ansible molecule[docker]

molecule test
