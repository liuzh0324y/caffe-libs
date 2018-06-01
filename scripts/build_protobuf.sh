#!/usr/bin/env bash

set -eu

. "$(dirname "$0")/../config.sh"

PROTOBUF_ROOT=${PROJECT_DIR}/protobuf
BUILD_DIR=${PROTOBUF_ROOT}/build_dir

rm -rf "${BUILD_DIR}"
mkdir -p "${BUILD_DIR}"

pushd "${BUILD_DIR}"

cmake -DCMAKE_INSTALL_PREFIX="${INSTALL_DIR}/protobuf" \
      -DCMAKE_BUILD_TYPE=Release \
      -Dprotobuf_BUILD_TESTS=OFF \
      -Dprotobuf_BUILD_EXAMPLES=OFF \
      -DBUILD_SHARED_LIBS=ON \
      ../cmake

make -j"${N_JOBS}"
rm -rf "${INSTALL_DIR}/protobuf"
make install/strip

popd

rm -rf "${BUILD_DIR}"
