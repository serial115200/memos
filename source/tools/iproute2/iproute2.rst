ip 命令
================================================================================

概述
--------------------------------------------------------------------------------

.. code-block:: bash

    sudo apt update
    sudo apt install -y iproute2


.. code-block::

    Usage: ip [ OPTIONS ] OBJECT { COMMAND | help }
           ip [ -force ] -batch filename
    where  OBJECT := { link | address | addrlabel | route | rule | neigh | ntable |
                    tunnel | tuntap | maddress | mroute | mrule | monitor | xfrm |
                    netns | l2tp | fou | macsec | tcp_metrics | token | netconf | ila |
                    vrf | sr }
        OPTIONS := { -V[ersion] | -s[tatistics] | -d[etails] | -r[esolve] |
                        -h[uman-readable] | -iec | -j[son] | -p[retty] |
                        -f[amily] { inet | inet6 | ipx | dnet | mpls | bridge | link } |
                        -4 | -6 | -I | -D | -M | -B | -0 |
                        -l[oops] { maximum-addr-flush-attempts } | -br[ief] |
                        -o[neline] | -t[imestamp] | -ts[hort] | -b[atch] [filename] |
                        -rc[vbuf] [size] | -n[etns] name | -a[ll] | -c[olor]}


初见帮助信息，可谓繁杂，有违 *KISS* 原则。在一番实操后，发现繁杂之下是逻辑清晰的分门别类。

.. code-block::

    ip [ OPTIONS ] OBJECT { COMMAND | help }


* OPTIONS 部分在特定情况下使用，因此先忽略。
* OBJECT 部分为对应的类别，如 IP
* 后续是各个子命令的部分
* 默认子命令是 show


.. toctree::
    :maxdepth: 1

    ip_link
    ip_netns
