#!/usr/bin/env bash

set -eu

. "$(dirname "$0")/../config.sh"

CAFFE_ROOT=${PROJECT_DIR}/caffe
BUILD_DIR=${CAFFE_ROOT}/build

BOOST_HOME=${INSTALL_DIR}/boost
OPENCV_ROOT=${INSTALL_DIR}/opencv/share/OpenCV
GFLAGS_HOME=${INSTALL_DIR}/gflags
GLOG_HOME=${INSTALL_DIR}/glog
PROTOBUF_HOME=${INSTALL_DIR}/protobuf
SNAPPY_HOME=${INSTALL_DIR}/snappy
export LEVELDB_ROOT=${INSTALL_DIR}/leveldb
export LMDB_DIR=${INSTALL_DIR}/lmdb
export OpenBLAS_HOME=${INSTALL_DIR}/openblas
export LD_LIBRARY_PATH=${PROTOBUF_HOME}/lib

rm -rf "${BUILD_DIR}"
mkdir -p "${BUILD_DIR}"

pushd "${BUILD_DIR}"

cmake -DCMAKE_INSTALL_PREFIX="${INSTALL_DIR}/caffe" \
      -DCMAKE_BUILD_TYPE=Release \
      -DBUILD_SHARED_LIBS=ON \
      -DBUILD_python=OFF \
      -DBUILD_matlab=OFF \
      -DBUILD_docs=OFF \
      -DCPU_ONLY=ON \
      -DUSE_LEVELDB=ON \
      -DUSE_LMDB=OFF \
      -DUSE_NCCL=OFF \
      -DALLOW_LMDB_NOLOCK=ON \
      -DBOOST_ROOT="${BOOST_HOME}" \
      -DBLAS=open \
      -DOpenBLAS_INCLUDE_DIR="${OpenBLAS_HOME}/include" \
      -DOpenBLAS_LIB="${OpenBLAS_HOME}/lib/libopenblas.a" \
      -DGLOG_ROOT_DIR="${GLOG_HOME}" \
      -DGLOG_INCLUDE_DIR="${GLOG_HOME}/include" \
      -DGLOG_LIBRARY="${GLOG_HOME}/lib/libglog.so" \
      -DGFLAGS_ROOT_DIR="${GFLAGS_HOME}" \
      -DGFLAGS_INCLUDE_DIR="${GFLAGS_HOME}/include" \
      -DGFLAGS_LIBRARY="${GFLAGS_HOME}/lib/libgflags.so" \
      -DLevelDB_INCLUDE="${LEVELDB_ROOT}/include" \
      -DLevelDB_LIBRARY="${LEVELDB_ROOT}/lib/libleveldb.so" \
      -DSNAPPY_ROOT_DIR="${SNAPPY_HOME}" \
      -DPROTOBUF_PROTOC_EXECUTABLE="${PROTOBUF_HOME}/bin/protoc" \
      -DPROTOBUF_INCLUDE_DIR="${PROTOBUF_HOME}/include" \
      -DPROTOBUF_LIBRARY="${PROTOBUF_HOME}/lib/libprotobuf.so" \
      -DOpenCV_DIR="${OPENCV_ROOT}" \
      ..

make -j"${N_JOBS}"
rm -rf "${INSTALL_DIR}/caffe"
make install

popd

rm -rf "${BUILD_DIR}"
