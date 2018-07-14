
# 说明

本项目管理基于多个GOPATH进行管理，在个人实践过程中发现以项目为单位更有利于资源的管理.

当前，包版本依赖的问题可通过依赖工具(例如dep等)或直接复制过来使用即可。

关于集群部署，请参考[docker](https://yeasy.gitbooks.io/docker_practice/content)，但小项目或项目前期上集群会拖慢项目的调试与迭代速度，建议达到一定规模后再给予考虑。

golang是一门服务器语言，虽然对多平台是支持的，但部署仍建议在linux上，本项目管理的阅读设定认为你已经拥有linux下的go基本开发能力后而阅读的。


# 内容

## 一，项目构建(复制以下单行指令即可执行)

### 1, 新建一个项目
``` text
    mkdir -p ~/ws
    cd ~/ws/
    git clone https://github.com/gwaycc/goapp.git test
    cd test
    ./init.sh # 输入test，输Y新建一个项目，输n保留模板原文件
    source env.sh
    cd src
    mkdir -p service/app
    cd service/app

    # 构建main.go
    echo "
package main

import (
	\"fmt\"
	\"os\"
	\"os/signal\"
)

func main() {
	fmt.Println(\"OK\")

	fmt.Println(\"[ctrl+c to exit]\")
	end := make(chan os.Signal, 2)
	signal.Notify(end, os.Interrupt, os.Kill)
	<-end
}
    ">main.go

    # 运行app(开发模式)
    gofmt -w .
    go build #(若有依赖，可配置.goget自定义库地址并使用sup get拉取)
    ./app

    # 完成
```

### 2, 已有的sup项目
``` text
    mkdir -p ~/ws
    cd ~/ws/
    git clone https://github.com/gwaycc/goapp.git
    cd goapp
    source env.sh
    sup get all # 下载依赖
    sup build all # 编译项目
```
    
# 二，项目结构
``` text
$GOROOT -- 编译器放在/usr/local当中，多个版本时，以go1.4，go1.5等进行放置，由项目的env.sh进行切换。
$GOLIB -- 第一级GOPATH的路径变量，作为公共库存放第三方基础库源码,通过goget来管理。
$PRJ_ROOT -- 当前项目的所在位置，与$GOLIB同一级。
    .gitignore -- git的忽略管理文件，根据实际项目来看，许多新人会误提交，因此采用守护模式进行工作。
    .goget -- goget配置文件
    env.sh -- 项目环境变量配置，开发时，调source env.sh可进行项目环境切换。
    var -- 变量文件存放目录
        -- log 存放supervisor的控制台日志文件。
    etc -- 静态配置文件目录
    publish -- 非源码部署的项目结构
    src -- 项目源码。
        -- applet 应用层
            -- 应用包名
        -- service 服务层
            -- 服务包名
        -- module 组件层
            -- 组件包名
```

# 三，GOPATH管理
```text
$GOPATH=$GOLIB:$PRJ_ROOT -- $GOLIB在第一位，以便go get安装第三方库;$PRJ_ROOT是可变的，由env.sh进行切换管理
```

# 四，发布与部署项目
## 1, 在部署的服务器上安装supervior工具
``` text
debian: sudo aptitude install supervisor

* 目前自动识别了Debian与CentOS，其他系统需要时可编辑env.sh的SUP_ETC_DIR目录位置, 该位置用于存放supervisord的配置文件

```
## 2, 源码部署
```text
    # 在需要部署的服务器上下载源码库，并执行以下指令
    
    cd $PRJ_ROOT
    source env
    # 检查依赖
    sup get all
    # 编译
    sup build all
    # 部署应用
    # 将supervisor的配置文件安装至$SUP_ETC_DIR目录并部署
    sup install all
    # 删除supervisor的配置文件安装至$SUP_ETC_DIR目录及部署
    sup clean all
```

## 3, 非源码部署的方式
```text
    # 打包版本
    # 若未安装依赖，请先sup get all
    sup publish all
    cd $PRJ_ROOT/publish
    tar -czf $PJNAME.tar.gz $PJNAME
    # 上传到需要部署的服务器

    cd $PRJ_ROOT
    source env.sh
    # 部署应用
    # 将supervisor的配置文件安装至$SUP_ETC_DIR目录并部署
    sup install all
    # 删除supervisor的配置文件安装至$SUP_ETC_DIR目录及部署
    sup clean all
```

## 4, docker镜像构建的方式
```text
source env.sh
./dbuild.sh
```

## 5, 部署上的调试模式
```text
进入指定的app, 执行:
    sup stop # 停止supervisor管理
    ./app # 以开发的方式启动，日志在控制台输出
```

## 6, 部署时的控制台日志查看
```text
    sup tail [$cfg_name stdout] # 查看输出状态0的输出，等价于 sudo supervisorctrl tail $cfg_name stdout
    sup tail $cfg_name stderr # 查看输出状态非0的输出，等价于 sudo supervisorctrl tail $cfg_name stderr
    sup tailf [$cfg_name stdout] # 查看输出状态0的输出，等价于 sudo supervisorctrl tail -f $cfg_name stdout
    sup tailf $cfg_name stderr # 查看输出状态非0的输出，等价于 sudo supervisorctrl tail -f $cfg_name stderr

    # 或者进入$PRJ_ROOT/var/log/ 用系统的tail命令查看相关日志文件
```


## 其他详见sup help
```text
详情参考https://github.com/gwaycc/sup
```

# 四, 管理发布进程
```text
进入项目根目录，执行source env.sh，使用sup命令进行管理；或者使用supervisorctl命令进行管理进程
```

