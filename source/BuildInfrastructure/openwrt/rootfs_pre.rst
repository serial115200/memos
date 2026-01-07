Rootfs
================================================================================

git:cf1c7c0f17a45bba3e7ce1a3cd3f8f7efa7196c4

在完成 rootfs 的资源准备完成后，进行预处理，包括 init 文件的 enable。

在 openwrt 顶层目录添加 files 目录，放入想要加入的文件，会一并放入最终的 rootfs。

.. code-block::

    define prepare_rootfs
        $(if $(2),@if [ -d '$(2)' ]; then \
            $(call file_copy,$(2)/.,$(1)); \
        fi)
    ......
    endef
