使用 QEMU 启动 OpenWrt
==========================================

准备工作
----------------

创建工作目录并下载必要的文件：

.. code-block:: bash

    # 创建工作目录
    mkdir -p openwrt_qemu
    cd openwrt_qemu

    # 下载 OpenWrt 镜像（x86_64 架构）
    # 通用版本
    wget https://downloads.openwrt.org/snapshots/targets/x86/64/openwrt-x86-64-generic-rootfs.tar.gz
    wget https://downloads.openwrt.org/snapshots/targets/x86/64/openwrt-x86-64-generic-kernel.bin

    # 虚拟机专用版本
    wget https://downloads.openwrt.org/snapshots/targets/x86/64/openwrt-x86-64-virtio-rootfs.tar.gz
    wget https://downloads.openwrt.org/snapshots/targets/x86/64/openwrt-x86-64-virtio-kernel.bin

    # 解压根文件系统
    mkdir -p openwrt_rootfs
    tar -xzf openwrt-x86-64-generic-rootfs.tar.gz -C openwrt_rootfs

配置不同板子
----------------------------------------------------------------------------------------------------

OpenWrt 支持为同一 CPU 架构配置不同的板子。以下是配置步骤：

1. 创建板子配置文件：

   .. code-block:: bash

       # 创建板子配置目录
       mkdir -p target/linux/x86/64/config-4.14

       # 创建板子配置文件
       cat > target/linux/x86/64/config-4.14/CUSTOM_BOARD << EOF
       CONFIG_TARGET_x86_64=y
       CONFIG_TARGET_x86_64_CUSTOM_BOARD=y
       CONFIG_TARGET_IMAGES_GZIP=y
       CONFIG_TARGET_ROOTFS_EXT4FS=y
       CONFIG_TARGET_ROOTFS_SQUASHFS=y
       CONFIG_PACKAGE_kmod-virtio-balloon=y
       CONFIG_PACKAGE_kmod-virtio-net=y
       CONFIG_PACKAGE_kmod-virtio-pci=y
       CONFIG_PACKAGE_kmod-virtio=y
       EOF

2. 修改板子定义：

   .. code-block:: bash

       # 编辑板子定义文件
       cat > target/linux/x86/64/image/Makefile << EOF
       define Device/CUSTOM_BOARD
         DEVICE_TITLE := Custom Board
         DEVICE_PACKAGES := kmod-virtio-balloon kmod-virtio-net kmod-virtio-pci kmod-virtio
         GRUB2_VARIANT := grub2
         GRUB2_TITLE := OpenWrt on Custom Board
       endef
       TARGET_DEVICES += CUSTOM_BOARD
       EOF

3. 编译配置：

   .. code-block:: bash

       # 选择板子配置
       make menuconfig
       # 在 Target System 中选择 x86_64
       # 在 Target Profile 中选择 Custom Board

4. 编译固件：

   .. code-block:: bash

       make -j$(nproc)

配置 KVM 支持
----------------------

如果遇到 KVM 相关的错误，请按以下步骤配置：

1. 检查 CPU 是否支持虚拟化：

   .. code-block:: bash

       egrep -c '(vmx|svm)' /proc/cpuinfo

   如果输出大于 0，说明 CPU 支持虚拟化。

2. 检查 KVM 模块是否加载：

   .. code-block:: bash

       lsmod | grep kvm

3. 如果没有加载，加载 KVM 模块：

   .. code-block:: bash

       sudo modprobe kvm
       sudo modprobe kvm_intel  # Intel CPU
       # 或
       sudo modprobe kvm_amd    # AMD CPU

4. 检查 /dev/kvm 是否存在：

   .. code-block:: bash

       ls -l /dev/kvm

5. 如果 /dev/kvm 不存在，创建它：

   .. code-block:: bash

       sudo mknod /dev/kvm c 10 232
       sudo chown root:kvm /dev/kvm
       sudo chmod 660 /dev/kvm

6. 将用户添加到 kvm 组：

   .. code-block:: bash

       sudo usermod -aG kvm $USER

7. 重启系统或重新登录使组更改生效。

8. 验证 KVM 是否正常工作：

   .. code-block:: bash

       kvm-ok

启动不同板子
--------------------

使用 QEMU 启动不同配置的 OpenWrt：

1. 通用板子配置：

   .. code-block:: bash

       qemu-system-x86_64 \
           -enable-kvm \
           -kernel openwrt-x86-64-generic-kernel.bin \
           -drive file=rootfs.ext3,format=raw \
           -append "root=/dev/sda console=ttyS0" \
           -nographic \
           -m 512M \
           -net nic,model=virtio \
           -net user

2. 虚拟机专用配置：

   .. code-block:: bash

       qemu-system-x86_64 \
           -enable-kvm \
           -kernel openwrt-x86-64-virtio-kernel.bin \
           -drive file=rootfs.ext3,format=raw \
           -append "root=/dev/sda console=ttyS0" \
           -nographic \
           -m 512M \
           -net nic,model=virtio \
           -net user \
           -device virtio-balloon-pci

3. 自定义板子配置：

   .. code-block:: bash

       qemu-system-x86_64 \
           -enable-kvm \
           -kernel bin/targets/x86/64/openwrt-x86-64-custom-board-kernel.bin \
           -drive file=rootfs.ext3,format=raw \
           -append "root=/dev/sda console=ttyS0" \
           -nographic \
           -m 512M \
           -net nic,model=virtio \
           -net user \
           -device virtio-balloon-pci

登录和配置
-------------------

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
-----------------

1. 不同板子配置的主要区别：

   - 内核配置选项
   - 默认软件包
   - 设备驱动支持
   - 启动参数

2. 选择板子配置时考虑：

   - 硬件兼容性
   - 性能需求
   - 功能需求
   - 存储空间限制

3. 调试技巧：

   - 使用 ``-d int`` 查看详细日志
   - 使用 ``-serial stdio`` 查看串口输出
   - 使用 ``-S -s`` 进行调试
