# /bin/sh

GOSPACE=$GOSPACE
PJ_NAME=$PJ_NAME

# debug run
sudo docker run -it --rm \
    -v $GOSPACE/etc:/app/etc \
    -v $GOSPACE/var/log:/app/var/log \
    --net=host \
    $PJ_NAME

# # for release
# GOSPACE=`pwd`
# PJ_NAME="goapp"
# ver=0.1
#
# # 请手工按步骤调用发布
# # 阿里参考资料：https://help.aliyun.com/document_detail/51810.html?spm=5176.11065259.1996646101.searchclickresult.260e6e5cpqIABR
# #  sudo docker login --username=zhoushuyue@codein registry.cn-shenzhen.aliyuncs.com
# #  sudo docker tag [ImageId] registry.cn-shenzhen.aliyuncs.com/codein/lserver:[镜像版本号]
# #  sudo docker push registry.cn-shenzhen.aliyuncs.com/codein/lserver:[镜像版本号]
#
# # Docker参考资料：https://blog.csdn.net/boonya/article/details/74906927
# # sudo docker login 
# # sudo docker tag [imageid] gwaycc/$PJ_NAME:$ver
# # sudo docker push gwaycc/$PJ_NAME:$ver
# 
# sudo docker pull gwaycc/$PJ_NAME:$ver
# 
# sudo docker run -d --restart=always \
#     -v /etc/localtime:/etc/localtime:ro \
#     -v $pwd_dir/etc:/app/etc \
#     -v $pwd_dir/var/log:/app/var/log \
#     -e GOSPACE=/app \
#     -e GIN_MODE=release \
#     -w /app/src/service/app \
#     --name $PJ_NAME-service-app \
#     --net=host \
#     gwaycc/$PJ_NAME:$ver \
#     ./app
# 
# sudo docker run -d --restart=always \
#     -v /etc/localtime:/etc/localtime:ro \
#     -v $pwd_dir/etc:/app/etc \
#     -v $pwd_dir/var/log:/app/var/log \
#     -e GOSPACE=/app \
#     -e GIN_MODE=release \
#     -w /app/src/applet/web \
#     --name $PJ_NAME-service-web \
#     --net=host \
#     gwaycc/$PJ_NAME:$ver \
#     ./web

