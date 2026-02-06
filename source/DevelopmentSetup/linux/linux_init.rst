Linux 通用环境配置
================================================================================

创建用户
--------------------------------------------------------------------------------

.. code-block::

    sudo adduser serial115200

.. code-block::

    sudo sh -c "echo '$(whoami) ALL=(ALL:ALL) NOPASSWD: ALL' > /etc/sudoers.d/$(whoami)"
    sudo -l

.. code-block::

    # sudo usermod -aG sudo serial115200
    sudo usermod -aG docker serial115200


配置 Git
--------------------------------------------------------------------------------

.. code-block::

    git config --global user.name "Serial115200"
    git config --global user.email "serial115200@gmail.com"
    git config --global core.editor "vim"


生成密钥，上传 github

.. code-block::

    ssh-keygen
