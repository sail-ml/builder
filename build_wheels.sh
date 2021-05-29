#!/bin/bash
set -e -u -x

function repair_wheel {
    wheel="$1"
    if ! auditwheel show "$wheel"; then
        echo "Skipping non-platform wheel $wheel"
    else
        auditwheel repair "$wheel" --plat "$PLAT" -w /io/wheelhouse/
    fi
}


# Install a system package required by our library

cd io
git clone https://github.com/sail-ml/sail
rm -rf io/wheelhouse/*

ls

cd sail
rm -rf build/*
git submodule update --init


cd ..
./tools/install.sh
yum -y install blas-devel

# Compile wheels
for PYBIN in /opt/python/*/bin; do
    if [[ "$PYBIN" == *"cp36"* || "$PYBIN" == *"cp37"* || "$PYBIN" == *"cp38"* ]]; then
    # if [[ "$PYBIN" != *"cp27"* ]]; then

        "${PYBIN}/pip" install -r /io/sail/requirements.txt
        "${PYBIN}/pip" install -r /io/sail/requirements-dev.txt
        # "${PYBIN}/python3" io/setup.py bdist_wheel sdist -d wheelhouse/
        "${PYBIN}/pip" wheel /io/sail/ --no-deps -w wheelhouse/
    fi
done


rm -rf sail
