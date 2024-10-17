**************************************************
SSH (Secure Shell) 手册
**************************************************

对大多数人而言，初次接触 *SSH* 应该是在学习 *Linux* 的第三堂课，毕竟大多课程安排如下:

* *Linux* 前导篇: 历史、现状、功能等
* 学习环境搭建: 安装虚拟机，并安装 *Linux* 系统
* *SSH* 登录与初步学习
* 后续......

这导致大多数人认为 *SSH* 只是远程访问的工具，而事实并非如此。*SSH* 是网络安全传输协议，使用 CS 架构，在不安全网络中建立一个加密的通信隧道，保护明文传输的数据。

.. image:: ssh_image/ssh.png
    :align: center

上图 SSH 建立了一个安全隧道，其它应用在隧道中传输数据，典型应用如下:

* 远程命令执行(也就是我们熟悉的远程访问):将 *shell* 命令传到远端，并将执行结果返回。
* *SCP* 应用: *SSH* 读取本地文件，并将数据传至远端，而后 *SSHD* 写入存储，反之亦可。
* *SFTP* 应用: 让 *SSH* 隧道承载 *FTP* 数据，与 *SCP* 基本相似。
* 端口转发: 直接在本地和远程各开放一个端口，允许各种应用传输数据。

本教程更像是个人笔记，内容和我日常使用相关，因此并不会面面俱到。

.. toctree::
    :numbered:
    :maxdepth: 1

    ssh-client
    ssh-server
    ssh-key-auth
    ssh-port-forwarding
    ssh-scp
    ssh-stfp
    ssh-client-config
    ssh-server-config
    ssh-permissions
