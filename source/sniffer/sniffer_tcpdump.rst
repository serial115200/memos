Tcpdump
================================================================================


技巧
--------------------------------------------------------------------------------

写入文件并对外输出
--------------------------------------------------------------------------------
.. code-block::

    sudo tcpdump -i enp2s0 -U -w - | tee test.pcap | tcpdump -r -


远程抓包
--------------------------------------------------------------------------------

.. code-block::

    ssh HOST tcpdump -U -s0 -n -w - -i INTERFACE "FILTER" | wireshark -k -i -


tcpdump options:

* -U : this option instructs tcpdump to write each packet immediately, rather than buffering them
* -s0 : this option instructs tcpdump to capture as much of the packet’s data as possible
* -n : disables address to name resolution
* -w - : instructs tcpdump to write packet data to stdout in PCAP format, rather than in some sort of human readable format
* -i INTERFACE : which network interface? You may be able to omit this if there is only one obvious one
  "FILTER" : a PCAP filter expression. Could be something like not port 22

wireshark options:

* -k : immediately begin capturing
* -i - : capture from stdin

Of course, you’ll want to make sure that your filter excludes your own SSH connection!
