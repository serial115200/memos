访问控制 ACL
================================================================================

.. code-block::

    # Station MAC address -based authentication
    # Please note that this kind of access control requires a driver that uses
    # hostapd to take care of management frame processing and as such, this can be
    # used with driver=hostap or driver=nl80211, but not with driver=atheros.
    # 0 = accept unless in deny list
    # 1 = deny unless in accept list
    # 2 = use external RADIUS server (accept/deny lists are searched first)
    macaddr_acl=0

    # Accept/deny lists are read from separate files (containing list of
    # MAC addresses, one per line). Use absolute path name to make sure that the
    # files can be read on SIGHUP configuration reloads.
    #accept_mac_file=/etc/hostapd.accept
    #deny_mac_file=/etc/hostapd.deny
