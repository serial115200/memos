Dnsmasq 日志配置
================================================================================

.. code-block:: bash

    uci set dhcp.@dnsmasq[0].logdhcp='1'
    uci set dhcp.@dnsmasq[0].logqueries='1'
    uci set dhcp.@dnsmasq[0].logfacility='/tmp/dnsmasq.log'
    uci commit


.. code-block:: bash

    log-dhcp
    log-queries
    log-facility=/tmp/dnsmasq.log
