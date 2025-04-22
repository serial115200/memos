Linux （Ubuntu）开发环境
================================================================================

安装软件
--------------------------------------------------------------------------------



创建用户
--------------------------------------------------------------------------------

.. code-block::

    sudo sh -c "echo '$(whoami) ALL=(ALL:ALL) NOPASSWD: ALL' > /etc/sudoers.d/$(whoami)"

.. code-block::

    sudo -l

.. code-block::

    adduser chen
    usermod -aG sudo chen
    usermod -aG docker chen

配置 Git 用户

.. code-block::

    git config --global user.name "Your Name"
    git config --global user.email "your.email@address"


生成密钥，上传 github

.. code-block::

    ssh-keygen


安装公钥
