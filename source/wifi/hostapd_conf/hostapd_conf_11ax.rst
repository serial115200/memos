11ax 配置
================================================================================

.. code-block::

    ##### IEEE 802.11ax related configuration #####################################

    #ieee80211ax: Whether IEEE 802.11ax (HE) is enabled
    # 0 = disabled (default)
    # 1 = enabled
    #ieee80211ax=1

    # Require stations to support HE PHY (reject association if they do not)
    #require_he=1

    # disable_11ax: Boolean (0/1) to disable HE for a specific BSS
    #disable_11ax=0

    #he_su_beamformer: HE single user beamformer support
    # 0 = not supported (default)
    # 1 = supported
    #he_su_beamformer=1

    #he_su_beamformee: HE single user beamformee support
    # 0 = not supported (default)
    # 1 = supported
    #he_su_beamformee=1

    #he_mu_beamformer: HE multiple user beamformer support
    # 0 = not supported (default)
    # 1 = supported
    #he_mu_beamformer=1

    # he_bss_color: BSS color (1-63)
    #he_bss_color=1

    # he_bss_color_partial: BSS color AID equation
    #he_bss_color_partial=0

    #he_default_pe_duration: The duration of PE field in an HE PPDU in us
    # Possible values are 0 us (default), 4 us, 8 us, 12 us, and 16 us
    #he_default_pe_duration=0

    #he_twt_required: Whether TWT is required
    # 0 = not required (default)
    # 1 = required
    #he_twt_required=0

    #he_twt_responder: Whether TWT (HE) responder is enabled
    # 0 = disabled
    # 1 = enabled if supported by the driver (default)
    #he_twt_responder=1

    #he_rts_threshold: Duration of STA transmission
    # 0 = not set (default)
    # unsigned integer = duration in units of 16 us
    #he_rts_threshold=0

    #he_er_su_disable: Disable 242-tone HE ER SU PPDU reception by the AP
    # 0 = enable reception (default)
    # 1 = disable reception
    #he_er_su_disable=0

    # HE operating channel information; see matching vht_* parameters for details.
    # he_oper_centr_freq_seg0_idx field is used to indicate center frequency of 80
    # and 160 MHz bandwidth operation. In 80+80 MHz operation, it is the center
    # frequency of the lower frequency segment. he_oper_centr_freq_seg1_idx field
    # is used only with 80+80 MHz bandwidth operation and it is used to transmit
    # the center frequency of the second segment.
    # On the 6 GHz band the center freq calculation starts from 5.950 GHz offset.
    # For example idx=3 would result in 5965 MHz center frequency. In addition,
    # he_oper_chwidth is ignored, and the channel width is derived from the
    # configured operating class or center frequency indexes (see
    # IEEE P802.11ax/D6.1 Annex E, Table E-4).
    #he_oper_chwidth (see vht_oper_chwidth)
    #he_oper_centr_freq_seg0_idx
    #he_oper_centr_freq_seg1_idx

    #he_basic_mcs_nss_set: Basic NSS/MCS set
    # 16-bit combination of 2-bit values of Max HE-MCS For 1..8 SS; each 2-bit
    # value having following meaning:
    # 0 = HE-MCS 0-7, 1 = HE-MCS 0-9, 2 = HE-MCS 0-11, 3 = not supported
    #he_basic_mcs_nss_set

    #he_mu_edca_qos_info_param_count
    #he_mu_edca_qos_info_q_ack
    #he_mu_edca_qos_info_queue_request=1
    #he_mu_edca_qos_info_txop_request
    #he_mu_edca_ac_be_aifsn=0
    #he_mu_edca_ac_be_ecwmin=15
    #he_mu_edca_ac_be_ecwmax=15
    #he_mu_edca_ac_be_timer=255
    #he_mu_edca_ac_bk_aifsn=0
    #he_mu_edca_ac_bk_aci=1
    #he_mu_edca_ac_bk_ecwmin=15
    #he_mu_edca_ac_bk_ecwmax=15
    #he_mu_edca_ac_bk_timer=255
    #he_mu_edca_ac_vi_ecwmin=15
    #he_mu_edca_ac_vi_ecwmax=15
    #he_mu_edca_ac_vi_aifsn=0
    #he_mu_edca_ac_vi_aci=2
    #he_mu_edca_ac_vi_timer=255
    #he_mu_edca_ac_vo_aifsn=0
    #he_mu_edca_ac_vo_aci=3
    #he_mu_edca_ac_vo_ecwmin=15
    #he_mu_edca_ac_vo_ecwmax=15
    #he_mu_edca_ac_vo_timer=255

    # Spatial Reuse Parameter Set
    #
    # SR Control field value
    # B0 = PSR Disallowed
    # B1 = Non-SRG OBSS PD SR Disallowed
    # B2 = Non-SRG Offset Present
    # B3 = SRG Information Present
    # B4 = HESIGA_Spatial_reuse_value15_allowed
    #he_spr_sr_control
    #
    # Non-SRG OBSS PD Max Offset (included if he_spr_sr_control B2=1)
    #he_spr_non_srg_obss_pd_max_offset

    # SRG OBSS PD Min Offset (included if he_spr_sr_control B3=1)
    #he_spr_srg_obss_pd_min_offset
    #
    # SRG OBSS PD Max Offset (included if he_spr_sr_control B3=1)
    #he_spr_srg_obss_pd_max_offset
    #
    # SPR SRG BSS Color (included if he_spr_sr_control B3=1)
    # This config represents SRG BSS Color Bitmap field of Spatial Reuse Parameter
    # Set element that indicates the BSS color values used by members of the
    # SRG of which the transmitting STA is a member. The value is in range of 0-63.
    #he_spr_srg_bss_colors=1 2 10 63
    #
    # SPR SRG Partial BSSID (included if he_spr_sr_control B3=1)
    # This config represents SRG Partial BSSID Bitmap field of Spatial Reuse
    # Parameter Set element that indicates the Partial BSSID values used by members
    # of the SRG of which the transmitting STA is a member. The value range
    # corresponds to one of the 64 possible values of BSSID[39:44], where the lowest
    # numbered bit corresponds to Partial BSSID value 0 and the highest numbered bit
    # corresponds to Partial BSSID value 63.
    #he_spr_srg_partial_bssid=0 1 3 63
    #
    #he_6ghz_max_mpdu: Maximum MPDU Length of HE 6 GHz band capabilities.
    # Indicates maximum MPDU length
    # 0 = 3895 octets
    # 1 = 7991 octets
    # 2 = 11454 octets (default)
    #he_6ghz_max_mpdu=2
    #
    #he_6ghz_max_ampdu_len_exp: Maximum A-MPDU Length Exponent of HE 6 GHz band
    # capabilities. Indicates the maximum length of A-MPDU pre-EOF padding that
    # the STA can receive. This field is an integer in the range of 0 to 7.
    # The length defined by this field is equal to
    # 2 pow(13 + Maximum A-MPDU Length Exponent) -1 octets
    # 0 = AMPDU length of 8k
    # 1 = AMPDU length of 16k
    # 2 = AMPDU length of 32k
    # 3 = AMPDU length of 65k
    # 4 = AMPDU length of 131k
    # 5 = AMPDU length of 262k
    # 6 = AMPDU length of 524k
    # 7 = AMPDU length of 1048k (default)
    #he_6ghz_max_ampdu_len_exp=7
    #
    #he_6ghz_rx_ant_pat: Rx Antenna Pattern Consistency of HE 6 GHz capability.
    # Indicates the possibility of Rx antenna pattern change
    # 0 = Rx antenna pattern might change during the lifetime of an association
    # 1 = Rx antenna pattern does not change during the lifetime of an association
    #     (default)
    #he_6ghz_rx_ant_pat=1
    #
    #he_6ghz_tx_ant_pat: Tx Antenna Pattern Consistency of HE 6 GHz capability.
    # Indicates the possibility of Tx antenna pattern change
    # 0 = Tx antenna pattern might change during the lifetime of an association
    # 1 = Tx antenna pattern does not change during the lifetime of an association
    #     (default)
    #he_6ghz_tx_ant_pat=1

    # 6 GHz Access Point type
    # This config is to set the 6 GHz Access Point type. Possible options are:
    # 0 = Indoor AP
    # 1 = Standard power AP
    # 2 = Very low power AP (default)
    # 3 = Indoor enabled AP
    # 4 = Indoor standard power AP
    # This has no impact for operation on other bands.
    # See IEEE P802.11-REVme/D4.0, Table E-12 (Regulatory Info subfield encoding)
    # for more details.
    #he_6ghz_reg_pwr_type=0
    #
    # 6 GHz Maximum Tx Power used in Transmit Power Envelope elements, where the
    # "Transmit Power Interpretation" is set to "Regulatory client EIRP PSD".
    # For Maximum Transmit Power Category subfield encoding set to default (0):
    #reg_def_cli_eirp_psd=-1
    # For Maximum Transmit Power Category subfield encoding set to subordinate (1):
    #reg_sub_cli_eirp_psd=-1

    # Unsolicited broadcast Probe Response transmission settings
    # This is for the 6 GHz band only. If the interval is set to a non-zero value,
    # the AP schedules unsolicited broadcast Probe Response frames to be
    # transmitted for in-band discovery. Refer to
    # IEEE P802.11ax/D8.0 26.17.2.3.2, AP behavior for fast passive scanning.
    # Valid range: 0..20 TUs; default is 0 (disabled)
    #unsol_bcast_probe_resp_interval=0
