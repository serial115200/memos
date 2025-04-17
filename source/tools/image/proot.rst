proot
================================================================================

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
