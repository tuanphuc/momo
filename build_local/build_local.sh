#!/bin/bash

cd "$(dirname $0)"

INSTALL_DIR="$(pwd)/local/_install"

# ./local/install_deps_local.sh

source ../VERSION

if [ -z "$JOBS" ]; then
    JOBS=$(nproc)
    if [ -z "$JOBS" ]; then
        JOBS=1
    fi
fi

mkdir -p ../_build/local
pushd ../_build/local
cmake \
    -DCMAKE_BUILD_TYPE=Release \
    -DMOMO_VERSION="$MOMO_VERSION" \
    -DMOMO_COMMIT="$MOMO_COMMIT" \
    -DWEBRTC_BUILD_VERSION="$WEBRTC_BUILD_VERSION" \
    -DWEBRTC_READABLE_VERSION="$WEBRTC_READABLE_VERSION" \
    -DWEBRTC_COMMIT="$WEBRTC_COMMIT" \
    -DTARGET_OS="linux" \
    -DTARGET_OS_LINUX="ubuntu-18.04" \
    -DTARGET_ARCH="x86_64" \
    -DUSE_SDL2=ON \
    -DBOOST_ROOT_DIR=$INSTALL_DIR/boost \
    -DJSON_ROOT_DIR=$INSTALL_DIR/json \
    -DCLI11_ROOT_DIR=$INSTALL_DIR/CLI11 \
    -DSDL2_ROOT_DIR=$INSTALL_DIR/SDL2 \
    -DWEBRTC_INCLUDE_DIR=$INSTALL_DIR/webrtc/include \
    -DWEBRTC_LIBRARY_DIR=$INSTALL_DIR/webrtc/lib \
    -DCLANG_ROOT=$INSTALL_DIR/llvm/clang \
    -DUSE_LIBCXX=ON \
    -DLIBCXX_INCLUDE_DIR=$INSTALL_DIR/llvm/libcxx/include \
    ../..

cmake --build . -j $JOBS
popd
