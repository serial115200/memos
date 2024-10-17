SSH 服务端
==================================================


软件安装
--------------------------------------------------

CentOS/Fedora 等发行版:

.. prompt:: bash

    sudo yum -y install openssh-server

Ubuntu/Debian 等发行版:

.. prompt:: bash

    sudo apt -y install openssh-server

SSHD 未找到显示版本的命令，直接输入错误选项测试:

.. prompt:: bash

    sshd -v

命令输出:

.. prompt:: text

    unknown option -- v
    OpenSSH_8.2p1 Ubuntu-4ubuntu0.3, OpenSSL 1.1.1f  31 Mar 2020
    usage: sshd [-46DdeiqTt] [-C connection_spec] [-c host_cert_file]
                [-E log_file] [-f config_file] [-g login_grace_time]
                [-h host_key_file] [-o option] [-p port] [-u len]


服务管理
--------------------------------------------------

通常情况，安装 SSHD 时，会顺带完成服务配置，如果没有可以使用以下命令配置。

运行管理

.. prompt:: bash

    systemctl start   sshd
    systemctl restart sshd
    systemctl stop    sshd
    systemctl reload  sshd
    systemctl status  sshd

开机启动

.. prompt:: bash

    systemctl is-active sshd
    systemctl enable    sshd
    systemctl disable   sshd


配置文件
--------------------------------------------------

*sshd* 的配置文件为 `/etc/ssh/sshd_config`，大多情况无需修改。

PS: # 开头的选项既是注释，也是默认配置，如 *#Port 22*，表示默认启用密钥认证，因此无需做任何修改。

更改默认端口:

    .. code-block:: bash

        Port 22

是否允许root登录:

    .. code-block:: bash

        # no                    不允许
        # yes                   允许
        # prohibit-password     只允许密钥登陆
        # forced-commands-only  允许执行指定的命令
        PermitRootLogin prohibit-password

重启服务:

    .. code-block:: bash

        systemctl restart sshd

密钥认证等配置见相关的章节，详细的配置选项见::doc:`ssh-server-config`。