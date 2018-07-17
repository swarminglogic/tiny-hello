#!/bin/bash

ROOT_DIR=$(git rev-parse --show-toplevel)

pushd ${ROOT_DIR} &>/dev/null

cc --static -Wall -O2 nweb/nweb23.c -o server/nweb

popd &>/dev/null

