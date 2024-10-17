
Hotspot 2.0
================================================================================

.. code-block::

    ##### Hotspot 2.0 #############################################################

    # Enable Hotspot 2.0 support
    #hs20=1

    # Disable Downstream Group-Addressed Forwarding (DGAF)
    # This can be used to configure a network where no group-addressed frames are
    # allowed. The AP will not forward any group-address frames to the stations and
    # random GTKs are issued for each station to prevent associated stations from
    # forging such frames to other stations in the BSS.
    #disable_dgaf=1

    # OSU Server-Only Authenticated L2 Encryption Network
    #osen=1

    # ANQP Domain ID (0..65535)
    # An identifier for a set of APs in an ESS that share the same common ANQP
    # information. 0 = Some of the ANQP information is unique to this AP (default).
    #anqp_domain_id=1234

    # Deauthentication request timeout
    # If the RADIUS server indicates that the station is not allowed to connect to
    # the BSS/ESS, the AP can allow the station some time to download a
    # notification page (URL included in the message). This parameter sets that
    # timeout in seconds. If the RADIUS server provides no URL, this value is
    # reduced to two seconds with an additional trigger for immediate
    # deauthentication when the STA acknowledges reception of the deauthentication
    # imminent indication. Note that setting this value to 0 will prevent delivery
    # of the notification to the STA, so a value of at least 1 should be used here
    # for normal use cases.
    #hs20_deauth_req_timeout=60

    # Operator Friendly Name
    # This parameter can be used to configure one or more Operator Friendly Name
    # Duples. Each entry has a two or three character language code (ISO-639)
    # separated by colon from the operator friendly name string.
    #hs20_oper_friendly_name=eng:Example operator
    #hs20_oper_friendly_name=fin:Esimerkkioperaattori

    # Connection Capability
    # This can be used to advertise what type of IP traffic can be sent through the
    # hotspot (e.g., due to firewall allowing/blocking protocols/ports).
    # format: <IP Protocol>:<Port Number>:<Status>
    # IP Protocol: 1 = ICMP, 6 = TCP, 17 = UDP
    # Port Number: 0..65535
    # Status: 0 = Closed, 1 = Open, 2 = Unknown
    # Each hs20_conn_capab line is added to the list of advertised tuples.
    #hs20_conn_capab=1:0:2
    #hs20_conn_capab=6:22:1
    #hs20_conn_capab=17:5060:0

    # WAN Metrics
    # format: <WAN Info>:<DL Speed>:<UL Speed>:<DL Load>:<UL Load>:<LMD>
    # WAN Info: B0-B1: Link Status, B2: Symmetric Link, B3: At Capabity
    #    (encoded as two hex digits)
    #    Link Status: 1 = Link up, 2 = Link down, 3 = Link in test state
    # Downlink Speed: Estimate of WAN backhaul link current downlink speed in kbps;
    #	1..4294967295; 0 = unknown
    # Uplink Speed: Estimate of WAN backhaul link current uplink speed in kbps
    #	1..4294967295; 0 = unknown
    # Downlink Load: Current load of downlink WAN connection (scaled to 255 = 100%)
    # Uplink Load: Current load of uplink WAN connection (scaled to 255 = 100%)
    # Load Measurement Duration: Duration for measuring downlink/uplink load in
    # tenths of a second (1..65535); 0 if load cannot be determined
    #hs20_wan_metrics=01:8000:1000:80:240:3000

    # Operating Class Indication
    # List of operating classes the BSSes in this ESS use. The Global operating
    # classes in Table E-4 of IEEE Std 802.11-2012 Annex E define the values that
    # can be used in this.
    # format: hexdump of operating class octets
    # for example, operating classes 81 (2.4 GHz channels 1-13) and 115 (5 GHz
    # channels 36-48):
    #hs20_operating_class=5173

    # Terms and Conditions information
    #
    # hs20_t_c_filename contains the Terms and Conditions filename that the AP
    # indicates in RADIUS Access-Request messages.
    #hs20_t_c_filename=terms-and-conditions
    #
    # hs20_t_c_timestamp contains the Terms and Conditions timestamp that the AP
    # indicates in RADIUS Access-Request messages. Usually, this contains the number
    # of seconds since January 1, 1970 00:00 UTC showing the time when the file was
    # last modified.
    #hs20_t_c_timestamp=1234567
    #
    # hs20_t_c_server_url contains a template for the Terms and Conditions server
    # URL. This template is used to generate the URL for a STA that needs to
    # acknowledge Terms and Conditions. Unlike the other hs20_t_c_* parameters, this
    # parameter is used on the authentication server, not the AP.
    # Macros:
    # @1@ = MAC address of the STA (colon separated hex octets)
    #hs20_t_c_server_url=https://example.com/t_and_c?addr=@1@&ap=123

    # OSU and Operator icons
    # <Icon Width>:<Icon Height>:<Language code>:<Icon Type>:<Name>:<file path>
    #hs20_icon=32:32:eng:image/png:icon32:/tmp/icon32.png
    #hs20_icon=64:64:eng:image/png:icon64:/tmp/icon64.png

    # OSU SSID (see ssid2 for format description)
    # This is the SSID used for all OSU connections to all the listed OSU Providers.
    #osu_ssid="example"

    # OSU Providers
    # One or more sets of following parameter. Each OSU provider is started by the
    # mandatory osu_server_uri item. The other parameters add information for the
    # last added OSU provider. osu_nai specifies the OSU_NAI value for OSEN
    # authentication when using a standalone OSU BSS. osu_nai2 specifies the OSU_NAI
    # value for OSEN authentication when using a shared BSS (Single SSID) for OSU.
    #
    #osu_server_uri=https://example.com/osu/
    #osu_friendly_name=eng:Example operator
    #osu_friendly_name=fin:Esimerkkipalveluntarjoaja
    #osu_nai=anonymous@example.com
    #osu_nai2=anonymous@example.com
    #osu_method_list=1 0
    #osu_icon=icon32
    #osu_icon=icon64
    #osu_service_desc=eng:Example services
    #osu_service_desc=fin:Esimerkkipalveluja
    #
    #osu_server_uri=...

    # Operator Icons
    # Operator icons are specified using references to the hs20_icon entries
    # (Name subfield). This information, if present, is advertsised in the
    # Operator Icon Metadata ANQO-element.
    #operator_icon=icon32
    #operator_icon=icon64
