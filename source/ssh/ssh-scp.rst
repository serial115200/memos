SSH SCP 应用
==================================================

CP 命令
--------------------------------------------------

在说明 *scp* 命令前，我们先看看 *cp* 命令，它可以复制文件与目录，使用方式如下。

.. code-block:: bash

    cp [OPTION] SOURCE DEST

在修改配置前，我们通常会复制对应的文件作为备份，比如备份先前的 sshd 配置文件。

.. code-block:: bash

    cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak

SCP 命令
--------------------------------------------------

*scp* 和 *cp* 类似，可以通过 SSH 协议操作远程主机的文件，相当于将底层文件系统进行了扩展。

.. code-block:: bash

    scp [OPTION] SOURCE DEST

在操作远程文件时， SOURCE 和 DEST 需要添加用户名和主机，如 *dummy@10.0.0.1:/home/dummy*

复制文件至远端

.. code-block:: bash

    scp testfile dummy@10.0.0.1:/home/dummy

复制文件至本地

.. code-block:: bash

    scp dummy@10.0.0.1:/home/dummy/testfile ./

复制目录至远端

.. code-block:: bash

    scp testdir dummy@10.0.0.1:/home/dummy

复制目录至本地

.. code-block:: bash

    scp dummy@10.0.0.1:/home/dummy/testdir ./

双远程复制（新增特性，不一定有效）

.. code-block:: bash

    scp dummy@10.0.0.1:/home/dummy/testfile dummy1@10.0.0.2:/home/dummy1/

其余操作可以递推，略。

SCP 选项
--------------------------------------------------

* -l 限制速度
* -P 指定端口
* -i 指定密钥
* -v 调试模式
* -q 静默模式
* -F 指定配置文件

上述选项很少使用，毕竟配置文件同样适用 *scp* 命令。

.. code-block:: bash

    Host dummy
        HostName 10.0.0.1
        User dummy
        Port 3333
        IdentityFile ~/.ssh/dummy

    Host dummy1
        HostName 10.0.0.2
        User dummy1
        Port 2222
        IdentityFile ~/.ssh/dummy1

在配置完成后，命令可以大幅简化:

.. code-block:: bash

    scp -P 3333 -i ~/.ssh/dummy testfile dummy@10.0.0.1:/home/dummy

.. code-block:: bash

    scp testfile dummy:/home/dummy

*-F* 可以指定配置文件，临时环境很有用。

双远程复制是新增特性，如配置文件所示，当主机端口和认证密钥不一致时，应当如何指定？

建议登陆一台远程主机，然后执行 scp 命令。
