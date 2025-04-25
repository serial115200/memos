Docker (Ubuntu) 开发环境
================================================================================

https://docs.docker.com/engine/install/ubuntu


目前有多种 Docker 开发环境，可根据需求进行选择：

* Docker 与编译环境
* VsCode 的 Developing inside a Container


Docker 与编译环境
--------------------------------------------------------------------------------

Docker 镜像的特点对嵌入式开发环境而言，堪称完美：

* 不可变：编译环境统一，稳定
* 可分发：内部迁移方便，对外提供环境也方便
* 档案化： Docker 镜像基于 Dockerfile， 依赖关系清晰，还可做版本控制

:download:`docker_env.bash <env_docker.bash>`

.. literalinclude:: env_docker.bash
    :language: bash
    :linenos:


脚本解析：

    * 3 行，如果未指定镜像，则选择 ubuntu 镜像
    * -it 开启交互，并提供终端
    * --rm 退出即删除
    * 7 ~ 9 行，以只读方式挂在用户信息
    * 10 行，以当前用户登录
    * 11 行，在容器内制定工作目录
    * 12 行，挂载当前用户主目录至容器工作目录
    * 12 行，指定镜像，并启动 bash

为什么要这么做，当用户主目录挂在到容器工作目录后，容器和主机对用户主目录均有读写权限，但
此时容器默认以 root 用户运行，这导致编译过程产生的文件属于 root， 主机读取时需要修改权限
，切换其它任意用户都存在这样的问题。该方案直接映射用户和目录，并以当前用户登录。


Visual Studio Code Dev Containers
--------------------------------------------------------------------------------

这是上一个方案的加强版， 将工作目录映射到容器内， VScode 再远程到容器内。整个过程由
Visual Studio Code Dev Containers 插件实现，参数和配置由工作目录下的
.devcontainer/devcontainer.json 文件决定。

本节技术细节参考： https://code.visualstudio.com/docs/devcontainers/containers
