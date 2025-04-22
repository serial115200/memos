Dokcer HereDoc 介绍
================================================================================

更新：

* 2025-04-22: https://github.com/moby/moby/issues/34423

    docker 23.0 已默认启用，是否保留 ``# syntax=docker/dockerfile:1.3-labs`` 视情况
    而定

--------------------------------------------------------------------------------

Dockerfile 每条指令对应一层镜像，最佳实践常用 `&&` 连接命令，使用 `\\` 换行：

.. code-block:: shell

    FROM ubuntu:24.04

    RUN apt-get update \
        && apt-get install --no-install-recommends -y \
                    sudo \
                    passwd \
                    clang \
                    build-essential \
                    ccache \
                    cmake \
                    autoconf \
                    automake \
        && apt-get autoremove \
        && apt-get clean \
        && rm -rf /var/lib/apt/lists/*


Dockerfile 引入 `HereDoc`_ 功能，在文件起始使用 ``# syntax=docker/dockerfile:1.3-labs``
宣告启用该语法，用以简化 Dockerfile：

.. code-block:: shell
  :emphasize-lines: 1

    # syntax=docker/dockerfile:1.3-labs
    FROM ubuntu:24.04

    RUN <<EOF
        apt-get update
        apt-get install --no-install-recommends -y
                            sudo \
                            passwd \
                            clang \
                            build-essential \
                            ccache \
                            cmake \
                            autoconf \
                            automake \
        apt-get autoremove
        apt-get clean
        rm -rf /var/lib/apt/lists/*
    EOF


* HereDoc 语法为实验性功能，未来走向尚不明确，建议关注官方发布。
* HereDoc 更为详细的功能建议参考 :doc:`HereDoc 笔记 </shell/heredoc>`

官方参考：

* https://docs.docker.com/build/dockerfile/release-notes/#130-labs
* https://docs.docker.com/reference/dockerfile/#here-documents

网络参考：

* https://www.docker.com/blog/introduction-to-heredocs-in-dockerfiles
* https://jedevc.com/blog/dockerfile-heredocs-intro


.. -----------------------------------------------------------------------------

.. _HereDoc: https://en.wikipedia.org/wiki/Here_document
