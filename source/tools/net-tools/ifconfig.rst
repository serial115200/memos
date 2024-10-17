ifconfig 命令
================================================================================

软件安装
--------------------------------------------------------------------------------

安装确认

    .. code-block:: bash

        ifconfig -V

如已安装，则输出版本信息，可跳过本节

    .. code-block:: text

        net-tools 2.10-alpha

如未安装，则输出错误提示，按提示安装

    .. code-block:: text

        bash: ifconfig: command not found

Ubuntu 发行版

    .. code-block:: bash

        sudo apt update -y && sudo apt install -y net-tools

其余发行版见：https://command-not-found.com/ifconfig


查看参数
--------------------------------------------------------------------------------

显示所有 UP 状态的接口信息

    .. code-block:: bash

        ifconfig

显示所有的接口信息，包括 DOWN 状态的接口

    .. code-block:: bash

        ifconfig -a

显示指定接口的信息，如 eth0

    .. code-block:: bash

        ifconfig eth0

以 `ifconfig eth0` 为例，输入后会显示如下接口信息

    .. code-block:: text

        eth0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
                inet 172.17.0.3  netmask 255.255.0.0  broadcast 172.17.255.255
                ether 02:42:ac:11:00:03  txqueuelen 0  (Ethernet)
                RX packets 13074  bytes 21128354 (21.1 MB)
                RX errors 0  dropped 0 overruns 0  frame 0
                TX packets 10491  bytes 912046 (912.0 KB)
                TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

`ifconfig` 与 `ifconfig -a` 则会遍历相应的接口，并用以上形式进行呈现。


配置参数
--------------------------------------------------------------------------------

.. warning:: 参数变动可能导致主机无法访问，请慎重操作，建议使用虚拟机。

启用接口

    .. code-block:: bash

        ifconfig eth0 up

禁用接口

    .. code-block:: bash

        ifconfig eth0 down

配置网络地址

    .. code-block:: bash

        ifconfig eth0 192.168.1.1

配置子网掩码

    .. code-block:: bash

        ifconfig eth0 192.168.1.1

设置最大传输单元(MTU)

    .. code-block:: bash

        ifconfig eth0 mtu 1000

配置硬件地址

    .. code-block:: bash

        ifconfig eth0 hw ether 00:11:22:33:44:55

配置 flags

    .. code-block:: text

        eth0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
