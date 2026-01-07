ip link 命令
================================================================================

显示链路

.. code-block::

    ip link
    ip link show
    ip link show lo


切换状态

.. code-block::

    ip link set lo up
    ip link set lo down

    ip link set lo multicast on
    ip link set lo multicast off

    ip link set eth1 arp on
    ip link set eth1 arp off

改变参数

.. code-block::

    ip link set eth1 mtu 1500
    ip link set eth1 txqueuelen 1000

修改名字

.. code-block::

    ip link set eth1 name eth10
