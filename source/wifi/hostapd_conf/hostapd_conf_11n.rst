11n 配置
================================================================================

.. code-block::
    :caption: 配置原文

    ##### IEEE 802.11n related configuration ######################################

    # ieee80211n: Whether IEEE 802.11n (HT) is enabled
    # 0 = disabled (default)
    # 1 = enabled
    # Note: You will also need to enable WMM for full HT functionality.
    # Note: hw_mode=g (2.4 GHz) and hw_mode=a (5 GHz) is used to specify the band.
    #ieee80211n=1

    # disable_11n: Boolean (0/1) to disable HT for a specific BSS
    #disable_11n=0

    # ht_capab: HT capabilities (list of flags)
    # LDPC coding capability: [LDPC] = supported
    # Supported channel width set: [HT40-] = both 20 MHz and 40 MHz with secondary
    #	channel below the primary channel; [HT40+] = both 20 MHz and 40 MHz
    #	with secondary channel above the primary channel
    #	(20 MHz only if neither is set)
    #	Note: There are limits on which channels can be used with HT40- and
    #	HT40+. Following table shows the channels that may be available for
    #	HT40- and HT40+ use per IEEE 802.11n Annex J:
    #	freq		HT40-		HT40+
    #	2.4 GHz		5-13		1-7 (1-9 in Europe/Japan)
    #	5 GHz		40,48,56,64	36,44,52,60
    #	(depending on the location, not all of these channels may be available
    #	for use)
    #	Please note that 40 MHz channels may switch their primary and secondary
    #	channels if needed or creation of 40 MHz channel maybe rejected based
    #	on overlapping BSSes. These changes are done automatically when hostapd
    #	is setting up the 40 MHz channel.
    # HT-greenfield: [GF] (disabled if not set)
    # Short GI for 20 MHz: [SHORT-GI-20] (disabled if not set)
    # Short GI for 40 MHz: [SHORT-GI-40] (disabled if not set)
    # Tx STBC: [TX-STBC] (disabled if not set)
    # Rx STBC: [RX-STBC1] (one spatial stream), [RX-STBC12] (one or two spatial
    #	streams), or [RX-STBC123] (one, two, or three spatial streams); Rx STBC
    #	disabled if none of these set
    # HT-delayed Block Ack: [DELAYED-BA] (disabled if not set)
    # Maximum A-MSDU length: [MAX-AMSDU-7935] for 7935 octets (3839 octets if not
    #	set)
    # DSSS/CCK Mode in 40 MHz: [DSSS_CCK-40] = allowed (not allowed if not set)
    # 40 MHz intolerant [40-INTOLERANT] (not advertised if not set)
    # L-SIG TXOP protection support: [LSIG-TXOP-PROT] (disabled if not set)
    #ht_capab=[HT40-][SHORT-GI-20][SHORT-GI-40]

    # Require stations to support HT PHY (reject association if they do not)
    #require_ht=1

    # If set non-zero, require stations to perform scans of overlapping
    # channels to test for stations which would be affected by 40 MHz traffic.
    # This parameter sets the interval in seconds between these scans. Setting this
    # to non-zero allows 2.4 GHz band AP to move dynamically to a 40 MHz channel if
    # no co-existence issues with neighboring devices are found.
    #obss_interval=0

    # ht_vht_twt_responder: Whether TWT responder is enabled in HT and VHT modes
    # 0 = disable; Disable TWT responder support in  HT and VHT modes (default).
    # 1 = enable; Enable TWT responder support in HT and VHT modes if supported by
    # the driver.
    #ht_vht_twt_responder=0


.. code-block::
    :caption: OpenWRT 配置修正

    uci set wireless.radio0.ldpc=0
    uci set wireless.radio0.rx_stbc=0
    uci set wireless.radio0.max_amsdu=0
    uci commit wireless
    reload_config

* mac80211_hwsim 设备不支持以上参数，待详查，影响如下


.. code-block::
    :caption: OpenWRT 配置修正影响

    # 原始
    ht_capab=[LDPC][SHORT-GI-20][RX-STBC123][MAX-AMSDU-7935][DSSS_CCK-40]

    # 修正
    ht_capab=[SHORT-GI-20][SHORT-GI-40][DSSS_CCK-40]

* 测试频段为 2.4G，其他频段的修正待查，mac80211_hwsim 仿真理论上可以欺骗 mac 层
* 高通驱动在 sys 目录下直接导出支持的 capabilities，mac80211 使用 iw 命令，有待改进


选项解析
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

* 启用 802.11n

.. code-block::

    ieee80211n=1
    #disable_11n=0


* ht_capab 配置

.. code-block::

    ieee80211n=1
    #disable_11n=0
