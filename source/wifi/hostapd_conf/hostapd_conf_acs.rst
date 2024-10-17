自动信道选择 acs - Automatic Channel Selection
================================================================================

.. code-block::

    # ACS tuning - Automatic Channel Selection
    # See: https://wireless.wiki.kernel.org/en/users/documentation/acs
    #
    # You can customize the ACS survey algorithm with following variables:
    #
    # acs_num_scans requirement is 1..100 - number of scans to be performed that
    # are used to trigger survey data gathering of an underlying device driver.
    # Scans are passive and typically take a little over 100ms (depending on the
    # driver) on each available channel for given hw_mode. Increasing this value
    # means sacrificing startup time and gathering more data wrt channel
    # interference that may help choosing a better channel. This can also help fine
    # tune the ACS scan time in case a driver has different scan dwell times.
    #
    # acs_chan_bias is a space-separated list of <channel>:<bias> pairs. It can be
    # used to increase (or decrease) the likelihood of a specific channel to be
    # selected by the ACS algorithm. The total interference factor for each channel
    # gets multiplied by the specified bias value before finding the channel with
    # the lowest value. In other words, values between 0.0 and 1.0 can be used to
    # make a channel more likely to be picked while values larger than 1.0 make the
    # specified channel less likely to be picked. This can be used, e.g., to prefer
    # the commonly used 2.4 GHz band channels 1, 6, and 11 (which is the default
    # behavior on 2.4 GHz band if no acs_chan_bias parameter is specified).
    #
    # Defaults:
    #acs_num_scans=5
    #acs_chan_bias=1:0.8 6:0.8 11:0.8

    # Channel list restriction. This option allows hostapd to select one of the
    # provided channels when a channel should be automatically selected.
    # Channel list can be provided as range using hyphen ('-') or individual
    # channels can be specified by space (' ') separated values
    # Default: all channels allowed in selected hw_mode
    #chanlist=100 104 108 112 116
    #chanlist=1 6 11-13

    # Frequency list restriction. This option allows hostapd to select one of the
    # provided frequencies when a frequency should be automatically selected.
    # Frequency list can be provided as range using hyphen ('-') or individual
    # frequencies can be specified by comma (',') separated values
    # Default: all frequencies allowed in selected hw_mode
    #freqlist=2437,5955,5975
    #freqlist=2437,5985-6105

    # Exclude DFS channels from ACS
    # This option can be used to exclude all DFS channels from the ACS channel list
    # in cases where the driver supports DFS channels.
    #acs_exclude_dfs=1

    # Include only preferred scan channels from 6 GHz band for ACS
    # This option can be used to include only preferred scan channels in the 6 GHz
    # band. This can be useful in particular for devices that operate only a 6 GHz
    # BSS without a collocated 2.4/5 GHz BSS.
    # Default behavior is to include all PSC and non-PSC channels.
    #acs_exclude_6ghz_non_psc=1

    # Enable background radar feature
    # This feature allows CAC to be run on dedicated radio RF chains while the
    # radio(s) are otherwise running normal AP activities on other channels.
    # This requires that the driver and the radio support it before feature will
    # actually be enabled, i.e., this parameter value is ignored with drivers that
    # do not advertise support for the capability.
    # 0: Leave disabled (default)
    # 1: Enable it.
    #enable_background_radar=1

    # Set minimum permitted max TX power (in dBm) for ACS and DFS channel selection.
    # (default 0, i.e., not constraint)
    #min_tx_power=20
