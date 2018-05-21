#!/usr/bin/env bash

set -eu

. "$(dirname "$0")/../config.sh"

LMDB_ROOT=${PROJECT_DIR}/lmdb/libraries/liblmdb

pushd "${LMDB_ROOT}"

make clean
make -j"${N_JOBS}"

rm -rf "$INSTALL_DIR/lmdb"
make prefix="$INSTALL_DIR/lmdb" install

make clean

popd
