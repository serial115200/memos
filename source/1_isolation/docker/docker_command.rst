Docker 常用命令与实践经验
==================================================

本章包含 docker 常用命令与实践经验，如需帮助，建议阅读下方开源书籍，或查看官网文档。

`《Docker 从入门到实践》 <https://github.com/yeasy/docker_practice>`_

--------------------------------------------------

.. prompt:: bash

    sudo usermod -aG docker $(id -un)


镜像管理
--------------------------------------------------

.. code-block:: bash
    :caption: 拉取镜像

    docker pull [option] [Docker Registry 地址[:端口号]/]仓库名[:标签]


.. code-block:: bash
    :caption: 列出镜像

    docker image ls

删除镜像

.. prompt:: bash

    docker image rm <image tag or hash>

删除虚悬镜像

.. prompt:: bash

    docker image pure

容器管理
--------------------------------------------------

.. prompt:: bash

    docker pull ubuntu



文件挂载
--------------------------------------------------


杂项
--------------------------------------------------


账户
--------------------------------------------------

通常

.. prompt:: bash

    docker login [docker server url]
    docker login -u username -p password [docker server url]
    docker logout

在自动化流程中指定密码可能导致密码泄露

.. prompt:: bash

    docker login --username foo --password-stdin < ~/password.txt
    echo ${password} | docker login -u username --password-stdin

镜像构建
--------------------------------------------------

:doc:`docker_build_image`
