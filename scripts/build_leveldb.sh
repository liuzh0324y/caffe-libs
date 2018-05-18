#!/usr/bin/env bash

set -eu

. "$(dirname "$0")/../config.sh"

LEVELDB_ROOT=${PROJECT_DIR}/leveldb

pushd "${LEVELDB_ROOT}"

make clean
make -j"${N_JOBS}" \
    out-static/libleveldb.a

rm -rf "${INSTALL_DIR}/leveldb"
mkdir -p "${INSTALL_DIR}/leveldb/lib"
cp -r include/ "${INSTALL_DIR}/leveldb"
cp out-static/libleveldb.a "${INSTALL_DIR}/leveldb/lib"

make clean

popd

