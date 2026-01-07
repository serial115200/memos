SSH 密钥认证
==================================================

密码认证存在诸多不便，如:

* 简单密码，易被破解，复杂密码记不住
* 每次登录都需输入密码，十分不便，也容易泄露


密钥认证
--------------------------------------------------

简单来说，密钥如同以前的虎符:

.. image:: ssh_image/虎符.jpg
    :align: center

虎符成对，皇帝和统帅各执一半，调兵遣将则需虎符符合。

* 密钥也成对，分为公钥和私钥，不过公私钥是人为规定的。皇帝和统帅的虎符互换，并没有实质影响，公私钥亦是如此，人为定义是为了方便管理。

* 密钥安装就是皇帝给予统帅一半虎符。

* 密钥认证就是检验虎符是否符合的过程，只有密钥成对才能通过认证。

虽说公私密钥没有差别，但实际使用还是应当保存私钥，分发公钥，一旦混淆，可能江山不保。

.. note:: 密钥认证原理涉及密码学，可以参阅《图解密码学》


密钥生成
--------------------------------------------------

*ssh-keygen* 命令负责管理密钥相关事物，默认情况下，会以交互形式生成密钥。

.. code-block::
    :linenos:
    :emphasize-lines: 3,5,6

    ubuntu@VM-32-12-ubuntu:~$ ssh-keygen
    Generating public/private rsa key pair.
    Enter file in which to save the key (/home/ubuntu/.ssh/id_rsa):
    Created directory '/home/ubuntu/.ssh'.
    Enter passphrase (empty for no passphrase):
    Enter same passphrase again:
    Your identification has been saved in /home/ubuntu/.ssh/id_rsa.
    Your public key has been saved in /home/ubuntu/.ssh/id_rsa.pub.
    The key fingerprint is:
    SHA256:fN9Z3ujWNjPGf98YuCp1f+lO3OwhxHSH17Vv5kqrssM ubuntu@VM-32-12-ubuntu
    The key's randomart image is:
    +---[RSA 2048]----+
    |                .|
    |               .+|
    |             ..o+|
    |       .    o ..o|
    |        S .  o  =|
    |         ...oo.Xo|
    |         o .ooB=B|
    |        . E  +=&B|
    |         .o=ooO=%|
    +----[SHA256]-----+

* 第三行提示公私密钥对存储的位置和名字，输入 :kbd:`Enter`，使用默认位置和命名。
* 第五第六行要求输入密钥的密码，输入 :kbd:`Enter`，不使用密码。

密钥生成结果如下:

    .. code-block::

        ls -al .ssh/
        total 16
        drwx------ 2 ubuntu ubuntu 4096 Dec 20 02:30 .
        drwx------ 1 ubuntu ubuntu 4096 Dec 20 02:30 ..
        -rw------- 1 ubuntu ubuntu 2602 Dec 20 02:30 id_rsa
        -rw-r--r-- 1 ubuntu ubuntu  571 Dec 20 02:30 id_rsa.pub


密钥事项
--------------------------------------------------

更改位置与命名:

    通常会使用默认参数，但多个密钥时，则需更改，避免密钥被覆盖。

    .. code-block::

        Enter file in which to save the key (/home/ubuntu/.ssh/id_rsa): /tmp/testkey

密码保护:

    大多数人不会使用密码保护密钥，主要是嫌麻烦，其实 *ssh-agent* 可以减少输入密码的负担。

更改密钥密码:

    .. code-block:: bash

        ssh-keygen -p -f ~/.ssh/id_rsa

    交互过程可能需要输入原密码，或直接选项提供原密码。

    .. code-block:: bash

        ssh-keygen -p -f ~/.ssh/id_rsa -P "12345678"

无交互生成密钥:

    *ssh-keygen* 的部分帮助信息如下:

    .. code-block:: bash

        ssh-keygen [-q] [-b bits] [-C comment] [-f output_keyfile] [-m format]
                        [-t dsa | ecdsa | ecdsa-sk | ed25519 | ed25519-sk | rsa]
                        [-N new_passphrase] [-O option] [-w provider]

    通常使用以下命令生成密钥对:

    .. code-block:: bash

        ssh-keygen -q -b 2048 -C "dummy key" -f ~/.ssh/id_rsa -t rsa -N ""

    * -b 指定密钥位数，1024 的倍数，越大越安全
    * -C 添加注释，方便后续查阅与区分
    * -f 指定目录与密钥名称
    * -t 指定密钥类型，上述类型任选其一
    * -N 指定密码，此处为空。注意，shell history 会存储该命令，从而泄露密码

密钥权限:

    在数据迁移时，可能在 Linux 和 Windows 之间交互数据，这会导致密钥权限发生变更，错误的权限将导致密钥不可用，详见附录::doc:`ssh-permissions`

    .. code-block:: none

        @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
        @         WARNING: UNPROTECTED PRIVATE KEY FILE!          @
        @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
        Permissions 0666 for '/home/ubuntu/.ssh/id_rsa' are too open.
        It is required that your private key files are NOT accessible by others.
        This private key will be ignored.
        Load key "/home/ubuntu/.ssh/id_rsa": bad permissions
        dummy@10.0.0.1's password:


