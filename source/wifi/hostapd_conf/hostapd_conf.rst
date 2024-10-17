hostapd 配置解析
================================================================================

* hostapd v2.11
* openwrt v23.05.2

.. toctree::

    hostapd_conf_l2
    hostapd_conf_11n
    hostapd_conf_11ac
    hostapd_conf_11ax
    hostapd_conf_11be
    hostapd_conf_acl
    hostapd_conf_acs
    hostapd_conf_log
    hostapd_conf_edmg
    hostapd_conf_airtime
    hostapd_conf_hotspot20


基础内容
--------------------------------------------------------------------------------

接口配置
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: shell

    # AP netdevice name (without 'ap' postfix, i.e., wlan0 uses wlan0ap for
    # management frames with the Host AP driver); wlan0 with many nl80211 drivers
    # Note: This attribute can be overridden by the values supplied with the '-i'
    # command line parameter.
    interface=wlan0

.. code-block::

    interface=phy0-ap0

* `-i` 选项可以覆盖该配置，实现配置文件的复用
* OpenWRT 目前使用 phy[phy id]-[iface type][iface id] 的方式命名
* OpenWRT UCI 未出现该配置，猜测配置是自动生成


网桥配置
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block::

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

.. code-block::

    bridge=br-lan

.. code-block::
    :emphasize-lines: 3

    config wifi-iface
        option device 'radio1'
        option network 'lan'
        option mode 'ap'
        option ssid 'test'
        option encryption 'psk2'
        option key '12345678'

* 可选项，atheros 和 nl80211 驱动支持该选项，简化操作
* linux_ioctl.c 包含网桥相关操作，后续是否会升级为 netlink
* OpenWRT 的 AP 接口通常会加入 br-lan 网桥


驱动配置
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block::

    # Driver interface type (hostap/wired/none/nl80211/bsd);
    # default: hostap). nl80211 is used with all Linux mac80211 drivers.
    # Use driver=none if building hostapd as a standalone RADIUS server that does
    # not control any wireless/wired driver.
    # driver=hostap

.. code-block::

    driver=nl80211

.. code-block::
    :emphasize-lines: 2

    config wifi-device 'radio1'
            option type 'mac80211'
            option path 'virtual/mac80211_hwsim/hwsim0'
            option channel '1'
            option band '2g'
            option cell_density '0'

* 目前驱动大多为 nl80211
* OpenWRT 自动侦测该选项，具体文件待考证
* 理论上为 mac80211 必然适配 nl80211，实际有待考证


调试参数
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block::

    # Driver interface parameters (mainly for development testing use)
    # driver_params=<params>

* 参数接口，强制配置参数，对于开发而言值得研究


日志配置
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block::

    # hostapd event logger configuration
    #
    # Two output method: syslog and stdout (only usable if not forking to
    # background).
    #
    # Module bitfield (ORed bitfield of modules that will be logged; -1 = all
    # modules):
    # bit 0 (1) = IEEE 802.11
    # bit 1 (2) = IEEE 802.1X
    # bit 2 (4) = RADIUS
    # bit 3 (8) = WPA
    # bit 4 (16) = driver interface
    # bit 6 (64) = MLME
    #
    # Levels (minimum value for logged events):
    #  0 = verbose debugging
    #  1 = debugging
    #  2 = informational messages
    #  3 = notification
    #  4 = warning
    #
    logger_syslog=-1
    logger_syslog_level=2
    logger_stdout=-1
    logger_stdout_level=2

.. code-block::

    logger_syslog=127
    logger_syslog_level=2
    logger_stdout=127
    logger_stdout_level=2

