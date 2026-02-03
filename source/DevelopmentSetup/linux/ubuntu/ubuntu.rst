Ubuntu 软件
================================================================================

.. toctree::
    :maxdepth: 1

    ubuntu_mainline


安装脚本与配置文件下载与使用
--------------------------------------------------------------------------------

**下载**

- :download:`software/ubuntu_install.sh <software/ubuntu_install.sh>` — 安装脚本
- :download:`software/ubuntu_common.conf <software/ubuntu_common.conf>` — 通用包
- :download:`software/ubuntu_20.04.conf <software/ubuntu_20.04.conf>` — 20.04 额外包
- :download:`software/ubuntu_22.04.conf <software/ubuntu_22.04.conf>` — 22.04 额外包
- :download:`software/ubuntu_24.04.conf <software/ubuntu_24.04.conf>` — 24.04 额外包

**用法**

.. code-block:: bash

    chmod +x ubuntu_install.sh
    sudo ./ubuntu_install.sh ubuntu_common.conf [ubuntu_[version].conf]


脚本源码
--------------------------------------------------------------------------------

.. raw:: html

   <details>
   <summary>点击展开</summary>

.. literalinclude:: software/ubuntu_install.sh
    :language: bash

.. raw:: html

   </details>


Ubuntu 通用包
--------------------------------------------------------------------------------

.. literalinclude:: software/ubuntu_common.conf
    :language: bash


ubuntu 20.04 额外包
--------------------------------------------------------------------------------

.. literalinclude:: software/ubuntu_20.04.conf
    :language: bash


Ubuntu 22.04 额外包
--------------------------------------------------------------------------------

.. literalinclude:: software/ubuntu_22.04.conf
    :language: bash


Ubuntu 24.04 额外包
--------------------------------------------------------------------------------

.. literalinclude:: software/ubuntu_24.04.conf
    :language: bash
