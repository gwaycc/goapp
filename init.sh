#!/bin/sh

export GO111MODULE=on
go_root="/usr/local/go"
if [ -d "$go_root" ]; then
    export GOROOT="$go_root"
fi
# 将GOBIN加入PATH
bin_path=$GOROOT/bin:

rep=$(echo $PATH|awk '{print gensub("'$bin_path'","",1)}')
if [ ! "$PATH" = "$rep" ]; then
    PATH=$rep # 重新设定原值的位置
fi
export PATH=$bin_path$PATH

echo -n '#' "Your Project Name : "
read project_name

echo $project_name
cat env.sh|awk '{print gensub("goapp","'$project_name'",1)}'>tmp.sh
cp tmp.sh env.sh
rm tmp.sh

echo '#' "Init Done"
echo '#'
echo '#' "You should edit env.sh when used, some command need special environment."
echo '#' "'SUP_BUILD_PATH' environment for 'sup build all' in env.sh "
echo '#' "'SUP_APP_ENV' environment for 'sup install' in env.sh "
echo '#' "'PUB_ROOT_RES' environment for 'sup publish' in env.sh "
echo '#' "'PUB_APP_RES' environment for 'sup publish' in env.sh "
echo '#'
echo '#' "Using 'source env.sh' to loading environment of project"

# This example shows how to prompt for user's input.
echo -n '#' "Clean template data?[Y/n]"
read ANS
case $ANS in
    Y)
        rm init.sh
        rm -rf .git
        rm -rf applet
        rm -rf module
        rm -rf service
        rm go.mod
        rm go.sum
        go mod init $project_name
        exit 0
        ;;
esac

