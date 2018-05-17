#!/usr/bin/env bash

set -eu 

. "$(dirname "$0")/../config.sh"

BOOST_ROOT=${PROJECT_DIR}/boost
BUILD_DIR=${BOOST_ROOT}/build

rm -rf "${BUILD_DIR}"
mkdir -p "${BUILD_DIR}"

pushd "${BUILD_DIR}"

cmake -DCMAKE_INSTALL_PREFIX="${INSTALL_DIR}/boost" .. 

make -j"${N_JOBS}"
rm -rf "${INSTALL_DIR}/boost"
make install/strip

rm -rf "${BUILD_DIR}"
