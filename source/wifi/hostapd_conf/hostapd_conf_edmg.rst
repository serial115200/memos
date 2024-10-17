EDMG
================================================================================

.. code-block::

    ##### EDMG support ############################################################
    #
    # Enable EDMG capability for AP mode in the 60 GHz band. Default value is false.
    # To configure channel bonding for an EDMG AP use edmg_channel below.
    # If enable_edmg is set and edmg_channel is not set, EDMG CB1 will be
    # configured.
    #enable_edmg=1
    #
    # Configure channel bonding for AP mode in the 60 GHz band.
    # This parameter is relevant only if enable_edmg is set.
    # Default value is 0 (no channel bonding).
    #edmg_channel=9


IEEE 802.11ay, which is also called EDMG (Enhanced Directional Multi-Gigabit in
IEEE 802.11 standard), is the follow-up of 802.11ad standard with four times
more bandwidth and additional MIMO up to 4 streams. It is a standard that is
still being developed with the peak transmission rate equal to 20 Gbit/s.
