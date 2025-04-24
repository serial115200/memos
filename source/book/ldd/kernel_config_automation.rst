修改选项
================================================================================

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
