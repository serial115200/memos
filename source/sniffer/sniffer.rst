抓包笔记
================================================================================

本文将阐述抓包的原理、实现和技巧，并对 Wi-Fi 抓包进行侧重说明。


.. toctree::
    :maxdepth: 1

    sniffer_intro
    sniffer_tcpdump
    sniffer_permission
    sniffer_decrypt_802.11

    sniffer_ax2xx

.. todo::

    * 完成 sniffer_wireshark 文档
    * 完成 sniffer_hub_switch 文档
    * 完成 sniffer_80211 文档


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



网络抓包实现
--------------------------------------------------------------------------------


tcpdump 使用
--------------------------------------------------------------------------------


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
