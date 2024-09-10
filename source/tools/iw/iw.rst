iw 命令
================================================================================

项目地址: https://git.kernel.org/pub/scm/linux/kernel/git/jberg/iw.git


https://wireless.wiki.kernel.org/en/users/documentation/iw

无线设备
--------------------------------------------------------------------------------

由于电磁波在空间传播的



常用命令
--------------------------------------------------------------------------------
查看版本

    .. code-block::

        ~$ iw --version
        iw version 5.16


查看设备

    .. code-block::

        iw dev

查看 phy


查看 interface



监管域/国家码

    .. code-block::

        sudo iw reg get

    .. code-block::

        sudo iw reg get

    .. code-block::

        sudo iw reg set CN


iw 杂项
--------------------------------------------------------------------------------

查看 nl80211 特性，与设备无关
    .. code-block::

        iw features

        nl80211 features: 0x1
                * split wiphy dump