.. code-block::

    hostapd_set_log_options() {
        local var="$1"

        local log_level log_80211 log_8021x log_radius log_wpa log_driver log_iapp log_mlme
        json_get_vars log_level log_80211 log_8021x log_radius log_wpa log_driver log_iapp log_mlme

        set_default log_level 2
        set_default log_80211  1
        set_default log_8021x  1
        set_default log_radius 1
        set_default log_wpa    1
        set_default log_driver 1
        set_default log_iapp   1
        set_default log_mlme   1

        local log_mask="$(( \
            ($log_80211  << 0) | \
            ($log_8021x  << 1) | \
            ($log_radius << 2) | \
            ($log_wpa    << 3) | \
            ($log_driver << 4) | \
            ($log_iapp   << 5) | \
            ($log_mlme   << 6)   \
        ))"

        append "$var" "logger_syslog=$log_mask" "$N"
        append "$var" "logger_syslog_level=$log_level" "$N"
        append "$var" "logger_stdout=$log_mask" "$N"
        append "$var" "logger_stdout_level=$log_level" "$N"

        return 0
    }

* 日志分为模块和级别两部分，可选值见上文
* hostapd 和 OpenWRT 的默认配置都开启了全部模块的日志
* OpenWRT 中为 radio 参数，UCI 参数分别为 log_{*} 和 log_level


控制接口
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block::

    # Interface for separate control program. If this is specified, hostapd
    # will create this directory and a UNIX domain socket for listening to requests
    # from external programs (CLI/GUI, etc.) for status information and
    # configuration. The socket file will be named based on the interface name, so
    # multiple hostapd processes/interfaces can be run at the same time if more
    # than one interface is used.
    # /var/run/hostapd is the recommended directory for sockets and by default,
    # hostapd_cli will use it when trying to connect with hostapd.
    ctrl_interface=/var/run/hostapd

    # Access control for the control interface can be configured by setting the
    # directory to allow only members of a group to use sockets. This way, it is
    # possible to run hostapd as root (since it needs to change network
    # configuration and open raw sockets) and still allow GUI/CLI components to be
    # run as non-root users. However, since the control interface can be used to
    # change the network configuration, this access needs to be protected in many
    # cases. By default, hostapd is configured to use gid 0 (root). If you
    # want to allow non-root users to use the control interface, add a new group
    # and change this value to match with that group. Add users that should have
    # control interface access to this group.
    #
    # This variable can be a group name or gid.
    #ctrl_interface_group=wheel
    ctrl_interface_group=0

.. code-block::

    ctrl_interface=/var/run/hostapd

* 提供接口给 hostapd_cli 进行控制，可以同时存在 global 和 interface 控制接口
* OpenWRT 提供了该接口，但未提供 hostapd_cli，添加补丁后，通过 ubus 接口通信
* 控制组部分目前未使用，可能因为使用了 namespace（ujail） 进行安全防护
* 值得单独开启一章


协议基本配置
--------------------------------------------------------------------------------

SSID 配置
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block::

    # SSID to be used in IEEE 802.11 management frames
    ssid=test
    # Alternative formats for configuring SSID
    # (double quoted string, hexdump, printf-escaped string)
    #ssid2="test"
    #ssid2=74657374
    #ssid2=P"hello\nthere"

    # UTF-8 SSID: Whether the SSID is to be interpreted using UTF-8 encoding
    #utf8_ssid=1

.. code-block::

    utf8_ssid=1
    ssid=test

.. code-block::
    :emphasize-lines: 5,8

    config wifi-iface
            option device 'radio1'
            option network 'lan'
            option mode 'ap'
            option ssid 'test'
            option encryption 'psk2'
            option key '12345678'
            option utf8_ssid '1'       # 默认为 1

* 稀奇古怪的 SSID 配置不建议使用
* SSID 最多的问题就是非 ASCII 码，个人推测 utf8_ssid 选项是为了解决该问题
* OpenWRT 默认开启 utf8_ssid，是否存在兼容性问题


