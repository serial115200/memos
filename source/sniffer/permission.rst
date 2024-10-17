权限问题 You don't have permission to capture on that device
================================================================================

直接 sudo 或使用以下方式，此处使用 tcpdump 举例，其余各个程序都可以参考

Add a capture group and add yourself to it:

.. code-block::

    sudo groupadd pcap
    sudo usermod -aG pcap $USER


Next, change the group of tcpdump and set permissions:

.. code-block::

    sudo chgrp pcap /usr/sbin/tcpdump
    sudo chmod 750 /usr/sbin/tcpdump


OR
.. code-block::

    sudo chgrp pcap /usr/bin/tcpdump
    sudo chmod 750 /usr/bin/tcpdump


Finally, use setcap to give tcpdump the necessary permissions:

.. code-block::

    sudo setcap cap_net_raw,cap_net_admin=eip /usr/sbin/tcpdump


Be careful, that this will allow everybody from the group pcap to manipulate
network interfaces and read raw packets!
