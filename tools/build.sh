#!/bin/bash

cd $ROOT_DIR

BUILD_DIR=$ROOT_DIR/build
INSTALL_DIR=$ROOT_DIR/install

if [[ ! $WLD ]]; then
   echo "Run prepare environment"
   echo "CMD: . $(pwd)/prepare_env.sh"
   exit
fi

if [[ -d $INSTALL_DIR ]]; then
   rm -r $INSTALL_DIR
fi
mkdir -p $INSTALL_DIR


# Wayland
WL_BUILD=$BUILD_DIR/wayland
if [[ -d $WL_BUILD ]]; then
   rm -r $WL_BUILD
fi
mkdir -p $WL_BUILD

cd $ROOT_DIR/wayland
meson $WL_BUILD --prefix=$WLD
ninja -C $WL_BUILD install


# Wayland-protocols
WL_PROTOCOL_BUILD=$BUILD_DIR/wayland-protocols
if [[ -d $WL_PROTOCOL_BUILD ]]; then
   rm -r $WL_PROTOCOL_BUILD
fi
mkdir -p $WL_PROTOCOL_BUILD

cd $ROOT_DIR/wayland-protocols
meson $WL_PROTOCOL_BUILD --prefix=$WLD
ninja -C $WL_PROTOCOL_BUILD install


# Weston
WESTON_BUILD=$BUILD_DIR/weston
if [[ -d $WESTON_BUILD ]]; then
   rm -r $WESTON_BUILD
fi
mkdir -p $WESTON_BUILD

cd $ROOT_DIR/weston
meson $WESTON_BUILD --prefix=$WLD \
   -Dbackend-rdp=false \
   -Dremoting=false \
   -Dpipewire=false
ninja -C $WESTON_BUILD install


# wayland-ivi-extension
WL_IVI_EXT_BUILD=$BUILD_DIR/wayland-ivi-extension
if [[ -d $WL_IVI_EXT_BUILD ]]; then
   rm -r $WL_IVI_EXT_BUILD
fi
mkdir -p $WL_IVI_EXT_BUILD

cd $WL_IVI_EXT_BUILD

cmake $WL_IVI_EXT_BUILD \
   -DCMAKE_INSTALL_PREFIX=$WLD \
   $ROOT_DIR/wayland-ivi-extension
make install -j8