11ac 配置
================================================================================

.. code-block::

    ##### IEEE 802.11ac related configuration #####################################

    # ieee80211ac: Whether IEEE 802.11ac (VHT) is enabled
    # 0 = disabled (default)
    # 1 = enabled
    # Note: You will also need to enable WMM for full VHT functionality.
    # Note: hw_mode=a is used to specify that 5 GHz band is used with VHT.
    #ieee80211ac=1

    # disable_11ac: Boolean (0/1) to disable VHT for a specific BSS
    #disable_11ac=0

    # vht_capab: VHT capabilities (list of flags)
    #
    # vht_max_mpdu_len: [MAX-MPDU-7991] [MAX-MPDU-11454]
    # Indicates maximum MPDU length
    # 0 = 3895 octets (default)
    # 1 = 7991 octets
    # 2 = 11454 octets
    # 3 = reserved
    #
    # supported_chan_width: [VHT160] [VHT160-80PLUS80]
    # Indicates supported Channel widths
    # 0 = 160 MHz & 80+80 channel widths are not supported (default)
    # 1 = 160 MHz channel width is supported
    # 2 = 160 MHz & 80+80 channel widths are supported
    # 3 = reserved
    #
    # Rx LDPC coding capability: [RXLDPC]
    # Indicates support for receiving LDPC coded pkts
    # 0 = Not supported (default)
    # 1 = Supported
    #
    # Short GI for 80 MHz: [SHORT-GI-80]
    # Indicates short GI support for reception of packets transmitted with TXVECTOR
    # params format equal to VHT and CBW = 80Mhz
    # 0 = Not supported (default)
    # 1 = Supported
    #
    # Short GI for 160 MHz: [SHORT-GI-160]
    # Indicates short GI support for reception of packets transmitted with TXVECTOR
    # params format equal to VHT and CBW = 160Mhz
    # 0 = Not supported (default)
    # 1 = Supported
    #
    # Tx STBC: [TX-STBC-2BY1]
    # Indicates support for the transmission of at least 2x1 STBC
    # 0 = Not supported (default)
    # 1 = Supported
    #
    # Rx STBC: [RX-STBC-1] [RX-STBC-12] [RX-STBC-123] [RX-STBC-1234]
    # Indicates support for the reception of PPDUs using STBC
    # 0 = Not supported (default)
    # 1 = support of one spatial stream
    # 2 = support of one and two spatial streams
    # 3 = support of one, two and three spatial streams
    # 4 = support of one, two, three and four spatial streams
    # 5,6,7 = reserved
    #
    # SU Beamformer Capable: [SU-BEAMFORMER]
    # Indicates support for operation as a single user beamformer
    # 0 = Not supported (default)
    # 1 = Supported
    #
    # SU Beamformee Capable: [SU-BEAMFORMEE]
    # Indicates support for operation as a single user beamformee
    # 0 = Not supported (default)
    # 1 = Supported
    #
    # Compressed Steering Number of Beamformer Antennas Supported:
    # [BF-ANTENNA-2] [BF-ANTENNA-3] [BF-ANTENNA-4]
    #   Beamformee's capability indicating the maximum number of beamformer
    #   antennas the beamformee can support when sending compressed beamforming
    #   feedback
    # If SU beamformer capable, set to maximum value minus 1
    # else reserved (default)
    #
    # Number of Sounding Dimensions:
    # [SOUNDING-DIMENSION-2] [SOUNDING-DIMENSION-3] [SOUNDING-DIMENSION-4]
    # Beamformer's capability indicating the maximum value of the NUM_STS parameter
    # in the TXVECTOR of a VHT NDP
    # If SU beamformer capable, set to maximum value minus 1
    # else reserved (default)
    #
    # MU Beamformer Capable: [MU-BEAMFORMER]
    # Indicates support for operation as an MU beamformer
    # 0 = Not supported or sent by Non-AP STA (default)
    # 1 = Supported
    #
    # VHT TXOP PS: [VHT-TXOP-PS]
    # Indicates whether or not the AP supports VHT TXOP Power Save Mode
    #  or whether or not the STA is in VHT TXOP Power Save mode
    # 0 = VHT AP doesn't support VHT TXOP PS mode (OR) VHT STA not in VHT TXOP PS
    #  mode
    # 1 = VHT AP supports VHT TXOP PS mode (OR) VHT STA is in VHT TXOP power save
    #  mode
    #
    # +HTC-VHT Capable: [HTC-VHT]
    # Indicates whether or not the STA supports receiving a VHT variant HT Control
    # field.
    # 0 = Not supported (default)
    # 1 = supported
    #
    # Maximum A-MPDU Length Exponent: [MAX-A-MPDU-LEN-EXP0]..[MAX-A-MPDU-LEN-EXP7]
    # Indicates the maximum length of A-MPDU pre-EOF padding that the STA can recv
    # This field is an integer in the range of 0 to 7.
    # The length defined by this field is equal to
    # 2 pow(13 + Maximum A-MPDU Length Exponent) -1 octets
    #
    # VHT Link Adaptation Capable: [VHT-LINK-ADAPT2] [VHT-LINK-ADAPT3]
    # Indicates whether or not the STA supports link adaptation using VHT variant
    # HT Control field
    # If +HTC-VHTcapable is 1
    #  0 = (no feedback) if the STA does not provide VHT MFB (default)
    #  1 = reserved
    #  2 = (Unsolicited) if the STA provides only unsolicited VHT MFB
    #  3 = (Both) if the STA can provide VHT MFB in response to VHT MRQ and if the
    #      STA provides unsolicited VHT MFB
    # Reserved if +HTC-VHTcapable is 0
    #
    # Rx Antenna Pattern Consistency: [RX-ANTENNA-PATTERN]
    # Indicates the possibility of Rx antenna pattern change
    # 0 = Rx antenna pattern might change during the lifetime of an association
    # 1 = Rx antenna pattern does not change during the lifetime of an association
    #
    # Tx Antenna Pattern Consistency: [TX-ANTENNA-PATTERN]
    # Indicates the possibility of Tx antenna pattern change
    # 0 = Tx antenna pattern might change during the lifetime of an association
    # 1 = Tx antenna pattern does not change during the lifetime of an association
    #vht_capab=[SHORT-GI-80][HTC-VHT]
    #
    # Require stations to support VHT PHY (reject association if they do not)
    #require_vht=1

    # 0 = 20 or 40 MHz operating Channel width
    # 1 = 80 MHz channel width
    # 2 = 160 MHz channel width
    # 3 = 80+80 MHz channel width
    #vht_oper_chwidth=1
    #
    # center freq = 5 GHz + (5 * index)
    # So index 42 gives center freq 5.210 GHz
    # which is channel 42 in 5G band
    #
    #vht_oper_centr_freq_seg0_idx=42
    #
    # center freq = 5 GHz + (5 * index)
    # So index 159 gives center freq 5.795 GHz
    # which is channel 159 in 5G band
    #
    #vht_oper_centr_freq_seg1_idx=159

    # Workaround to use station's nsts capability in (Re)Association Response frame
    # This may be needed with some deployed devices as an interoperability
    # workaround for beamforming if the AP's capability is greater than the
    # station's capability. This is disabled by default and can be enabled by
    # setting use_sta_nsts=1.
    #use_sta_nsts=0
