strace 命令
================================================================================

软件安装
--------------------------------------------------------------------------------

.. code-block::

    sudo apt update
    sudo apt install strace -y


使用概述
--------------------------------------------------------------------------------


追踪命令
--------------------------------------------------------------------------------

.. literalinclude:: strace_ls.txt
    :language: bash


不同系统的输出内容差异很大，毕竟涉及系统调用，此外 strace 追踪系统调用，需要注意几点

* 不涉及系统调用的

追踪过滤
--------------------------------------------------------------------------------

输出格式
--------------------------------------------------------------------------------

运行统计
--------------------------------------------------------------------------------
