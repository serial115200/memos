二层网络
================================================================================

网桥配置
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block::
    :caption: 配置原文

    # In case of atheros and nl80211 driver interfaces, an additional
    # configuration parameter, bridge, may be used to notify hostapd if the
    # interface is included in a bridge. This parameter is not used with Host AP
    # driver. If the bridge parameter is not set, the drivers will automatically
    # figure out the bridge interface (assuming sysfs is enabled and mounted to
    # /sys) and this parameter may not be needed.
    #
    # For nl80211, this parameter can be used to request the AP interface to be
    # added to the bridge automatically (brctl may refuse to do this before hostapd
    # has been started to change the interface mode). If needed, the bridge
    # interface is also created.
    #bridge=br0

* linux_ioctl.c 包含网桥相关操作，后续是否会升级为 netlink


.. code-block::
    :caption: OpenWRT 默认配置

    bridge=br-lan

* OpenWRT 作为路由器，AP 通常加入 lan 网桥


.. code-block::
    :caption: OpenWRT 配置脚本

    待确认


.. code-block::
    :caption: OpenWRT uci 配置
    :emphasize-lines: 6

    config wifi-iface 'wifinet0'
        option device 'radio1'
        option mode 'ap'
        option ssid 'OpenWrt'
        option encryption 'none'
        option network 'lan'

* 此处的 lan 即为 br-lan，OpenWRT 的网络接口概念建议阅读 netifd 的设计思想


.. code-block::
    :caption: OpenWRT uci 配置命令

    uci set wireless.wifinet0.network='lan'


VLAN 配置
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

待定
