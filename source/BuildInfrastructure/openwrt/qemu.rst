使用 QEMU 启动 OpenWrt 系统
================================================================================

准备工作
--------------------------------------------------------------------------------

创建工作目录并下载必要的文件：

.. code-block:: bash

    # 创建工作目录
    mkdir -p openwrt_qemu
    cd openwrt_qemu

    # 下载 OpenWrt 镜像
    wget https://downloads.openwrt.org/snapshots/targets/x86/64/openwrt-x86-64-generic-rootfs.tar.gz
    wget https://downloads.openwrt.org/snapshots/targets/x86/64/openwrt-x86-64-generic-kernel.bin

    # 解压根文件系统
    mkdir -p openwrt_rootfs
    tar -xzf openwrt-x86-64-generic-rootfs.tar.gz -C openwrt_rootfs

创建磁盘镜像
--------------------------------------------------------------------------------

创建并配置磁盘镜像：

.. code-block:: bash

    # 创建空的磁盘镜像文件（1GB）
    dd if=/dev/zero of=rootfs.ext3 bs=1M count=1024

    # 格式化为 ext3 文件系统
    mkfs.ext3 rootfs.ext3

    # 挂载并复制文件
    mkdir -p fs
    sudo mount -o loop rootfs.ext3 fs
    sudo cp -rf openwrt_rootfs/* fs/
    sudo umount fs

    # 压缩镜像（可选）
    gzip --best -c rootfs.ext3 > rootfs.img.gz

启动 QEMU
--------------------------------------------------------------------------------

使用 QEMU 启动 OpenWrt：

.. code-block:: bash

    # 使用未压缩的镜像启动
    qemu-system-x86_64 \
        -enable-kvm \
        -kernel openwrt-x86-64-generic-kernel.bin \
        -drive file=rootfs.ext3,format=raw \
        -append "root=/dev/sda console=ttyS0" \
        -nographic \
        -m 512M \
        -net nic,model=virtio \
        -net user

    # 或者直接使用压缩的镜像启动
    qemu-system-x86_64 \
        -enable-kvm \
        -kernel openwrt-x86-64-generic-kernel.bin \
        -drive file=rootfs.img.gz,format=raw \
        -append "root=/dev/sda console=ttyS0" \
        -nographic \
        -m 512M \
        -net nic,model=virtio \
        -net user

登录和配置
--------------------------------------------------------------------------------

启动完成后，进行以下配置：

1. 使用默认用户名 ``root`` 登录（初始无密码）

2. 设置 root 密码：

   .. code-block:: bash

       passwd

3. 配置网络：

   .. code-block:: bash

       # 查看网络接口
       ifconfig

       # 配置网络（如果需要）
       uci set network.lan.ipaddr='192.168.1.1'
       uci commit
       /etc/init.d/network restart

注意事项
--------------------------------------------------------------------------------

1. 确保有足够的磁盘空间（示例中创建了 1GB 的镜像）

2. 如果启动失败，可以添加 ``-d int`` 参数查看详细日志：

   .. code-block:: bash

       qemu-system-x86_64 -d int ...

3. 网络配置：

   - 默认使用用户模式网络（-net user）
   - 可以通过 ``-net nic,model=virtio`` 指定网卡类型
   - 如果需要桥接网络，可以使用 ``-net bridge`` 选项

4. 性能优化：

   - 可以增加内存大小（-m 参数）
   - 可以启用 KVM 加速（如果支持）：

     .. code-block:: bash

         qemu-system-x86_64 -enable-kvm ...

5. 调试技巧：

   - 使用 ``-serial stdio`` 替代 ``-nographic`` 可以在终端中看到串口输出
   - 添加 ``-S -s`` 参数可以启动调试模式，配合 gdb 进行调试
