SSH 客户端 - 远程访问
==================================================


软件安装
--------------------------------------------------

.. code-block:: shell

    sudo apt install -y openssh-client

安装确认:

.. code-block:: shell

    ~$ ssh -V
    OpenSSH_8.2p1 Ubuntu-4ubuntu0.2, OpenSSL 1.1.1f  31 Mar 2020

连接主机
--------------------------------------------------

假设主机名 IP 为 10.0.0.1，用户名是 dummy，则可以使用以下命令进行登录:

.. code-block:: none
    :linenos:
    :emphasize-lines: 2-5

    $ ssh dummy@10.0.0.1
    The authenticity of host '10.0.0.1 (10.0.0.1)' can't be established.
    ECDSA key fingerprint is SHA256:ZqsZKXaz3/cm9IN6F9CaEdJDhgj8fRmwL+l+ERgI4M8.
    Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
    Warning: Permanently added '10.0.0.1' (ECDSA) to the list of known hosts.
    dummy@10.0.0.1's password:
    Welcome to Ubuntu 20.04.2 LTS (GNU/Linux 5.4.0-88-generic x86_64)
    <Truncated output>
    dummy@ubuntu:~$

首次登录会显示安全提示，需要手动确认指纹信息:

* 第二行为主机密钥指纹信息
* 第三行需要交互输入 *yes*
* 第四行表明将主机信息存入 `~/.ssh/known_hosts`

在输入密码后，显示主机 banner 信息，并进入 `shell`。后续登录不再出现该提示。

如果登录中断，并出现如下提示，则表明了主机指纹发生变更。

.. code-block:: shell

    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    @    WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!     @
    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    IT IS POSSIBLE THAT SOMEONE IS DOING SOMETHING NASTY!
    Someone could be eavesdropping on you right now (man-in-the-middle attack)!
    It is also possible that a host key has just been changed.
    The fingerprint for the ECDSA key sent by the remote host is
    SHA256:ZqsZKXaz3/cm9IN6F9CaEdJDhgj8fRmwL+l+ERgI4M8.
    Please contact your system administrator.
    Add correct host key in < private info >.ssh/known_hosts to get rid of this message.
    Offending ECDSA key in < private info >.ssh/known_hosts:1
    ECDSA host key for 10.0.0.1 has changed and you have requested strict checking.
    Host key verification failed.

此时，我们可以使用以下命令删除保存的主机信息，然后重新进行连接。

.. code-block:: bash

    ssh-keygen -R 10.0.0.1

主机指纹通常不会改变，除非管理员更新了 `/etc/ssh/ssh_host_ecdsa_key.pub` 密钥或系统进行了重装，当然也可能是主机被入侵了，因此我们需要谨慎对待该问题。话虽如此，但我并不知道如何处理入侵问题，事实上连接时也没有确认指纹信息。 **只因我常重装系统，所以记录了该问题。**


配置概述
--------------------------------------------------

*SSH* 运行时，会解析以下配置信息，优先级依次递减。

* 命令行参数

    .. code-block:: bash

        ssh dummy@10.0.0.1 -p 2222

    `-p` 选项指定 ssh 访问端口为 `2222`。

* 用户配置文件

    文件位于 `~/.ssh/config`， 可以使用 `Port 2222` 指定访问端口。

* 全局配置文件

    文件位于 `/etc/ssh/ssh_config`，可以使用 `Port 2222` 指定访问端口。

用户配置文件与全局配置文件具有相同的选项，通常从全局配置文件查看选项，然后复制选项到用户配置文件，并做相应的修改。命令行选项与配置文件选项基本有一一对应的关系。

在实践操作中，通常使用用户配置文件进行管理。


命令行参数
--------------------------------------------------

SSH 配置选项繁多，此处只说明常见的选项，其余的选项做如下安排:

* 几乎不用，不做介绍

    -1，-2 选项用于指定 SSH 协议的版本，但 SSH1 基本被弃用。

* 特殊功能，用时介绍

    -L，-D 等选项用于端口转发，-i 选项用于指定密钥，会在后续说明。

指定端口

    .. code-block:: bash

        ssh dummy@10.0.0.1 -p 2222

    部分主机出于安全考虑会更改默认访问端口。

静默模式

    .. code-block:: bash

        ssh dummy@10.0.0.1 -q

    减少不必要的输出，如在脚本中执行 *SSH* 命令。

调试信息

    .. code-block:: bash

        ssh dummy@10.0.0.1 -v

    用于在连接出错时查看日志，v 可以叠加使用，v 越多日志越详细，如 -vvv。

用户配置文件
--------------------------------------------------

首先使用以下命令创建配置文件，目录与文件的权限要求见附录::doc:`ssh-permissions`

.. code-block:: bash

    mkdir -m 700 -p ~/.ssh && (umask 077 && touch ~/.ssh/config)

配置文件的格式大致如下:

.. code-block:: shell

    # # 起始的内容为注释，解析时会被忽略。
    # 选项后的 # 可能存在解析问题，这与实现相关，因此建议注释写在每一个 Host 上方。

    Host publish_cc                 # Host 声明 publish_cc 主机的配置块
        HostName 10.0.0.2           # 主机地址

    Host compile_cc                 # Host 声明 compile_cc 主机的配置块
        HostName 10.0.0.1
        Port 2222                   # 单独配置访问端口

    # Host 支持通配符，示例选项为 _cc 结尾的主机指定相同的用户名
    Host *_cc
        User dummy                  # 用户名

    # * 代表全部主机，优先级在配置文件中最低，示例选项为全部主机配置了相同的认证密钥
    Host *
        IdentityFile ~/.ssh/id_rsa

*SSH* 配置文件不存在密码选项，因此需要手动输入密码，或使用后续介绍的密钥认证。

在完成配置文件后，可以使用以下命令直接连接:

.. code-block:: bash

    ssh compile_cc

在输入 *ssh* 后，可以使用 *TAB* 键进行显示与补全，与文件名补全相似。

.. code-block:: text

    ssh
    10.0.0.1        compile_cc          publish_cc

详细的配置选项说明见::doc:`ssh-client-config`。
