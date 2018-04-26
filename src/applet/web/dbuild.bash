# /bin/sh

# # run docker mode

# build bin data
CGO_ENABLED=0 GOOS=linux go build -o app . || exit 1
# remove old images
{ pwd_dir=`pwd` app_name=`basename \$pwd_dir` app_path="${pwd_dir#/*src/}" cfg_name="$PJ_NAME.${app_path//\//.}"; sudo docker rmi -f $cfg_name;}
# build images
{ pwd_dir=`pwd` app_name=`basename \$pwd_dir` app_path="${pwd_dir#/*src/}" cfg_name="$PJ_NAME.${app_path//\//.}"; sudo docker build -q -t $cfg_name .;} || exit 1
# rm tmp data
# rm app

# show images build result
{ pwd_dir=`pwd` app_name=`basename \$pwd_dir` app_path="${pwd_dir#/*src/}" cfg_name="$PJ_NAME.${app_path//\//.}"; sudo docker images $cfg_name;} || exit 1

# run for container 
{ pwd_dir=`pwd` app_name=`basename \$pwd_dir` app_path="${pwd_dir#/*src/}" cfg_name="$PJ_NAME.${app_path//\//.}"; sudo docker run -it --rm --net=host -v /etc/localtime:/etc/localtime:ro -v $PJ_ROOT/etc:/app/etc -v $PJ_ROOT/var:/app/var -e CODEIN_APP_CONFIG=/app/etc/app.yaml $cfg_name;}
# { pwd_dir=`pwd` app_name=`basename \$pwd_dir` app_path="${pwd_dir#/*src/}" cfg_name="$PJ_NAME.${app_path//\//.}"; sudo docker run -it --rm -p 7999:7999 -v /etc/localtime:/etc/localtime:ro -v $PJ_ROOT/etc:/app/etc -v $PJ_ROOT/var:/app/var -e CODEIN_APP_CONFIG=/app/etc/app.yaml $cfg_name;}

## run for service
# { pwd_dir=`pwd` app_name=`basename \$pwd_dir` app_path="${pwd_dir#/*src/}" cfg_name="$PJ_NAME.${app_path//\//.}"; sudo docker service create --name=$PJ_NAME-$app_name  --network=host --mount=type=bind,src=/etc/localtime,dst=/etc/localtime --mount=type=bind,src=$PJ_ROOT/etc,dst=/app/etc --mount=type=bind,src=$PJ_ROOT/var,dst=/app/var $cfg_name;}
## delete for service
# { pwd_dir=`pwd` app_name=`basename \$pwd_dir` app_path="${pwd_dir#/*src/}" cfg_name="$PJ_NAME.${app_path//\//.}"; sudo docker service rm $PJ_NAME-$app_name;}

# delete docker image in local, need stop container at first.
{ pwd_dir=`pwd` app_name=`basename \$pwd_dir` app_path="${pwd_dir#/*src/}" cfg_name="$PJ_NAME.${app_path//\//.}"; sudo docker rmi $cfg_name;}

#
# # run for release container
# { pwd_dir=`pwd` app_name=`basename \$pwd_dir` app_path="${pwd_dir#/*src/}" cfg_name="$PJ_NAME.${app_path//\//.}"; sudo docker run -d --restart=always --name $cfg_name --net=host -v $PJ_ROOT/etc:/app/etc -v $PJ_ROOT/var:/app/var $cfg_name;}
# { pwd_dir=`pwd` app_name=`basename \$pwd_dir` app_path="${pwd_dir#/*src/}" cfg_name="$PJ_NAME.${app_path//\//.}"; sudo docker logs -f $cfg_name;}
# { pwd_dir=`pwd` app_name=`basename \$pwd_dir` app_path="${pwd_dir#/*src/}" cfg_name="$PJ_NAME.${app_path//\//.}"; sudo docker rm -f $cfg_name;}
# # delete docker image in local, need stop container at first.
# { pwd_dir=`pwd` app_name=`basename \$pwd_dir` app_path="${pwd_dir#/*src/}" cfg_name="$PJ_NAME.${app_path//\//.}"; sudo docker rmi $cfg_name;}

# # auto clean <none> images
# sudo docker rmi -f $(docker images | grep "none" | awk '{print $3}')
# # auto clean <none> containers
#
# end
