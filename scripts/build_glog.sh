#!/usr/bin/env bash

set -eu

. "$(dirname "$0")/../config.sh"

GLOG_ROOT=${PROJECT_DIR}/glog
BUILD_DIR=${GLOG_ROOT}/build
GFLAGS_HOME=${INSTALL_DIR}/gflags

rm -rf "${BUILD_DIR}"
mkdir -p "${BUILD_DIR}"

pushd "${BUILD_DIR}"

cmake -DCMAKE_INSTALL_PREFIX="${INSTALL_DIR}/glog" \
      -DCMAKE_BUILD_TYPE=Release \
      -DGFLAGS_INCLUDE_DIR="${GFLAGS_HOME}/include" \
      -DGFLAGS_LIBRARY="${GFLAGS_HOME}/lib/libgflags.a" \
      ..

make -j"${N_JOBS}"
rm -rf "${INSTALL_DIR}/glog"
make install/strip

popd

rm -rf "${BUILD_DIR}"
