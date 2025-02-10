日志配置
================================================================================

.. code-block::
    :caption: 配置原文

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

* 实现使用 `unsigned int` 表示 logger_syslog 和 logger_stdout


.. code-block::
    :caption: OpenWRT 默认配置

    logger_syslog=127
    logger_syslog_level=2
    logger_stdout=127
    logger_stdout_level=2

* OpenWRT 的 log 组件 buffer 会循环记录日志，使用 logread 进行查看


.. code-block::
    :caption: OpenWRT hostapd 脚本

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

* log_level 控制 logger_{*}_level，默认级别为 2
* log_{*} 可以分别进行控制各个模块，默认控制为全开
* 脚本存在 bit 5，即 iapp 的控制，需要考证
* 注意：配置级别为 radio，而不是 iface

.. code-block::
    :caption: OpenWRT uci 配置命令

    uci set wireless.radio0.log_level='4'
    uci set wireless.radio0.log_80211=1
    uci set wireless.radio0.log_8021x=1
    uci set wireless.radio0.log_radius=1
    uci set wireless.radio0.log_wpa=1
    uci set wireless.radio0.log_driver=1
    uci set wireless.radio0.log_iapp=1
    uci set wireless.radio0.log_mlme=1
