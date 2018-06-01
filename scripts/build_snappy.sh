#!/usr/bin/env bash

set -eu 

. "$(dirname "$0")/../config.sh"

SNAPPY_ROOT=${PROJECT_DIR}/snappy
BUILD_DIR=${SNAPPY_ROOT}/build

rm -rf "${BUILD_DIR}"
mkdir -p "${BUILD_DIR}"

pushd "${BUILD_DIR}"

cmake -DCMAKE_INSTALL_PREFIX="${INSTALL_DIR}/snappy" \
      -DCMAKE_BUILD_TYPE=Release \
      -DBUILD_SHARED_LIBS=ON \
      -DSNAPPY_BUILD_TESTS=OFF \
      ..

make -j"${N_JOBS}"
rm -rf "${INSTALL_DIR}/snappy"
make install/strip

popd

rm -rf "${BUILD_DIR}"
