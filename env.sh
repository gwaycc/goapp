#!/bin/sh

# init from https://github.com/gwaycc/goapp/blob/master/init.sh

# 项目需要导出的程序环境变量
# -------------------------------------------------
export PRJ_ROOT=`pwd`
export PRJ_NAME="goapp"
export GOLIB="$(dirname "$PRJ_ROOT")/golib" # 作为公共库使用
export GOPATH=$GOLIB:$PRJ_ROOT
export GOBIN=$PRJ_ROOT/bin
export GO111MODULE=on

# 设定sup [command] all 所遍历的目录
export BUILD_ALL_PATH="$PRJ_ROOT/src/service/demo $PRJ_ROOT/src/applet/web"

# supervisord配置文件参数
# --------------------START-------------------
# 以下是部署时的supervisor默认配置数据，若未配置时，会使用以下默认数据
# 开发IDE可不配置以下环境变量
# 配置supervisor的配置文件目录
# export SUP_ETC_DIR="/etc/supervisor/conf.d/" # (可选)
# 配置supervisor的子程序日志的单个文件最大大小
# export SUP_LOG_SIZE="10MB"
# 配置supervisor的子程序日志的最多文件个数
# export SUP_LOG_BAK="10"
# 配置supervisor配置中的environment环境变量
# export SUP_APP_ENV="PRJ_ROOT=\\\"$PRJ_ROOT\\\",GIN_MODE=\\\"release\\\",LD_LIBRARY_PATH=\\\"$LD_LIBRARY_PATH\\\""

# 设定publish指令打包时需要包含的文件夹环境变量
# -------------------------------------------------
# 默认会打包以下目录：$PRJ_ROOT/bin/* $PRJ_ROOT/src/app/app等二进制程序
# export PUB_ROOT_RES="etc" # 根目录下需要打包的文件夹列表，如"etc"等
# export PUB_APP_RES="public" # app下的文件夹列表，如"res public"等

# 更改路径可更改编译器的版本号, 如果未指定，使用系统默认的配置
go_root="/usr/local/go"
if [ -d "$go_root" ]; then
    export GOROOT="$go_root"
fi

# 将GOBIN加入PATH
bin_path=$GOBIN:$GOROOT/bin
if [[ ! $PATH == *$bin_path* ]]; then
    export PATH=$bin_path:$PATH
else
    export PATH=$bin_path:${PATH##*$bin_path:} # 如果已存在，重新设定环境环境变量
fi

# 构建项目目录
mkdir -p $PRJ_ROOT/src || exit 0
mkdir -p $PRJ_ROOT/etc || exit 0
mkdir -p $PRJ_ROOT/var || exit 0

# 下载sup管理工具
if [ ! -f $GOBIN/sup ]; then
    mkdir -p $GOBIN
    wget https://raw.githubusercontent.com/gwaylib/sup/v2.0/sup -O $GOBIN/sup && chmod +x $GOBIN/sup||exit -1
fi

# 设定git库地址转换, 以便解决私有库中https证书不可信的问题
# git config --global url."git@git.gwaycc.com:".insteadOf "https://git.gwaycc.com"
# 用于快速跳转文件变量
export github=$GOLIB/src/github.com
# --------------------END--------------------

echo "Env have changed to \"$PRJ_NAME\""
echo "Using \"sup help\" to manage project"
# -------------------------------------------------

