#!/usr/bin/env bash

BOOTSTRAPPED=${BOOTSTRAPPED:-}
if [ ! -z "$BOOTSTRAPPED" ]; then
    return
fi

PROJECT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
export PROJECT_DIR
export INSTALL_DIR=${PROJECT_DIR}/libs
export N_JOBS=${N_JOBS:-4}
export BOOTSTRAPPED
