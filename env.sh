#!/bin/bash

# Template from https://github.com/gwaycc/goapp

# Export environment for building or runing program
# -------------------------------------------------
export PRJ_ROOT=`pwd`
export PRJ_NAME="goapp"
export GOBIN=$PRJ_ROOT/bin
export GO111MODULE=on

# Setting directory of sup [command] all, split with space for multiply directory.
export BUILD_ALL_PATH="$PRJ_ROOT/service/app $PRJ_ROOT/applet/web"

# Setting supd program params configuration
## --------------------START-------------------
export SUP_USER=$USER # default is $USER
export SUP_ETC_DIR="/etc/supd/conf.d" # default is /etc/supd/conf.d
export SUP_LOG_SIZE="10MB"
export SUP_LOG_BAK="10"
export SUP_APP_ENV="PRJ_ROOT=\\\"$PRJ_ROOT\\\",GIN_MODE=\\\"release\\\",LD_LIBRARY_PATH=\\\"$LD_LIBRARY_PATH\\\""

# Seting collection to sup publish
# -------------------------------------------------
## Root directory to colect of project. default is etc, split with space for multiply directory.
export PUB_ROOT_RES="etc" 
## App directory to colect of application. default is public, split with space for multiply directory.
export PUB_APP_RES="public" 

# Setting GOROOT
# -------------------------------------------------
go_root="/usr/local/go"
if [ -d "$go_root" ]; then
    export GOROOT="$go_root"
fi

# Setting GOBIN and PATH
# -------------------------------------------------
bin_path=$GOBIN:$GOROOT/bin:
rep=${PATH/bin_path/""}
if [ ! "$PATH" = "$rep" ]; then
    PATH=$rep 
fi
export PATH=$bin_path$PATH

# Download sup to manage project
# -------------------------------------------------
if [ ! -f $GOBIN/sup ]; then
    type curl >/dev/null 2>&1||{ echo -e >&2 "curl not found, need install at first."; exit 0; }
    echo "Download sup to bin."
    mkdir -p $GOBIN&& \
    curl https://raw.githubusercontent.com/gwaycc/supd/v1/bin/sup -o $GOBIN/sup && \
    chmod +x $GOBIN/sup&&echo "Download sup done."|| exit 0

    # Close golang verify
    go env -w GOPROXY=direct
    go env -w GOSUMDB=off
fi
# --------------------END--------------------

echo "Env have changed to \"$PRJ_NAME\""
echo "Using \"sup help\" to manage project"
# -------------------------------------------------

