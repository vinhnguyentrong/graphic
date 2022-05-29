#!/bin/bash

export WLD=$HOME/install   # change this to another location if you prefer
export LD_LIBRARY_PATH=$WLD/lib/x86_64-linux-gnu
export PKG_CONFIG_PATH=$WLD/lib/x86_64-linux-gnu/pkgconfig/:$WLD/share/pkgconfig/
export PATH=$WLD/bin:$PATH
export PATH=$HOME/.local/bin:$PATH

export ROOT_DIR=$HOME/works
