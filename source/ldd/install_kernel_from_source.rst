从源码安装内核树
================================================================================

浏览器查看选择

.. code-block::

    https://cdn.kernel.org/pub/linux/kernel/


下载源码

.. code-block::

    wget https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-6.11.tar.xz


解压源码

.. code-block::

    tar -xf linux-6.11.tar.xz


安装依赖和工具

.. code-block::

    sudo apt-get update
    sudo apt-get install -y git fakeroot build-essential ncurses-dev xz-utils libssl-dev bc flex libelf-dev bison


配置内核

.. code-block::

    cd linux-6.0.7
    cp -v /boot/config-$(uname -r) .config
    # 微调
    make menuconfig

    # 避免 No rule to make target 'debian/canonical-certs.pem
    scripts/config --disable SYSTEM_TRUSTED_KEYS
    scripts/config --disable SYSTEM_REVOCATION_KEYS


编译与安装

.. code-block::

    make

    # 安装模块
    sudo make modules_install

    # 安装内核
    sudo make install


更新 bootloader，通常 make install 自动做了

sudo update-initramfs -c -k 6.0.7

Or

sudo update-grub

重启系统。
