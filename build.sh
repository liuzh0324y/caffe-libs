#!/usr/bin/env bash

set -eu

. "$(dirname "$0")/config.sh"

pushd "${PROJECT_DIR}"

./scripts/build_boost.sh

popd

echo "DONE.."
