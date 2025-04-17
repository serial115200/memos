chroot
================================================================================

.. code-block::

    install -d alpine-linux-x86-64

.. code-block::

    curl -O https://dl-cdn.alpinelinux.org/alpine/v3.20/releases/x86_64/alpine-minirootfs-3.20.0-x86_64.tar.gz

.. code-block::

    tar -vxf alpine-minirootfs-3.20.0-x86_64.tar.gz -C alpine-linux-x86-64

.. code-block::

    echo "nameserver 114.114.114.114" > alpine-linux-x86-64/etc/resolv.conf

.. code-block::

    sudo chroot alpine-linux-x86-64 apk update
    sudo chroot alpine-linux-x86-64 apk add bash
    sudo chroot alpine-linux-x86-64 bash
