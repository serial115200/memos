chroot 使用
================================================================================

**创建工作目录/创建 rootfs 环境**

.. code-block::

    mkdir -p alpine-linux-x86-64

.. code-block::

    curl -O https://dl-cdn.alpinelinux.org/alpine/v3.23/releases/x86_64/alpine-minirootfs-3.23.2-x86_64.tar.gz

.. code-block::

    tar -vxf alpine-minirootfs-3.23.2-x86_64.tar.gz -C alpine-linux-x86-64


**配置 DNS**

.. code-block::

    cp /etc/resolv.conf alpine-linux-x86-64/etc/resolv.conf
    # 或使用自定义 DNS
    echo "nameserver 114.114.114.114" > alpine-linux-x86-64/etc/resolv.conf


**挂载文件系统**

.. code-block::

    sudo mount -t proc /proc alpine-linux-x86-64/proc
    sudo mount --rbind /sys  alpine-linux-x86-64/sys
    sudo mount --make-rprivate alpine-linux-x86-64/sys
    sudo mount --rbind /dev  alpine-linux-x86-64/dev
    sudo mount --make-rprivate alpine-linux-x86-64/dev

- `/proc` 是虚拟文件系统，可以挂载到多个不同的挂载点
- `/sys` 是虚拟文件系统，普通 `bind` 只绑定目录本身，不会递归绑定子目录，必须使用 `--rbind` 挂载
- `/dev` 是设备文件系统，普通 `bind` 只绑定目录本身，不会递归绑定子目录，必须使用 `--rbind` 挂载
- `--make-rprivate` 是私有模式，否则可能卸载失败，target is busy


**进入 chroot 环境**

.. code-block::

    # 单个命令
    sudo chroot alpine-linux-x86-64 apk update
    sudo chroot alpine-linux-x86-64 apk add bash

    # 多个命令（使用 sh -c）
    sudo chroot alpine-linux-x86-64 /bin/sh -c "apk update && apk add bash"

    # 多个命令（使用 heredoc，需要指定 shell）
    sudo chroot alpine-linux-x86-64 /bin/sh <<EOF
    apk update
    apk add bash
    EOF

    # 直接进入 shell（如果已安装 bash）
    sudo chroot alpine-linux-x86-64 /bin/bash
    # 或者使用默认的 sh
    sudo chroot alpine-linux-x86-64 /bin/sh


`chroot` 的语法是 `chroot NEWROOT [COMMAND]`。如果不指定 COMMAND，chroot会尝试执行
默认的 shell（通常是 `/bin/sh`）。使用 heredoc 时必须明确指定 shell 路径
（如 `/bin/sh`），否则会报错。


**退出 chroot 环境**

.. code-block::

    sudo umount --recursive alpine-linux-x86-64/proc
    sudo umount --recursive alpine-linux-x86-64/sys
    sudo umount --recursive alpine-linux-x86-64/dev


**跨架构 chroot**

.. code-block::

    mkdir -p alpine-linux-aarch64
    curl -O https://dl-cdn.alpinelinux.org/alpine/v3.23/releases/aarch64/alpine-minirootfs-3.23.2-aarch64.tar.gz
    tar -vxf alpine-minirootfs-3.23.2-aarch64.tar.gz -C alpine-linux-aarch64

    cp /etc/resolv.conf alpine-linux-aarch64/etc/resolv.conf

    sudo mount -t proc /proc alpine-linux-aarch64/proc
    sudo mount --rbind /sys  alpine-linux-aarch64/sys
    sudo mount --make-rprivate alpine-linux-aarch64/sys
    sudo mount --rbind /dev  alpine-linux-aarch64/dev
    sudo mount --make-rprivate alpine-linux-aarch64/dev

    # 使用 qemu-aarch64 运行 chroot 环境
    # 1. 先安装 qemu-user-static（如果未安装）
    # sudo apt install qemu-user-static

    # 2. 查找 qemu-aarch64 的位置（通常是 qemu-aarch64-static）
    # which qemu-aarch64-static
    # 或者查找所有可能的路径
    # find /usr -name "qemu-aarch64*" -type f

    # 3. 复制 qemu 二进制文件到 chroot 环境（使用静态版本，不依赖动态库）
    cp /usr/bin/qemu-aarch64-static alpine-linux-aarch64/usr/bin/

    # 4. 使用完整路径运行命令
    sudo chroot alpine-linux-aarch64 /usr/bin/qemu-aarch64-static /bin/sh -c "apk update"
    sudo chroot alpine-linux-aarch64 /usr/bin/qemu-aarch64-static /bin/sh -c "apk add bash"

    # 5. 进入 shell
    sudo chroot alpine-linux-aarch64 /usr/bin/qemu-aarch64-static /bin/sh
    sudo chroot alpine-linux-aarch64 /usr/bin/qemu-aarch64-static /bin/bash

    sudo umount --recursive alpine-linux-aarch64/proc
    sudo umount --recursive alpine-linux-aarch64/sys
    sudo umount --recursive alpine-linux-aarch64/dev
