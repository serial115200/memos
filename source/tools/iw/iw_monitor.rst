iw monitor 接口
================================================================================

如果配置失败或者被重置，建议先确认一下信息

* rfkill 是否关闭
* NetworkManager 是否取消对该接口的管理

查看 PHY

.. literalinclude:: iw_monitor_iw_dev.txt


理论上 PHY 加载时会创建默认 managed 接口，但也可能不创建，还可以直接查看注册的 PHY

.. code-block::

    ~$ ls /sys/class/ieee80211/
    phy0  phy1


.. code-block::

    sudo iw phy phy0 interface add mon0 type monitor
    sudo iw dev wlan0 del
    sudo ip link set dev mon0 up


.. code-block::

    #sudo iw dev mon0 set freq 2437
    sudo iw dev mon0 set channel 36


.. code-block::

    sudo tcpdump -i mon0 -n -w wireless.cap


复原环境

.. code-block::

    sudo iw dev mon0 del
    sudo iw phy phy0 interface add wlan0 type managed
