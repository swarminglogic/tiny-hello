#!/bin/bash

ROOT_DIR=$(git rev-parse --show-toplevel)

pushd ${ROOT_DIR}/tiny-web-server &>/dev/null

make
mv tiny ../server/

popd &>/dev/null

