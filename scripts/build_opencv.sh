#!/usr/bin/env bash

set -eu

. "$(dirname "$0")/../config.sh"

OPENCV_ROOT=${PROJECT_DIR}/opencv
BUILD_DIR=${OPENCV_ROOT}/build

rm -rf "${BUILD_DIR}"
mkdir -p "${BUILD_DIR}"

pushd "${BUILD_DIR}"

#cmake -DCMAKE_BUILD_WITH_INSTALL_RPATH=ON \
#      -DWITH_CUDA=OFF \
#      -DWITH_MATLAB=OFF \
#      -DBUILD_DOCS=OFF \
#      -DBUILD_PREF_TESTS=OFF \
#      -DBUILD_TESTS \
#      -DCMAKE_INSTALL_PREFIX="${INSTALL_DIR}/opencv" \
#      ..
cmake -DCMAKE_INSTALL_PREFIX="${INSTALL_DIR}/opencv" \
      -DCMAKE_BUILD_WITH_INSTALL_RPATH=NO \
      -DCMAKE_BUILD_TYPE=Release \
      -DBUILD_SHARED_LIBS=YES \
      -DWITH_CUDA=OFF \
      -DWITH_MATLAB=OFF \
      -DBUILD_DOCS=OFF \
      -DBUILD_EXAMPLES=OFF \
      -DBUILD_TESTS=OFF \
      ..

make -j"${N_JOBS}"
rm -rf "${INSTALL_DIR}/opencv"
make install/strip

popd

rm -rf "${BUILD_DIR}"