密钥安装
--------------------------------------------------

Linux 是多用户系统，认证所需的公钥存放在每个用户的 *ssh/authorized_keys* 文件中。

通常可以使用以下命令安装密钥，过程中需要输入登录密码。

.. code-block:: none

    $ ssh-copy-id dummy@10.0.0.1
    /usr/bin/ssh-copy-id: INFO: Source of key(s) to be installed: "/home/ubuntu/.ssh/id_rsa.pub"
    /usr/bin/ssh-copy-id: INFO: attempting to log in with the new key(s), to filter out any that are already installed
    /usr/bin/ssh-copy-id: INFO: 1 key(s) remain to be installed -- if you are prompted now it is to install the new keys
    dummy@10.0.0.1's password:

    Number of key(s) added: 1

    Now try logging into the machine, with:   "ssh 'dummy@10.0.0.1'"
    and check to make sure that only the key(s) you wanted were added.

*-i* 选项可以指定密钥。

.. code-block:: bash

    ssh-copy-id -i "/home/ubuntu/.ssh/test" dummy@10.0.0.1

公钥是可以公开的，管理大量主机时，很可能把公钥直接放到网上，然后直接脚本安装。

注意: 以下操作在服务器上执行，而不是生成密钥的客户端，公钥需提前放在网上。

.. code-block:: bash
    :caption: 创建公钥存储文件

    mkdir -m 700 -p ~/.ssh && (umask 077 && touch ~/.ssh/authorized_keys)

.. code-block:: bash
    :caption: 下载与安装公钥

    export KEY=$(mktemp /tmp/key.XXXXXXXXX)
    curl -fsSL -o ${KEY} <url for your public key>
    cat ${KEY} >> ~/.ssh/authorized_keys

操作方式多种多样，只要满足以下两个条件即可:

* 文件与目录权限符合 :doc:`ssh-permissions`
* 公钥存入 *~/.ssh/authorized_keys* 文件


启用密钥登陆
--------------------------------------------------

如前所述，sshd 的配置文件为 */etc/ssh/sshd_config*，需更改如下选项:

PS: # 开头的选项既是注释，也是默认配置，如 *#PubkeyAuthentication yes*，表示默认启用密钥认证，因此无需做任何修改。


开启密钥认证:

    .. code-block:: bash

        PubkeyAuthentication yes

关闭密码认证:

    .. code-block:: bash

        PasswordAuthentication no

重启服务:

    .. code-block:: bash

        systemctl restart sshd

ssh-agent
--------------------------------------------------

*ssh-agent* 用于管理密钥，相当于 ssh_config，但略有差异。


简单来说，我们将全部密钥导入 *ssh-agent*，解密后的密钥保存在内存中，使用时我们将数据传入 *ssh-agent*， 由 *ssh-agent* 进行中转，认证时 *ssh-agent* 用解密的密钥进行认证。

创建 ssh-agent 进程:

.. code-block:: bash

    eval `ssh-agent`
    # 或
    eval $(ssh-agent)

添加密钥，默认添加 *~/.ssh/id_rsa* 密钥，其它密钥需要指定，加密密钥需要输入密码解密:

.. code-block:: bash

    ssh-add ~/.ssh/id_rsa
    Enter passphrase for /home/dummy/.ssh/id_rsa:
    Identity added: /home/dummy/.ssh/id_rsa (/home/dummy/.ssh/id_rsa)

查看密钥:

.. code-block:: bash

    ssh-add -l
    2048 SHA256:llqLOpAH+6NPh4y71WND3Ukxq1l6FVCYMt2aCS+snSU /home/dummy/.ssh/id_rsa (RSA)


删除密钥:

.. code-block:: bash

    ssh-add -D                              # 删除全部密钥
    ssh-add -d /home/dummy/.ssh/id_rsa      # 删除指定密钥


在添加密钥后，可以按照原有方式进行连接，甚至配置文件都不需要指定密钥:

.. code-block:: bash

    ssh-keygen -l -f ~/.ssh/id_rsa
    2048 SHA256:llqLOpAH+6NPh4y71WND3Ukxq1l6FVCYMt2aCS+snSU dummy@test (RSA)
    ssh-keygen -l -f ~/.ssh/id_rsa.pub
    2048 SHA256:llqLOpAH+6NPh4y71WND3Ukxq1l6FVCYMt2aCS+snSU dummy@test (RSA)

查看密钥对的指纹信息，公私密钥的指纹信息是相同的，因此可以自动匹配密钥。

大多情况，ssh config 足以管理认证，个人猜测 *ssh-agent* 主要用于大公司管理服务器集群。

在别的文章看到还需做以下配置，但测试时，发现无需开启，可能是实现差异。

ssh_config (全局，个人，选项任选其一配置)

.. code-block:: bash

    ForwardAgent yes

sshd_config

.. code-block:: bash

    AllowAgentForwarding yes
