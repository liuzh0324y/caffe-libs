#!/usr/bin/env bash

set -eu

. "$(dirname "$0")/../config.sh"

CAFFE_ROOT=${PROJECT_DIR}/caffe
BUILD_DIR=${CAFFE_ROOT}/build

BOOST_HOME=${INSTALL_DIR}/boost
OPENCV_HOME=${INSTALL_DIR}/opencv

rm -rf "${BUILD_DIR}"
mkdir -p "${BUILD_DIR}"

pushd "${BUILD_DIR}"

cmake -DCMAKE_INSTALL_PREFIX="${INSTALL_DIR}/caffe" \
      -DCMAKE_BUILD_TYPE=Release \
      -DCPU_ONLY=ON \
      -DBOOST_ROOT="${BOOST_HOME}" \
      -DOpenCV_DIR="${OPENCV_HOME}" \
      ..

make -j"${N_JOBS}"
rm -rf "${INSTALL_DIR}/caffe"
make install

popd

rm -rf "${BUILD_DIR}"
