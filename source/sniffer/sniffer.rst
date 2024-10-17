抓包手册
================================================================================

.. toctree::
    :maxdepth: 1

    ax2xx
    tcpdump
    permission

本文将说明抓包的原理、实现和技巧，并对 Wi-Fi 抓包进行侧重说明。


    sniffer_network
    sniffer_tcpdump
    sniffer_wireshark
    sniffer_hub_switch
    sniffer_wireless

参考资料

* Radiotap is a de facto standard for 802.11 frame injection and reception

  https://www.radiotap.org/

* PCAP next generation file format specification

  https://github.com/IETF-OPSAWG-WG/draft-ietf-opsawg-pcap

* Npcap/WiFi adapters

  https://secwiki.org/w/Npcap/WiFi_adapters

* 常春藤钟声行动

  https://www.navalorder.org/national-history-day-winner-2021-operation-ivy-bells
  https://en.wikipedia.org/wiki/Operation_Ivy_Bells


抓包抓的是什么
--------------------------------------------------------------------------------

让我们化繁为简，以手电筒发送摩尔斯电码为例，当你向对面发送 SOS 时，张三和李四也看到信号，
但只有张三了解摩尔斯电码，因此李四抓取了信号，张三完成了抓包。

从上述例子可以看出，抓包需要两部分，




网络抓包实现
--------------------------------------------------------------------------------


tcpdump 使用
--------------------------------------------------------------------------------


sudo su
groupadd pcap
usermod -a -G pcap $USER
chgrp pcap /usr/sbin/tcpdump
chmod 750 /usr/sbin/tcpdump
setcap cap_net_raw,cap_net_admin=eip /usr/sbin/tcpdump

wireshark 使用
--------------------------------------------------------------------------------

远程抓包
--------------------------------------------------------------------------------

抓包设备
--------------------------------------------------------------------------------


Wi-Fi 抓包
--------------------------------------------------------------------------------

.. include:: disable_NetworkManager_for_iface.rst


pcapng 格式
--------------------------------------------------------------------------------

https://pcapng.com/
https://www.ietf.org/archive/id/draft-tuexen-opsawg-pcapng-05.html
https://github.com/IETF-OPSAWG-WG/draft-ietf-opsawg-pcap
