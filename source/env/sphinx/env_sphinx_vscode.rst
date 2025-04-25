Sphinx VsCode 配置
================================================================================

Vscode Host 插件
--------------------------------------------------------------------------------

.. literalinclude:: env_sphinx_vscode_host_ext.conf
    :language: ini

Vscode Docker 镜像
--------------------------------------------------------------------------------

镜像参考：

    * https://github.com/sphinx-doc/sphinx-docker-images



Vscode DevContainer 插件
--------------------------------------------------------------------------------

.. literalinclude:: ./env_sphinx_vscode_dev_ext.conf
    :diff: ./env_sphinx_vscode_host_ext.conf


VsCode DevContainer 配置
--------------------------------------------------------------------------------

.. literalinclude:: env_sphinx_devcontainer.json
    :language: json
