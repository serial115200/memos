nlmon 接口
================================================================================

nlmon 是 Netlink Monitor 接口，可以窥探 Netlink 的交互流程。


首先，确认内核配置是否启用该功能：

.. code-block:: shell

    ~$ grep NLMON /boot/config-$(uname -r)
    CONFIG_NLMON=m


从返回值来看，模块已编译，但未加载，使用以下命令加载并创建接口：

.. code-block:: shell

    sudo modprobe nlmon
    sudo ip link add nlmon0 type nlmon
    sudo ip link set nlmon0 up


.. code-block:: shell

    sudo tcpdump -i nlmon0 -w nlmsg.pcap


* tcpdump 不支持解析 Netlink ，需交由其他软件处理。
* Wireshark 可解码常见报文，其余协议需编写 lua 插件。
* Wireshark 和 tcpdump 配合，进行远程抓包是不错的方案。
* Wireshark 解码依赖 ID 和模块映射关系，因此报文不能随意拆分。

.. todo::

    ID 和模块映射关系建议阅读 netlink 篇章，尚未完成。
