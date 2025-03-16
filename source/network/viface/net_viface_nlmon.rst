nlmon
--------------------------------------------------------------------------------

nlmon 是 Netlink monitor 设备，可以窥探用户态和内核的交互流程。

.. code-block::

    ~$ grep NLMON /boot/config-$(uname -r)
    CONFIG_NLMON=m


.. code-block::

    sudo modprobe nlmon
    sudo ip link add nlmon0 type nlmon
    sudo ip link set nlmon0 up

.. code-block::

    sudo tcpdump -i nlmon0 -w nlmsg.pcap

Wireshark 可以解码常见应用的报文，自定义协议需要自行编写 lua 插件。

模块在加载时，Netlink 框架为其分配 ID，用户态通常先获取 ID 和模块名的映射消息，通过比对
模块名获取 ID，然后使用 ID 通信。Wireshark 确定解码插件依赖映射消息，因此报文不能拆分。
