Screen 命令 -- 会话管理
==================================================

问题与需求
--------------------------------------------------

Screen 有不少功能，但我使用的并不多，毕竟需要解决的问题只是保持终端。

* 因 Windows 自动更新、网络中断、软件崩溃等原因造成终端丢失

    终端丢失后，运行中的操作就失去了控制，不知何时会停止，也不知能否完成。我们可以 kill 单进程任务，然后重新开始，但像编译软件这种多进程任务就束手无策，难以理清需要 kill 的进程，只能等待足够的时间，确保被任务被中断或完成，然后重新开始。

* 运行程序时，需要保持 SSH 终端

    通过保持 SSH 终端来保证软件运行，这本身并不合理。优秀的软件理应可以运行在后台，使用 cli 交互，通过 log 输出有用的信息，但这只能是少数情况。

    PS: & 符号可以让软件后台运行，但终端断开后，进程依然会被中断，参见信号与进程。

Screen 介绍
--------------------------------------------------

Screen 给出的方案是在服务器本地创建并管理会话，在 SSH 登陆后，再登陆 Screen 会话。

Screen 安装
--------------------------------------------------

Ubuntu/Debian 等发行版

    .. code-block:: bash

        sudo apt install screen

CentOS/Fedora 等发行版

    .. code-block:: bash

        sudo yum install screen

    如果输出 No match for argument: screen，则需添加相应的 yum 源:

    .. code-block:: bash

        sudo yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm

输入显示版本命令，进行安装确认:

    .. code-block:: bash

        screen --version

命令输出

    .. code-block:: bash

        Screen version 4.08.00 (GNU) 05-Feb-20

其他发行版安装参见:https://command-not-found.com/screen

Screen 基础
--------------------------------------------------

创建会话

    直接运行命令

    .. code-block:: bash

        screen

    也可以使用 `-S` 选项指定会话名

    .. code-block:: bash

        screen -S session_name

登出会话

    Screen 使用组合按键，按住 `ctrl` 后，依次按下 `a` 与 `d` 按键

    :kbd:`Ctrl + a + d`

查看会话

    .. code-block:: bash

        screen -ls

    命令输出

    .. code-block:: bash

        There are screens on:
            367315.session_name     (11/21/2021 11:09:42 PM)            (Detached)
            367118.pts-0.zpxli5mhbj9eiu1b   (11/21/2021 11:09:09 PM)    (Attached)
        2 Sockets in /run/screen/S-root.

登录会话

    会话 id、会话名或两者的组合均可用于指定将要登录的会话，以下命令三选其一。

    .. code-block:: bash

        screen -r 367315

    .. code-block:: bash

        screen -r session_name

    .. code-block:: bash

        screen -r 367315.session_name

    对于 Attached 会话需要添加 `-D` 选项，踢人后再登陆。

    .. code-block:: bash

        screen -D -r session_name

删除会话

    直接输入 exit 即可删除会话。

    PS: Screen 开启多窗口时，从最后一个窗口退出才会删除会话，目前只有单个窗口。
