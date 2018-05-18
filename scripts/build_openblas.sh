#!/usr/bin/env bash

set -eu

. "$(dirname "$0")/../config.sh"

OPENBLAS_ROOT=${PROJECT_DIR}/openblas

pushd "${OPENBLAS_ROOT}"

make clean
make -j"${N_JOBS}" \
    libs

rm -rf "${INSTALL_DIR}/openblas"
make PREFIX="${INSTALL_DIR}/openblas" install

make clean

popd