国家及其相关参数
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block::

    # Country code (ISO/IEC 3166-1). Used to set regulatory domain.
    # Set as needed to indicate country in which device is operating.
    # This can limit available channels and transmit power.
    # These two octets are used as the first two octets of the Country String
    # (dot11CountryString)
    #country_code=US

    # The third octet of the Country String (dot11CountryString)
    # This parameter is used to set the third octet of the country string.
    #
    # All environments of the current frequency band and country (default)
    #country3=0x20
    # Outdoor environment only
    #country3=0x4f
    # Indoor environment only:q
    #country3=0x49
    # Noncountry entity (country_code=XX)
    #country3=0x58
    # IEEE 802.11 standard Annex E table indication: 0x01 .. 0x1f
    # Annex E, Table E-4 (Global operating classes)
    #country3=0x04

    # Enable IEEE 802.11d. This advertises the country_code and the set of allowed
    # channels and transmit power levels based on the regulatory limits. The
    # country_code setting must be configured with the correct country for
    # IEEE 802.11d functions.
    # (default: 0 = disabled)
    #ieee80211d=1

    # Enable IEEE 802.11h. This enables radar detection and DFS support if
    # available. DFS support is required on outdoor 5 GHz channels in most countries
    # of the world. This can be used only with ieee80211d=1.
    # (default: 0 = disabled)
    #ieee80211h=1

    # Add Power Constraint element to Beacon and Probe Response frames
    # This config option adds Power Constraint element when applicable and Country
    # element is added. Power Constraint element is required by Transmit Power
    # Control. This can be used only with ieee80211d=1.
    # Valid values are 0..255.
    #local_pwr_constraint=3

    # Set Spectrum Management subfield in the Capability Information field.
    # This config option forces the Spectrum Management bit to be set. When this
    # option is not set, the value of the Spectrum Management bit depends on whether
    # DFS or TPC is required by regulatory authorities. This can be used only with
    # ieee80211d=1 and local_pwr_constraint configured.
    #spectrum_mgmt_required=1


模式与信道
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block::

    # Operation mode (a = IEEE 802.11a (5 GHz), b = IEEE 802.11b (2.4 GHz),
    # g = IEEE 802.11g (2.4 GHz), ad = IEEE 802.11ad (60 GHz); a/g options are used
    # with IEEE 802.11n (HT), too, to specify band). For IEEE 802.11ac (VHT), this
    # needs to be set to hw_mode=a. For IEEE 802.11ax (HE) on 6 GHz this needs
    # to be set to hw_mode=a. When using ACS (see channel parameter), a
    # special value "any" can be used to indicate that any support band can be used.
    # This special case is currently supported only with drivers with which
    # offloaded ACS is used.
    # Default: IEEE 802.11b
    hw_mode=g

    # Channel number (IEEE 802.11)
    # (default: 0, i.e., not set)
    # Please note that some drivers do not use this value from hostapd and the
    # channel will need to be configured separately with iwconfig.
    #
    # If CONFIG_ACS build option is enabled, the channel can be selected
    # automatically at run time by setting channel=acs_survey or channel=0, both of
    # which will enable the ACS survey based algorithm.
    channel=1

.. code-block::


基础参数
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block::

    # Beacon interval in kus (1.024 ms) (default: 100; range 15..65535)
    beacon_int=100

    # DTIM (delivery traffic information message) period (range 1..255):
    # number of beacons between DTIMs (1 = every beacon includes DTIM element)
    # (default: 2)
    dtim_period=2

    # Maximum number of stations allowed in station table. New stations will be
    # rejected after the station table is full. IEEE 802.11 has a limit of 2007
    # different association IDs, so this number should not be larger than that.
    # (default: 2007)
    max_num_sta=255

    # RTS/CTS threshold; -1 = disabled (default); range -1..65535
    # If this field is not included in hostapd.conf, hostapd will not control
    # RTS threshold and 'iwconfig wlan# rts <val>' can be used to set it.
    rts_threshold=-1

    # Fragmentation threshold; -1 = disabled (default); range -1, 256..2346
    # If this field is not included in hostapd.conf, hostapd will not control
    # fragmentation threshold and 'iwconfig wlan# frag <val>' can be used to set
    # it.
    fragm_threshold=-1




未知选项
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block::

    # Global operating class (IEEE 802.11, Annex E, Table E-4)
    # This option allows hostapd to specify the operating class of the channel
    # configured with the channel parameter. channel and op_class together can
    # uniquely identify channels across different bands, including the 6 GHz band.
    #op_class=131
