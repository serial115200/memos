Sphinx VsCode 配置
================================================================================

Vscode Host 插件
--------------------------------------------------------------------------------

.. literalinclude:: sphinx_vscode_host_ext.conf
    :language: ini


Vscode DevContainer 镜像
--------------------------------------------------------------------------------

镜像参考： https://github.com/sphinx-doc/sphinx-docker-images

GHCR 服务卡顿，建议使用南京大学的镜像服务。

.. include:: /mirrors/nju.edu.cn.rst
    :start-after: nju.edu.cn GHCR SOF
    :end-before:  nju.edu.cn GHCR EOF


Vscode DevContainer 插件
--------------------------------------------------------------------------------

.. literalinclude:: sphinx_vscode_dev_ext.conf
    :diff: sphinx_vscode_host_ext.conf
    :language: diff


VsCode DevContainer 配置
--------------------------------------------------------------------------------

.. literalinclude:: sphinx_devcontainer.json
    :language: json
