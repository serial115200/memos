ip 命令
================================================================================

软件安装
--------------------------------------------------------------------------------

.. code-block:: bash

    ~$ sudo apt update
    ~$ sudo apt install -y iproute2
    ~$ ip -V
    ip utility, iproute2-6.11.0, libbpf 1.5.0


使用概述
--------------------------------------------------------------------------------

.. code-block::

    ~$ ip help
    Usage: ip [ OPTIONS ] OBJECT { COMMAND | help }
           ip [ -force ] -batch filename
    where  OBJECT := { address | addrlabel | fou | help | ila | ioam | l2tp | link |
                    macsec | maddress | monitor | mptcp | mroute | mrule |
                    neighbor | neighbour | netconf | netns | nexthop | ntable |
                    ntbl | route | rule | sr | stats | tap | tcpmetrics |
                    token | tunnel | tuntap | vrf | xfrm }
        OPTIONS := { -V[ersion] | -s[tatistics] | -d[etails] | -r[esolve] |
                        -h[uman-readable] | -iec | -j[son] | -p[retty] |
                        -f[amily] { inet | inet6 | mpls | bridge | link } |
                        -4 | -6 | -M | -B | -0 |
                        -l[oops] { maximum-addr-flush-attempts } | -echo | -br[ief] |
                        -o[neline] | -t[imestamp] | -ts[hort] | -b[atch] [filename] |
                        -rc[vbuf] [size] | -n[etns] name | -N[umeric] | -a[ll] |
                        -c[olor]}


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
