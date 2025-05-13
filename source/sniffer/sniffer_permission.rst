You don't have permission to capture on that device
================================================================================

* 使用 sudo
* 修改 Capabilities

.. todo::

    链接到权限章节

.. code-block::

    sudo groupadd pcap
    sudo usermod -aG pcap $USER


.. code-block::

    sudo chmod g+w $(which tcpdump)
    sudo chgrp pcap $(which tcpdump)


.. code-block::

    sudo setcap cap_net_raw,cap_net_admin=eip $(which tcpdump)
