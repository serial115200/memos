从软件包安装内核树
================================================================================

确认内核树

.. code-block:: bash

    ~$ dpkg-query -s linux-headers-$(uname -r)
    dpkg-query: package 'linux-headers-5.4.0-67-generic' is not installed and no information is available
    Use dpkg --info (= dpkg-deb --info) to examine archive files.


查看内核树（再次确认）

.. code-block:: bash

    ~$ ls -l /usr/src/linux-headers-$(uname -r)
    ls: cannot access '/usr/src/linux-headers-5.4.0-67-generic': No such file or directory


查找内核树包（系统可能小版本升级，而该小版本无内核树包）

.. code-block:: bash

    ~$ apt search linux-headers-$(uname -r)
    Sorting... Done
    Full Text Search... Done
    linux-headers-5.19.0-43-generic/now 5.19.0-43.44~22.04.1 amd64 [installed,local]
    Linux kernel headers for version 5.19.0 on 64 bit x86 SMP


安装内核树

.. code-block:: bash

    sudo apt update
    sudo apt install linux-headers-$(uname -r)


确认内核树

.. code-block:: bash

    ~$ dpkg-query -s linux-headers-$(uname -r)
    Package: linux-headers-5.4.0-67-generic
    Status: install ok installed
    Priority: optional
    Section: devel
    Installed-Size: 14500
    Maintainer: Ubuntu Kernel Team <kernel-team@lists.ubuntu.com>
    Architecture: amd64
    Source: linux
    Version: 5.4.0-67.75
    Provides: linux-headers, linux-headers-3.0
    Depends: linux-headers-5.4.0-67, libc6 (>= 2.14), libelf1 (>= 0.142), libssl1.1 (>= 1.1.0)
    Description: Linux kernel headers for version 5.4.0 on 64 bit x86 SMP
    This package provides kernel header files for version 5.4.0 on
    64 bit x86 SMP.
    .
    This is for sites that want the latest kernel headers.  Please read
    /usr/share/doc/linux-headers-5.4.0-67/debian.README.gz for details.

查看内核树

.. code-block:: bash

    ~$ ls -l /usr/src/linux-headers-$(uname -r)
    total 1612
    drwxr-xr-x 3 root root    4096 Mar 18  2021 arch
    lrwxrwxrwx 1 root root      31 Feb 20  2021 block -> ../linux-headers-5.4.0-67/block
    lrwxrwxrwx 1 root root      31 Feb 20  2021 certs -> ../linux-headers-5.4.0-67/certs
    lrwxrwxrwx 1 root root      32 Feb 20  2021 crypto -> ../linux-headers-5.4.0-67/crypto
    lrwxrwxrwx 1 root root      39 Feb 20  2021 Documentation -> ../linux-headers-5.4.0-67/Documentation
    lrwxrwxrwx 1 root root      33 Feb 20  2021 drivers -> ../linux-headers-5.4.0-67/drivers
    lrwxrwxrwx 1 root root      28 Feb 20  2021 fs -> ../linux-headers-5.4.0-67/fs
    drwxr-xr-x 4 root root    4096 Mar 18  2021 include
    lrwxrwxrwx 1 root root      30 Feb 20  2021 init -> ../linux-headers-5.4.0-67/init
    lrwxrwxrwx 1 root root      29 Feb 20  2021 ipc -> ../linux-headers-5.4.0-67/ipc
    lrwxrwxrwx 1 root root      32 Feb 20  2021 Kbuild -> ../linux-headers-5.4.0-67/Kbuild
    lrwxrwxrwx 1 root root      33 Feb 20  2021 Kconfig -> ../linux-headers-5.4.0-67/Kconfig
    drwxr-xr-x 2 root root    4096 Mar 18  2021 kernel
    lrwxrwxrwx 1 root root      29 Feb 20  2021 lib -> ../linux-headers-5.4.0-67/lib
    lrwxrwxrwx 1 root root      34 Feb 20  2021 Makefile -> ../linux-headers-5.4.0-67/Makefile
    lrwxrwxrwx 1 root root      28 Feb 20  2021 mm -> ../linux-headers-5.4.0-67/mm
    -rw-r--r-- 1 root root 1618327 Feb 20  2021 Module.symvers
    lrwxrwxrwx 1 root root      29 Feb 20  2021 net -> ../linux-headers-5.4.0-67/net
    lrwxrwxrwx 1 root root      33 Feb 20  2021 samples -> ../linux-headers-5.4.0-67/samples
    drwxr-xr-x 8 root root   12288 Mar 18  2021 scripts
    lrwxrwxrwx 1 root root      34 Feb 20  2021 security -> ../linux-headers-5.4.0-67/security
    lrwxrwxrwx 1 root root      31 Feb 20  2021 sound -> ../linux-headers-5.4.0-67/sound
    drwxr-xr-x 3 root root    4096 Mar 18  2021 tools
    lrwxrwxrwx 1 root root      32 Feb 20  2021 ubuntu -> ../linux-headers-5.4.0-67/ubuntu
    lrwxrwxrwx 1 root root      29 Feb 20  2021 usr -> ../linux-headers-5.4.0-67/usr
    lrwxrwxrwx 1 root root      30 Feb 20  2021 virt -> ../linux-headers-5.4.0-67/virt
