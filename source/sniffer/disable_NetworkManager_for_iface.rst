取消 NetworkManager 管理
--------------------------------------------------------------------------------

桌面版本的 Linux 系统大多使用 NetworkManager 管理网络，在网络抓包时，我们的临时修改会
被重置，为了避免干扰，应当将抓包网卡从 NetworkManager 中移除。

nmcli 命令行工具可以控制 NetworkManager 并显示网络状态，在本文将用于管理接口。

.. code-block:: bash
    :caption: 显示接口状态

    nmcli device status


.. code-block:: bash
    :caption: 接口状态呈现

    enp0s3       ethernet  connected               Wired connection 1
    lxcbr0       bridge    connected (externally)  lxcbr0
    lo           loopback  unmanaged               --


.. code-block:: bash
    :caption: 接口接管管理

    nmcli device set lxcbr0 managed no      # 将 lxcbr0 移除管理
    nmcli device set lxcbr0 managed yes     # 将 lxcbr0 加入管理
