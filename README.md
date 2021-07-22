# docker-linux-cpp

[![Build Status](https://travis-ci.org/madduci/docker-linux-cpp.svg?branch=master)](https://travis-ci.org/madduci/docker-linux-cpp)

基于docker的C++和Python远程开发环境

## 要求

* Docker (possibly the latest version)

## 构建和运行docker镜像和容器
`docker-compose -f docker-compose.yaml up -d`


## 创建python虚拟环境
`conda create -p ~/.conda/envs/test python=3.6`

因为docker容器中禁止了用户对`/usr/local/miniconda3/envs/`的写入权限，所以不能使用以下方式创建容器：
`conda create -n test python=3.6`

## CLion Docker Remote配置

- 启动容器后(容器内要开启SSH)

- CLion: 设置 -> 构建、执行、部署  -> 工具链  -> 左侧 + 号 (选择远程主机) -> 凭据(设置SSH信息)

  剩下就等CLion自己识别即可。

![image-20210722144012961](https://joplin-pic.oss-cn-shanghai.aliyuncs.com/img/image-20210722144012961.png)

![image-20210722144405445](https://joplin-pic.oss-cn-shanghai.aliyuncs.com/img/image-20210722144405445.png)

- 设置CMake

![image-20210722144835304](https://joplin-pic.oss-cn-shanghai.aliyuncs.com/img/image-20210722144835304.png)

- 设置部署

![image-20210722145226712](https://joplin-pic.oss-cn-shanghai.aliyuncs.com/img/image-20210722145226712.png)

![image-20210722145544616](https://joplin-pic.oss-cn-shanghai.aliyuncs.com/img/image-20210722145544616.png)

![image-20210722145645456](https://joplin-pic.oss-cn-shanghai.aliyuncs.com/img/image-20210722145645456.png)

## TODO: VSCODE container remote 配置

