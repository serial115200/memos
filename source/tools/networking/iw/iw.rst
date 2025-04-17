iw 命令
================================================================================

项目地址: https://git.kernel.org/pub/scm/linux/kernel/git/jberg/iw.git


.. toctree::
    :maxdepth: 1

    iw_monitor


无线设备
--------------------------------------------------------------------------------

由于电磁波在空间传播的



常用命令
--------------------------------------------------------------------------------
查看版本

.. code-block::

    ~$ iw --version
    iw version 5.16


查看接口

.. code-block::

    ~$ iw dev
    phy#1
        Interface phy1-sta0
                ifindex 18
                wdev 0x100000002
                addr 02:00:00:00:01:00
                type managed
                txpower 30.00 dBm
    phy#0
        Interface phy0-ap0
                ifindex 19
                wdev 0x2
                addr 02:00:00:00:00:00
                ssid OpenWrt
                type AP
                channel 36 (5180 MHz), width: 20 MHz, center1: 5180 MHz
                txpower 23.00 dBm


查看 PHY

.. code-block::

    ~$ ls /sys/class/ieee80211/
    phy0  phy1

    iw list     # 更为详细的信息
    iw phy      # 同上


查看状态

.. code-block::

    iw dev <devname> info  # 接口信息
    iw dev <devname> link  # 连接状态


事件监控

.. code-block::

    iw event


监管域/国家码

.. code-block::

    iw reg get
    iw reg set <ISO/IEC 3166-1 alpha2>
    iw phy <phyname> reg get
    iw reg reload

.. code-block::

    sudo iw reg set CN


信道相关

.. code-block::

    iw phy <phyname> channels   # 获取信道，相当于 iwlist <interface> channel

    iw phy <phyname> set freq <freq> [NOHT|HT20|HT40+|HT40-|5MHz|10MHz|80MHz|160MHz]
    iw phy <phyname> set freq <control freq> [5|10|20|40|80|80+80|160] [<center1_freq> [<center2_freq>]]
    iw dev <devname> set freq <freq> [NOHT|HT20|HT40+|HT40-|5MHz|10MHz|80MHz|160MHz]
    iw dev <devname> set freq <control freq> [5|10|20|40|80|80+80|160] [<center1_freq> [<center2_freq>]]
    iw phy <phyname> set channel <channel> [NOHT|HT20|HT40+|HT40-|5MHz|10MHz|80MHz|160MHz]
    iw dev <devname> set channel <channel> [NOHT|HT20|HT40+|HT40-|5MHz|10MHz|80MHz|160MHz]

namespace

.. code-block::

    phy <phyname> set netns { <pid> | name <nsname> }


接口增删

.. code-block::

    iw phy <phyname> interface add <name> type <type> [mesh_id <meshid>] [4addr on|off] [flags <flag>*] [addr <mac-addr>]
    iw dev <devname> interface add <name> type <type> [mesh_id <meshid>] [4addr on|off] [flags <flag>*] [addr <mac-addr>]
    iw dev <devname> del



iw 杂项
--------------------------------------------------------------------------------

查看 nl80211 特性，与设备无关

.. code-block::

    iw features

    nl80211 features: 0x1
            * split wiphy dump


查看支持的 nl80211 命令

.. code-block::

    iw commands
