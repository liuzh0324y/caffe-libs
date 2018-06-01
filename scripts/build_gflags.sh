#!/usr/bin/env bash

set -eu

. "$(dirname "$0")/../config.sh"

GFLAGS_ROOT=${PROJECT_DIR}/gflags
BUILD_DIR=${GFLAGS_ROOT}/build

rm -rf "${BUILD_DIR}"
mkdir -p "${BUILD_DIR}"

pushd "${BUILD_DIR}"

cmake -DCMAKE_INSTALL_PREFIX="${INSTALL_DIR}/gflags" \
      -DCMAKE_BUILD_TYPE=Release \
      -DBUILD_SHARED_LIBS=ON \
      -DBUILD_STATIC_LIBS=OFF \
      -DBUILD_gflags_LIB=ON \
      -DBUILD_gflags_nothreads_LIB=OFF \
      -DBUILD_TESTING=OFF \
      ..

make -j"${N_JOBS}"
rm -rf "${INSTALL_DIR}/gflags"
make install/strip

popd

rm -rf "${BUILD_DIR}"
