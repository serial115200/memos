Docker Alpine 镜像
================================================================================

参考文档：

* 软件包管理：https://wiki.alpinelinux.org/wiki/Alpine_Package_Keeper

构建 rootfs
--------------------------------------------------------------------------------
https://github.com/alpinelinux/alpine-make-rootfs


更换软件源
--------------------------------------------------------------------------------

    .. code-block:: bash

        cp /etc/apk/repositories /etc/apk/repositories.bak
        sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories


软件管理
--------------------------------------------------------------------------------

查看软件依赖，以 alpine-sdk 为例，它是 build-base 的超集

    .. code-block:: bash

        ~$ apk info -R alpine-sdk
        alpine-sdk-1.0-r1 depends on:
        abuild
        build-base
        git


编译依赖安装与卸载

    .. code-block:: bash

        apk add --no-cache --virtual .build-deps alpine-sdk
        apk del --no-cache .build-deps


* --no-cache: 避免建立缓存
* --virtual .build-deps: 创建虚拟包，后续编译依赖可以直接删除
