GDB 参考手册
================================================================================

~/.config/gdb/gdbinit

~/.gdbinit

./.gdbinit

https://github.com/cyrus-and/gdb-dashboard

set auto-load local-gdbinit

set history save on
# default file is .gdb_history
# set history filename <fname>


查看数组

.. code-block::

    print *Array@10
