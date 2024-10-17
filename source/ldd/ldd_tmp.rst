内核临时笔记
================================================================================


修改选项
--------------------------------------------------------------------------------

https://stackoverflow.com/questions/7505164/how-do-you-non-interactively-turn-on-features-in-a-linux-kernel-config-file

Single Option approach

.. code-block::

    ./scripts/config --set-val CONFIG_OPTION y
    ./scripts/config --enable CONFIG_BRIDGE
    ./scripts/config --enable CONFIG_MODULES
    ./scripts/config --disable CONFIG_X25
    ./scripts/config --module CONFIG_NFT
    make oldconfig

Multiple-File Merge approach

.. code-block::

    # Merge IP fragment CONFIG_ settings into the main .config file
    ./scripts/kconfig/merge_config.sh .config .config-fragment
    # Merge  Notebook HW-specific CONFIG_ settings into main .config file
    ./scripts/kconfig/merge_config.sh .config .config-notebook-toshiba

    # Auto-add/auto-remove CONFIG_ dependencies
    make oldconfig


.. code-block::

    export ARCH=arm64
    export CROSS_COMPILE=aarch64-linux-gnu-
    make defconfig
    ./scripts/kconfig/merge_config.sh .config .config-fragment

安装内核头文件
--------------------------------------------------------------------------------

.. code-block::

    make headers_install ARCH=i386 INSTALL_HDR_PATH=/usr
