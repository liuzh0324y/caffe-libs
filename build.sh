#!/usr/bin/env bash

set -eu

. "$(dirname "$0")/config.sh"

pushd "${PROJECT_DIR}"

#./scripts/build_boost.sh
#./scripts/build_opencv.sh
#./scripts/build_gflags.sh
#./scripts/build_glog.sh
#./scripts/build_leveldb.sh
./scripts/build_openblas.sh
#./scripts/build_caffe.sh

popd

echo "DONE.."
