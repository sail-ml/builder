#!/bin/bash

set -ex

chmod +x ./tools/install_avx2.sh
chmod +x ./tools/install_boost.sh
chmod +x ./tools/install_cmake.sh
chmod +x ./tools/install_gcc.sh

# ./builder/install_avx2.sh
./tools/install_boost.sh
./tools/install_cmake.sh
./tools/install_gcc.sh