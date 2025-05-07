
国家/区域设置
================================================================================


.. code-block::

    reg set <ISO/IEC 3166-1 alpha2>
            Notify the kernel about the current regulatory domain.

    reg get
            Print out the kernel's current regulatory domain information.

    phy <phyname> reg get
            Print out the devices' current regulatory domain information.

    reg reload
            Reload the kernel's regulatory database.


.. literalinclude:: iw_cmd/iw_reg_get.txt
