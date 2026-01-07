sudo 机制
================================================================================

sudo 的基本原理如下：

.. code-block:: shell

    ~$ ls -al $(which sudo)
    -rwsr-xr-x 1 root root 769264 Mar 16  2021 /usr/bin/sudo
