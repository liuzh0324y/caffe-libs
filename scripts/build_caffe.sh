#!/usr/bin/env bash

set -eu

. "$(dirname "$0")/../config.sh"

CAFFE_ROOT=${PROJECT_DIR}/caffe
BUILD_DIR=${CAFFE_ROOT}/build

BOOST_HOME=${INSTALL_DIR}/boost
OPENCV_HOME=${INSTALL_DIR}/opencv
GFLAGS_HOME=${INSTALL_DIR}/gflags
GLOG_HOME=${INSTALL_DIR}/glog
PROTOBUF_HOME=${INSTALL_DIR}/protobuf
SNAPPY_HOME=${INSTALL_DIR}/snappy
export LEVELDB_ROOT=${INSTALL_DIR}/leveldb
export LMDB_DIR=${INSTALL_DIR}/lmdb
export OpenBLAS_HOME=${INSTALL_DIR}/openblas

rm -rf "${BUILD_DIR}"
mkdir -p "${BUILD_DIR}"

pushd "${BUILD_DIR}"

cmake -DCMAKE_INSTALL_PREFIX="${INSTALL_DIR}/caffe" \
      -DCMAKE_BUILD_TYPE=Release \
      -DBUILD_SHARED_LIB=NO \
      -DBUILD_python=OFF \
      -DBUILD_docs=OFF \
      -DBUILD_matlab=OFF \
      -DCPU_ONLY=ON \
      -DUSE_CUDNN=OFF \
      -DUSE_NCCL=OFF \
      -DUSE_LMDB=ON \
      -DUSE_LEVELDB=ON \
      -DBLAS=open \
      -DBOOST_ROOT="${BOOST_HOME}" \
      -DGFLAGS_INCLUDE_DIR="${GFLAGS_HOME}/include" \
      -DGFLAGS_LIBRARY="${GFLAGS_HOME}/lib/libgflags.a" \
      -DGLOG_INCLUDE_DIR="${GLOG_HOME}/include" \
      -DGLOG_LIBRARY="${GLOG_HOME}/lib/libglog.a" \
      -DOpenCV_DIR="${OPENCV_HOME}" \
      -DPROTOBUF_INCLUDE_DIR="${PROTOBUF_HOME}/include" \
      -DPROTOBUF_LIBRARY="${PROTOBUF_HOME}/lib/libprotobuf.a" \
      -DPROTOBUF_PROTOC_EXECUTABLE="${PROTOBUF_HOME}/bin/protoc" \
      -DSNAPPY_ROOT_DIR="${SNAPPY_HOME}" \
      ..

make -j"${N_JOBS}"
rm -rf "${INSTALL_DIR}/caffe"
make install

popd

rm -rf "${BUILD_DIR}"
