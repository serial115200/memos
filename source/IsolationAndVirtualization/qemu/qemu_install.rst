QEMU 安装
================================================================================

基础软件

.. code-block:: shell

    sudo apt update
    sudo apt install -y qemu-system qemu-user qemu-utils


硬件加速

.. code-block:: shell

    sudo apt update
    sudo apt install -y qemu-kvm


图形界面， `-display sdl`

.. code-block:: shell

    sudo apt install -y qemu-system-gui


网桥模块

.. code-block:: shell

    sudo apt install -y bridge-utils
