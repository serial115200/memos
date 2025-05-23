Capabilities 篇
================================================================================

.. code-block:: shell

    ~$ ls -al $(which ping)
    -rwxr-xr-x 1 root root 72776 Jan 31  2020 /usr/bin/ping

.. code-block:: shell

    ~$ getcap $(which ping)
    /usr/bin/ping = cap_net_raw+ep
