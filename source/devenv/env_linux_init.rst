初始化环境
================================================================================

安装软件
--------------------------------------------------------------------------------


创建用户
--------------------------------------------------------------------------------

.. code-block::

    adduser chen

    usermod -aG sudo chen
    usermod -aG docker chen


配置 sudo 免密

.. code-block:: diff
    :caption: 免密运行

    --- /etc/sudoers.bak
    +++ /etc/sudoers

    # allow members of group sudo to execute any command without a password
    -%sudo  ALL=(ALL) ALL
    +%sudo  ALL=(ALL) NOPASSWD: ALL

    # allow the dummy to execute any command without a password
    + dummy ALL=(ALL) NOPASSWD: ALL


配置 Git 用户

.. code-block::

    git config --global user.name "Your Name"
    git config --global user.email "your.email@address"


生成密钥，上传 github

.. code-block::

    ssh-keygen


安装公钥
