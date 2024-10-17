SSH SFTP 应用
==================================================

sftp 就是用 ssh 隧道承载 ftp 数据，因此操作方式与 ftp 基本一致。


登录主机
--------------------------------------------------

使用交互方式登录远程主机:

.. prompt:: bash

    sftp dummy@10.0.0.1

如果配置文件保存了相关信息则可以简化:

.. code-block:: bash

    Host dummy
        HostName 10.0.0.1
        User dummy
        Port 3333
        IdentityFile ~/.ssh/dummy

.. prompt:: bash

    sftp dummy

传输命令
--------------------------------------------------

在输入 *help* 命令后，会有详细的帮助信息:

.. code-block:: none

    sftp> help
    Available commands:
    bye                                Quit sftp
    cd path                            Change remote directory to 'path'
    chgrp grp path                     Change group of file 'path' to 'grp'
    chmod mode path                    Change permissions of file 'path' to 'mode'
    chown own path                     Change owner of file 'path' to 'own'
    df [-hi] [path]                    Display statistics for current directory or
                                    filesystem containing 'path'
    exit                               Quit sftp
    get [-afPpRr] remote [local]       Download file
    reget [-fPpRr] remote [local]      Resume download file
    reput [-fPpRr] [local] remote      Resume upload file
    help                               Display this help text
    lcd path                           Change local directory to 'path'
    lls [ls-options [path]]            Display local directory listing
    lmkdir path                        Create local directory
    ln [-s] oldpath newpath            Link remote file (-s for symlink)
    lpwd                               Print local working directory
    ls [-1afhlnrSt] [path]             Display remote directory listing
    lumask umask                       Set local umask to 'umask'
    mkdir path                         Create remote directory
    progress                           Toggle display of progress meter
    put [-afPpRr] local [remote]       Upload file
    pwd                                Display remote working directory
    quit                               Quit sftp
    rename oldpath newpath             Rename remote file
    rm path                            Delete remote file
    rmdir path                         Remove remote directory
    symlink oldpath newpath            Symlink remote file
    version                            Show SFTP version
    !command                           Execute 'command' in local shell
    !                                  Escape to local shell
    ?                                  Synonym for help

以下是常用的命令

上传文件或目录

.. prompt:: bash >

    put file
    put -R dir

下载文件或目录

.. prompt:: bash >

    get file
    get -R dir

本地命令带有 l 前缀，远程命令不带

.. prompt:: bash >

    lls
    lcd path
    lpwd

.. prompt:: bash >

    ls
    cd path
    pwd

退出

.. prompt:: bash >

    bye
