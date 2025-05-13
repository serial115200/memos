nlmon 接口
--------------------------------------------------------------------------------

nlmon 是 Netlink monitor 接口，可以窥探 Netlink 的交互流程。


首先，确认内核配置是否启用该功能：

.. code-block:: shell

    ~$ grep NLMON /boot/config-$(uname -r)
    CONFIG_NLMON=m


从返回值来看，模块已经编译进内核，但并没有加载。

.. code-block:: shell

    sudo modprobe nlmon
    sudo ip link add nlmon0 type nlmon
    sudo ip link set nlmon0 up


.. code-block:: shell

    sudo tcpdump -i nlmon0 -w nlmsg.pcap


* tcpdump 尚不支持解析 Netlink ，需交由 Wireshark 解析。
* Wireshark 可解码常见报文，但多数协议需自行编写 lua 插件。
* Wireshark 解码器选择依赖内核返回的 ID 和模块映射关系，因此报文不能简单拆分。
* 建议使用 Wireshark 远程抓包。
