OpenWRT 手册
================================================================================

.. toctree::
    :maxdepth: 1

    boardinfo

    procd/procd
    ubox/ubox
    dnsmasq/dnsmasq
    libubox/libubox


make package/foo/{clean,compile} V=99 STRIP=/bin/true


* 添加新设备

  https://openwrt.org/docs/guide-developer/adding_new_device

  参考同类型的提交记录更有意义

* 单包编译

  https://openwrt.org/docs/guide-developer/toolchain/single.package

  一些常用的命令

* 包制作

  https://openwrt.org/docs/guide-developer/package-policies

  还缺少链接，理论上还有两篇文章

* 添加 debug 符号

  https://forum.openwrt.org/t/how-to-tell-buildroot-not-run-strip-sh-on-a-shared-library-file/55735

  添加 debug 符号很麻烦，尤其是依赖共享库时，是否考虑远程 gdb
