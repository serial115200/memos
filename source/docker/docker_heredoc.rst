Dokcer HereDoc 介绍
================================================================================

Dockerfile 每条指令对应一层镜像，最佳实践通常使用 `&&` 连接命令，使用 `\\` 换行：

.. code-block:: shell

    FROM ubuntu:24.04

    RUN apt-get update      && \
        apt-get upgrade -y  && \
        apt-get install -y ...

Dockerfile 在 1.3.0 labs 引入了 `HereDoc`_ 功能，用以简化 Dockerfile 的书写。在文件
起始使用 `# syntax=docker/dockerfile:1.3-labs` 宣告启用 `HereDoc`_ 语法：

.. code-block:: shell
  :emphasize-lines: 1

    # syntax=docker/dockerfile:1.3-labs

    FROM ubuntu:24.04

    RUN <<EOF
        apt-get update
        apt-get upgrade -y
        apt-get install -y ...
    EOF

HereDoc 语法为实验性功能，未来走向尚不明确，建议关注官方发布。

官方参考：

* https://docs.docker.com/build/dockerfile/release-notes/#130-labs
* https://docs.docker.com/reference/dockerfile/#here-documents

网络参考：

* https://www.docker.com/blog/introduction-to-heredocs-in-dockerfiles
* https://jedevc.com/blog/dockerfile-heredocs-intro


.. External links---------------------------------------------------------------
.. _HereDoc: https://en.wikipedia.org/wiki/Here_document
