Alpine 实践
================================================================================

Alpine 因其镜像小巧而大受欢迎，但

* Alpine 使用 musl 库，可能存在兼容问题，部分库没有安装包，如 pip 可能
*


参考文档
--------------------------------------------------------------------------------

* 软件包管理： https://wiki.alpinelinux.org/wiki/Alpine_Package_Keeper


软件管理
--------------------------------------------------------------------------------

更换软件源

    .. code-block:: bash

        cp /etc/apk/repositories /etc/apk/repositories.bak
        sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories


查看依赖

    .. code-block:: bash

        ~$ apk info -R alpine-sdk
        alpine-sdk-1.0-r1 depends on:
        abuild
        build-base
        git


依赖管理

    .. code-block:: bash

        apk add --no-cache --virtual .build-deps alpine-sdk
        apk del .build-deps


* --no-cache: 避免建立缓存
* --virtual .build-deps: 创建虚拟包，后续编译依赖可以直接删除
