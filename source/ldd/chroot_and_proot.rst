目录切换和镜像制作
================================================================================


chroot
--------------------------------------------------------------------------------
利用 chroot 可以模拟环境，制作镜像

.. code-block::

    install -d alpine-linux-x86-64

.. code-block::

    curl -LO https://dl-cdn.alpinelinux.org/alpine/v3.20/releases/x86_64/alpine-minirootfs-3.20.0-x86_64.tar.gz

.. code-block::

    tar vxf alpine-minirootfs-3.20.0-x86_64.tar.gz -C alpine-linux-x86-64

网络不通解决方案

.. code-block::

    echo "nameserver 114.114.114.114" > /etc/resolv.conf

.. code-block::

    sudo chroot alpine-linux-x86-64 apk update
    sudo chroot alpine-linux-x86-64 apk add bash
    sudo chroot alpine-linux-x86-64 bash

    sudo chroot alpine-linux-x86-64 /bin/env -i \
    HOME=/root \
    TERM="$TERM" \
    PS1='(lfs chroot) \u:\w\$ ' \
    PATH=/bin:/usr/bin:/sbin:/usr/sbin:/tools/bin \
    /bin/sh --login



proot
--------------------------------------------------------------------------------

proot 和 chroot 类似，但不需要 privileges 权限

我简单的复制了以下代码，chroot 也能使用 qemu，这不是两者的差异

https://github.com/proot-me/proot

.. code-block::

    proot -q qemu-aarch64 -S alpine-linux-aarch64 apk add bash

    proot -q qemu-aarch64 -S alpine-linux-aarch64 bash

    proot -q qemu-aarch64 -S alpine-linux-aarch64 /bin/env -i \
    HOME=/root \
    TERM="$TERM" \
    PS1='(lfs chroot) \u:\w\$ ' \
    PATH=/bin:/usr/bin:/sbin:/usr/sbin:/tools/bin \
    /bin/sh --login
