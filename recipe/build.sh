#!/usr/bin/env bash
set -euxo pipefail

# Compile the CUDA sample with nvcc (provided by {{ compiler('cuda') }} in the
# build env). This is the step that actually requires the CUDA toolkit, so it
# fails fast if nvcc / the CUDA compiler is missing from the build environment.
nvcc --version

mkdir -p "${PREFIX}/bin"
nvcc "${RECIPE_DIR}/hello.cu" -o "${PREFIX}/bin/qa-cuda-hello"
