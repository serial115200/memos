定制 Board 信息
================================================================================

OpenWRT 的启动流程大致为 Procd 作为 init 进程，首先运行 ubusd 进程，为后续进程提供进
程间通信服务，随后做一些简单的初始化操作，最终由 /etc/init.d 目录下脚本启动应用。因此
Board 信息需要在第一个应用启动前配置。

在设置 Board 信息前，系统还需要先创建 ramfs 相关文件，随后挂载文件系统和加载必要的驱动。
该功能由 /etc/init.d/boot 脚本处理，有几点需要说明:

* 启动脚本的 boot 函数在初始化时被调用，这是启动脚本的内建特性
* boot 启动脚本不会启动任何应用，只是简单利用了上一点说明的特性
* 应用的启动优先级不能高于改脚本，也就是 START 的值大于 10

因此 Board 信息的配置在驱动加载（kmodloader）之后，由 config_generate 和 uci_apply_defaults 生成。

.. code-block:: bash

    boot() {
            ......
            /sbin/kmodloader

            [ ! -f /etc/config/wireless ] && {
                    # compat for brcm47xx and mvebu
                    sleep 1
            }

            /bin/config_generate
            uci_apply_defaults

            # temporary hack until configd exists
            /sbin/reload_config
    }

uci defaults 配置
---------------------------------------------

UCI 系统负责保存 OpenWRT 的配置，后续应用都依赖相关配置，uci defaults 允许用户在 /etc/uci-defaults 目录直接添加脚本，配置参数，这提供极大的操作空间。如果配置成功，脚本则会被删除，否则在下次启动时再次配置。

.. code-block:: Shell

    uci_apply_defaults() {
            . /lib/functions/system.sh

            cd /etc/uci-defaults || return 0
            files="$(ls)"
            [ -z "$files" ] && return 0
            mkdir -p /tmp/.uci
            for file in $files; do
                    ( . "./$(basename $file)" ) && rm -f "$file"
            done
            uci commit
    }

uci defaults 的设计初衷是为 UCI 默认配置提供更大的灵活性，但现在也用于其它操作。遵守初衷与否是复杂的问题，需要视情况而定。

.. code-block:: Shell
    :caption: uci defaults 仅配置 uci 参数

    #!/bin/sh
    #
    # Copyright (C) 2010 OpenWrt.org
    #

    dev="$(uci -q get network.@switch_vlan[0].device)"
    vlan="$(uci -q get network.@switch_vlan[0].vlan)"

    if [ "$dev" = "rtl8366s" ] && [ "$vlan" = 0 ]; then
            logger -t vlan-migration "VLAN 0 is invalid for RTL8366s, changing to 1"
            uci set network.@switch_vlan[0].vlan=1
            uci commit network
    fi


.. code-block:: Shell
    :caption: uci defaults 进行其它操作

    #!/bin/sh
    #
    # Copyright (C) 2010 OpenWrt.org
    #

    . /lib/functions.sh

    board=$(board_name)

    fixtrx() {
            mtd -o 32 fixtrx firmware
    }

    fixwrgg() {
            local kernel_size=$(sed -n 's/mtd[0-9]*: \([0-9a-f]*\).*"kernel".*/\1/p' /proc/mtd)

            [ "$kernel_size" ] && mtd -c 0x$kernel_size fixwrgg firmware
    }

    case "$board" in
    mynet-rext |\
    wrt160nl)
            fixtrx
            ;;
    dap-2695-a1)
            fixwrgg
            ;;
    esac

config_generate 配置
---------------------------------------------

config_generate 配置只负责 network 与 system ，先生成模板数据，然后根据 /etc/board.json 文件进行修正，而 board.json 配置文件由 /etc/board.d/ 目录下的脚本生成。

.. code-block:: Shell

    $ls
    01_leds           02_network        03_gpio_switches

    $cat 02_network
    #!/bin/sh
    #
    # Copyright (c) 2015 The Linux Foundation. All rights reserved.
    # Copyright (c) 2011-2015 OpenWrt.org
    #

    . /lib/functions/uci-defaults.sh
    . /lib/functions/system.sh

    board_config_update

    board=$(board_name)

    case "$board" in
    8dev,jalapeno)
            ucidef_set_interfaces_lan_wan "eth0" "eth1"
            ;;
    asus,rt-ac58u)
            CI_UBIPART=UBI_DEV
            wan_mac_addr=$(mtd_get_mac_binary_ubi Factory 20486)
            lan_mac_addr=$(mtd_get_mac_binary_ubi Factory 4102)
            ucidef_set_interfaces_lan_wan "eth0" "eth1"
            ucidef_add_switch "switch0" "0u@eth0" "1:lan" "2:lan" "3:lan" "4:lan"
            ucidef_set_interface_macaddr "lan" "$lan_mac_addr"
            ucidef_set_interface_macaddr "wan" "$wan_mac_addr"
            ;;
    *)
            echo "Unsupported hardware. Network interfaces not intialized"
            ;;
    esac

    board_config_flush

    exit 0

在 board.d 目录下，不同的配置拆分在若干文件中，system.sh 负责获取 MAC 地址，而 uci-defaults.sh 提供写入 board.json 的接口，包括 led、网口、ntp server 等等。uci-defaults.sh 的接口与 config_generate 相对应，因此我们只需要关注 uci-defaults.sh 中的函数。

此外，为严谨起见，会对系统设备是否存在进行判断，这也是 boot 函数先加载必要驱动的原因。

.. code-block:: console

    [ -d /sys/class/net/eth1 ] && ucidef_set_interface_wan 'eth1

uci defaults 配置与 config_generate 配置将 Board 信息统一存在了两个目录，这为管理和定制 Board 信息提供了便利。
