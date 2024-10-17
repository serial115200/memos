11be 配置
================================================================================

.. code-block::

    ##### IEEE 802.11be related configuration #####################################

    #ieee80211be: Whether IEEE 802.11be (EHT) is enabled
    # 0 = disabled (default)
    # 1 = enabled
    #ieee80211be=1

    #disable_11be: Boolean (0/1) to disable EHT for a specific BSS
    #disable_11be=0

    #eht_su_beamformer: EHT single user beamformer support
    # 0 = not supported (default)
    # 1 = supported
    #eht_su_beamformer=1

    #eht_su_beamformee: EHT single user beamformee support
    # 0 = not supported (default)
    # 1 = supported
    #eht_su_beamformee=1

    #eht_mu_beamformer: EHT multiple user beamformer support
    # 0 = not supported (default)
    # 1 = supported
    #eht_mu_beamformer=1

    # EHT operating channel information; see matching he_* parameters for details.
    # The field eht_oper_centr_freq_seg0_idx field is used to indicate center
    # frequency of 40, 80, and 160 MHz bandwidth operation.
    # In the 6 GHz band, eht_oper_chwidth is ignored and the channel width is
    # derived from the configured operating class (IEEE P802.11be/D1.5,
    # Annex E.1 - Country information and operating classes).
    #eht_oper_chwidth (see vht_oper_chwidth)
    #eht_oper_centr_freq_seg0_idx

    #eht_default_pe_duration: The duration of PE field in EHT TB PPDU
    # 0 = PE field duration is the same as he_default_pe_duration (default)
    # 1 = PE field duration is 20 us
    #eht_default_pe_duration=0

    #eht_bw320_offset: For automatic channel selection (ACS) to indicate a preferred
    # 320 MHz channelization in EHT mode.
    # If the channel is decided or the bandwidth is not 320 MHz, this option is
    # meaningless.
    # 0 = auto-detect by hostapd
    # 1 = 320 MHz-1 (channel center frequency 31, 95, 159)
    # 2 = 320 MHz-2 (channel center frequency 63, 127, 191)
    #eht_bw320_offset=0

    # Disabled subchannel bitmap (16 bits) as per IEEE P802.11be/3.0,
    # Figure 9-1002c (EHT Operation Information field format). Each bit corresponds
    # to a 20 MHz channel, the lowest bit corresponds to the lowest frequency. A
    # bit set to 1 indicates that the channel is punctured (disabled). The default
    # value is 0 indicating that all channels are active.
    #punct_bitmap=0

    # Preamble puncturing threshold in automatic channel selection (ACS).
    # The value indicates the percentage of ideal channel average interference
    # factor above which a channel should be punctured.
    # Default is 0, indicates that ACS algorithm should not puncture any channel.
    #punct_acs_threshold=75

    # AP MLD - Whether this AP is a part of an AP MLD
    # 0 = no (no MLO)
    # 1 = yes (MLO)
    #mld_ap=0

    # AP MLD MAC address
    # The configured address will be set as the interface hardware address and used
    # as the AP MLD MAC address. If not set, the current interface hardware address
    # will be used as the AP MLD MAC address.
    #mld_addr=02:03:04:05:06:07
