iwconfig 命令
================================================================================


.. code-block::

    sudo ifconfig wlan0 down
    sudo iwconfig wlan0 mode monitor
    sudo ifconfig wlan0 up
    sudo iwconfig wlan0 chan 6

    sudo tcpdump -i wlan0

    sudo ifconfig wlan0 down
    sudo iwconfig wlan0 mode managed
    sudo ifconfig wlan0 up
