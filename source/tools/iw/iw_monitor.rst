iw monitor 接口
================================================================================

查看 PHY

    .. code-block::

        ~$ ls /sys/class/ieee80211/
        phy4  phy5


phy id 会动态分配，创建接口需要指定 phy，上面存在 phy4 和 phy5。


创建 monitor 接口，其中 phy4 为指定 phy，mon0 为 monitor 接口名

    .. code-block::

        sudo iw phy phy4 interface add mon0 type monitor


查看全部接口
