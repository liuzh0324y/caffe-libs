#!/usr/bin/env bash

set -eu

. "$(dirname "$0")/../config.sh"

OPENBLAS_ROOT=${PROJECT_DIR}/openblas
BUILD_DIR=${OPENBLAS_ROOT}/build

rm -rf "${BUILD_DIR}"
mkdir -p "${BUILD_DIR}"

pushd "${BUILD_DIR}"

cmake -DCMAKE_INSTALL_PREFIX="${INSTALL_DIR}/openblas" \
      -DCMAKE_BUILD_TYPE=Release \
      ..

make -j"${N_JOBS}"
rm -rf "${INSTALL_DIR}/openblas"
make install/strip

popd

rm -rf "${BUILD_DIR}"
