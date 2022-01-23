
# 说明

本项目管理基于go module管理， 使用. env.sh 或 source env.sh进行环境变量切换。

本部署默认采用supd(目前只自动识别了debian系列及centos系列的配置安装)。

docker部署，请参考[docker](https://yeasy.gitbooks.io/docker_practice/content)，但小项目或项目前期上集群会拖慢项目的调试与迭代速度，建议达到一定规模后再给予考虑。

golang是系统级语言，当前更多是用于服务器开发，虽然对多平台是支持的，但服务器部署仍建议在linux上做，本项目管理的阅读设定认为你已经熟悉基本的linux与go指令。

# GO版本依赖
go1.12版本及以上

# 内容

## 一，项目构建(复制以下单行指令即可执行)

### 1, 新建一个项目
``` text
    mkdir -p ~/ws
    cd ~/ws/
    git clone https://github.com/gwaycc/goapp.git test
    cd test
    ./init.sh # 输入test，输Y新建一个项目，输n保留模板原文件
    . env.sh # 或source env.sh
    mkdir -p cmd/app
    cd cmd/app
    # 构建main.go
    echo '
        package main
        
        import (
        	"fmt"
        	"os"
        	"os/signal"
        )
        
        func main() {
        	fmt.Println("OK")
        
        	fmt.Println("[ctrl+c to exit]")
        	end := make(chan os.Signal, 2)
        	signal.Notify(end, os.Interrupt, os.Kill)
        	<-end
        }
    '>main.go

    # 运行app(开发模式)
    gofmt -w .
    go build #(或执行sup build)
    ./app

    # ctrl+c退出
```

### 2, 已有的sup项目
``` text
    mkdir -p ~/ws
    cd ~/ws/
    git clone https://github.com/gwaycc/goapp.git
    cd goapp
    source env.sh
    sup build all # 编译项目
```
    
# 二，项目结构
``` text
$GOROOT -- 编译器放在/usr/local当中，多个版本时，以go1.4，go1.5等进行放置，由项目的env.sh进行切换。
$PRJ_ROOT -- 当前项目的所在位置，与$GOLIB同一级。
    .gitignore -- git的忽略管理文件。
    dbuild.sh -- 构建docker镜像，需先安装docker。
    drun.sh   -- 临时运行docker镜像，以便方便调试
    env.sh -- 项目环境变量配置，开发时，调source env.sh可进行项目环境切换。
    go.mod -- go module依赖数据
    module 项目专用的组件层
        -- 组件包名
    cmd 项目的应用main程序
        -- 应用包名
    var -- 变量文件存放目录
        -- log 存放supd的控制台日志文件。
    etc -- 静态配置文件目录
    publish -- 非源码部署的项目结构
```

# 三，发布与部署项目
## 1, 在部署的服务器上安装supd工具

https://github.com/gwaycc/supd

* sup目前仅自动识别了Debian与CentOS，其他系统需要时可编辑env.sh的SUP_ETC_DIR目录位置, 该位置用于存放supervisord的配置文件

## 2, 源码部署
```text
    # 在需要部署的服务器上下载源码库，并执行以下指令
    
    cd $PRJ_ROOT
    source env.sh
    # 编译
    sup build all
    # 部署应用
    # 将supervisor的配置文件安装至$SUP_ETC_DIR目录并部署
    sup install all
    # 查看状态
    sup status
    # 删除supervisor的配置文件安装至$SUP_ETC_DIR目录及部署
    sup clean all
```

## 3, 非源码部署的方式
```text
    # 打包版本
    # 若未安装依赖，请先sup get all
    sup publish all
    cd $PRJ_ROOT/publish
    tar -czf $PRJ_NAME.tar.gz $PRJ_NAME
    # 上传到需要部署的服务器

    cd $PRJ_ROOT
    source env.sh
    # 部署应用
    # 将supervisor的配置文件安装至$SUP_ETC_DIR目录并部署
    sup install all
    # 查看状态
    sup status
    # 删除supervisor的配置文件安装至$SUP_ETC_DIR目录及部署
    sup clean all
```

## 4, docker镜像构建的方式
需要首先安装docker
```text
. env.sh
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
    sup tail [$cfg_name stdout] # 查看输出状态0的输出，等价于 sudo supd ctl tail $cfg_name stdout
    sup tail $cfg_name stderr # 查看输出状态非0的输出，等价于 sudo supd ctl tail $cfg_name stderr
    sup tailf [$cfg_name stdout] # 查看输出状态0的输出，等价于 sudo supd ctl tail -f $cfg_name stdout
    sup tailf $cfg_name stderr # 查看输出状态非0的输出，等价于 sudo supd ctl tail -f $cfg_name stderr

    # 或者进入$PRJ_ROOT/var/log/ 用系统的tail命令查看相关日志文件
```


## 其他详见sup help
```text
详情参考https://github.com/gwaycc/supd
```

