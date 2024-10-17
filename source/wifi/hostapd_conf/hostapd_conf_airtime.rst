Airtime
================================================================================

.. code-block::

    ##### Airtime policy configuration ###########################################

    # Set the airtime policy operating mode:
    # 0 = disabled (default)
    # 1 = static config
    # 2 = per-BSS dynamic config
    # 3 = per-BSS limit mode
    #airtime_mode=0

    # Interval (in milliseconds) to poll the kernel for updated station activity in
    # dynamic and limit modes
    #airtime_update_interval=200

    # Static configuration of station weights (when airtime_mode=1). Kernel default
    # weight is 256; set higher for larger airtime share, lower for smaller share.
    # Each entry is a MAC address followed by a weight.
    #airtime_sta_weight=02:01:02:03:04:05 256
    #airtime_sta_weight=02:01:02:03:04:06 512

    # Per-BSS airtime weight. In multi-BSS mode, set for each BSS and hostapd will
    # configure station weights to enforce the correct ratio between BSS weights
    # depending on the number of active stations. The *ratios* between different
    # BSSes is what's important, not the absolute numbers.
    # Must be set for all BSSes if airtime_mode=2 or 3, has no effect otherwise.
    #airtime_bss_weight=1

    # Whether the current BSS should be limited (when airtime_mode=3).
    #
    # If set, the BSS weight ratio will be applied in the case where the current BSS
    # would exceed the share defined by the BSS weight ratio. E.g., if two BSSes are
    # set to the same weights, and one is set to limited, the limited BSS will get
    # no more than half the available airtime, but if the non-limited BSS has more
    # stations active, that *will* be allowed to exceed its half of the available
    # airtime.
    #airtime_bss_limit=1
