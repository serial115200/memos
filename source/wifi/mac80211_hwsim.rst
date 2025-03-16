mac80211_hwsim 仿真
================================================================================

安装与配置
--------------------------------------------------------------------------------

查看内核版本

    .. code-block::

        ~$ uname -r
        6.8.0-52-generic


查看编译配置

    .. code-block::

        ~$ grep CONFIG_MAC80211_HWSIM /boot/config-$(uname -r)
        CONFIG_MAC80211_HWSIM=m

    如果未编译，建议换系统或自行编译，OpenWRT 系统可以使用 opkg 安装。


安装内核模块

    .. code-block::

        ~$ sudo modprobe mac80211_hwsim

    .. code-block::

        ~$ iw dev
        phy#3
                Unnamed/non-netdev interface
                        wdev 0x300000002
                        addr 42:00:00:00:01:00
                        type P2P-device
                        txpower 20.00 dBm
                Interface wlan1
                        ifindex 12
                        wdev 0x300000001
                        addr 02:00:00:00:01:00
                        type managed
                        txpower 20.00 dBm
        phy#2
                Interface wlan0
                        ifindex 11
                        wdev 0x200000001
                        addr 02:00:00:00:00:00
                        type managed
                        txpower 20.00 dBm


调整模块参数

    .. code-block::

        ~$ modinfo -p mac80211_hwsim
        radios:Number of simulated radios (int)
        channels:Number of concurrent channels (int)
        paged_rx:Use paged SKBs for RX instead of linear ones (bool)
        rctbl:Handle rate control table (bool)
        support_p2p_device:Support P2P-Device interface type (bool)
        mlo:Support MLO (bool)
        regtest:The type of regulatory test we want to run (int)

    .. code-block::

        sudo rmmod mac80211_hwsim
        sudo modprobe mac80211_hwsim radios=3

    .. code-block::

        ~$ ls -1 /sys/module/mac80211_hwsim/parameters/
        channels
        mlo
        paged_rx
        radios
        rctbl
        regtest
        support_p2p_device

    .. code-block::

        ~$ cat /sys/module/mac80211_hwsim/parameters/radios
        3

    .. code-block::

        ~$ iw dev
        phy#8
        Unnamed/non-netdev interface
                wdev 0x800000002
                addr 42:00:00:00:02:00
                type P2P-device
                txpower 20.00 dBm
        Interface wlan2
                ifindex 19
                wdev 0x800000001
                addr 02:00:00:00:02:00
                type managed
                txpower 20.00 dBm
        phy#7
                Interface wlan1
                        ifindex 18
                        wdev 0x700000001
                        addr 02:00:00:00:01:00
                        type managed
                        txpower 20.00 dBm
        phy#6
                Interface wlan0
                        ifindex 17
                        wdev 0x600000001
                        addr 02:00:00:00:00:00
                        type managed
                        txpower 20.00 dBm

    查看参数定义后，先卸载模块，然后修改参数重新插入，sys 目录可查看当前运行参数。


调整与适配
--------------------------------------------------------------------------------

解锁 rfkill 控制

    .. code-block::

        ~$ sudo rfkill list
        0: phy0: Wireless LAN
                Soft blocked: yes
                Hard blocked: no
        1: phy0: Wireless LAN
                Soft blocked: yes
                Hard blocked: no

    .. code-block::

        ~$ sudo rfkill unblock 0

    .. code-block::

        ~$ sudo rfkill unblock wlan

    .. code-block::

        ~$ sudo rfkill list
        0: phy0: Wireless LAN
                Soft blocked: no
                Hard blocked: no
        1: phy0: Wireless LAN
                Soft blocked: no
                Hard blocked: no

    解锁 0 号设备，即 phy0，或解锁全部 Wi-Fi 设备。


取消 NetworkManager 管理

    .. code-block::

        nmcli device set <wlan dev> managed no

    .. code-block::

        # 恢复管理，意义不大
        nmcli device set <wlan dev> managed yes

    NetworkManager 会自动检测接口状态，并修改为配置内容，这将干扰我们命令行操作。


关闭 wpa_supplicant 服务

    .. code-block::

        ~$ systemctl is-enabled wpa_supplicant.service
        enabled

    .. code-block::

        sudo systemctl stop wpa_supplicant.service
        sudo systemctl disable wpa_supplicant.service
        # sudo systemctl mask wpa_supplicant.service

    .. code-block::

        # 恢复 wpa_supplicant 服务
        # sudo systemctl unmask wpa_supplicant.service
        sudo systemctl enable wpa_supplicant.service
        sudo systemctl start wpa_supplicant.service

    通常，我们将自己编译并修改 wpa_supplicant，系统程序会占用资源或干扰我们的程序。
