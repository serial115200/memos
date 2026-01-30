TUN 与 TAP 接口
================================================================================

TUN 和 TAP 是 Linux 内核提供的两种虚拟网络接口，用于在**用户态程序**和**内核网络栈**之间传递数据。区别在于层次：

- **TUN**（Network TUNnel）：工作在**三层（IP）**，收发的是 **IP 报文**
- **TAP**（Network TAP）：工作在**二层（以太网）**，收发的是 **以太网帧**

用户态程序通过读写 TUN/TAP 设备（如 `/dev/net/tun`）获取或注入数据，从而可以实现 VPN、隧道、虚拟机网络等。

**典型用途**

- **TUN**：VPN（OpenVPN TUN 模式、WireGuard）、IP 隧道、点对点路由
- **TAP**：虚拟机网络（QEMU/KVM 的虚拟网卡）、桥接、需要二层协议（ARP、DHCP 等）的场景


TUN 与 TAP 对比
--------------------------------------------------------------------------------

+--------+------------------+------------------+----------------------------------+
| 类型   | 工作层次         | 数据单位         | 典型场景                         |
+========+==================+==================+==================================+
| TUN    | 三层（IP）       | IP 报文          | VPN、IP 隧道、路由                |
+--------+------------------+------------------+----------------------------------+
| TAP    | 二层（以太网）   | 以太网帧         | 虚拟机网卡、桥接、二层交换        |
+--------+------------------+------------------+----------------------------------+

选择原则：只需要转发 IP 流量、做路由或 VPN 时用 **TUN**；需要模拟一块“网卡”（有 MAC、ARP、广播等）时用 **TAP**。


创建 TUN/TAP 接口
--------------------------------------------------------------------------------

**使用 ip 命令**

.. code-block:: bash

    # 创建 TUN 接口（默认名称 tun0）
    sudo ip tuntap add mode tun

    # 创建 TAP 接口（默认名称 tap0）
    sudo ip tuntap add mode tap

    # 指定名称
    sudo ip tuntap add mode tun name mytun0
    sudo ip tuntap add mode tap name tap0

    # 配置 IP 并启用（以 TUN 为例）
    sudo ip addr add 10.0.0.1/24 dev mytun0
    sudo ip link set mytun0 up

    # 删除接口
    sudo ip tuntap del mode tun name mytun0
    sudo ip tuntap del mode tap name tap0

**多队列（可选）**

.. code-block:: bash

    # 创建多队列 TAP（部分场景可提升性能）
    sudo ip tuntap add mode tap name tap0 multi_queue


TUN 示例：用户态处理 IP 报文
--------------------------------------------------------------------------------

TUN 接口在系统中表现为一块“只走 IP”的虚拟网卡：内核把发往该接口的 IP 包交给用户态程序读取，用户态程序写入的 IP 包则由内核当作从该接口收到并参与路由/转发。

典型流程：

1. 为 TUN 接口配置 IP 并 up
2. 用户态程序打开 `/dev/net/tun`，绑定该 TUN 接口
3. 程序从 TUN 读到的就是“发往该接口的 IP 报文”，处理后（如加密、封装、转发到远端）再通过其它途径发出去
4. 程序把“要注入到该接口”的 IP 报文写入 TUN，内核就会像从这块网卡收到一样处理（路由、本地接收等）

VPN、隧道软件（如 OpenVPN、WireGuard、自定义隧道）都是按这一模型工作的：TUN 提供“虚拟网卡”，业务只关心 IP 层。


TAP 示例：虚拟机与桥接
--------------------------------------------------------------------------------

TAP 接口模拟一块以太网网卡：内核把发往该接口的**以太网帧**交给用户态，用户态写入的以太网帧则由内核当作从这块网卡收到。因此可以跑 ARP、DHCP、广播等二层协议，适合给虚拟机当“网线”。

**典型用法：QEMU 使用 TAP 桥接**

.. code-block:: bash

    # 宿主机：创建 TAP 并加入桥 br0（物理网卡也加入 br0）
    sudo ip tuntap add mode tap name tap0
    sudo ip link set tap0 up
    sudo ip link add name br0 type bridge
    sudo ip link set br0 up
    sudo ip link set tap0 master br0
    sudo ip link set eth0 master br0   # 替换为实际物理网卡

    # 启动 QEMU，让虚拟机的网卡后端使用 tap0
    # -netdev tap,id=net0,ifname=tap0,script=no,downscript=no \
    # -device virtio-net-pci,netdev=net0

虚拟机内的流量通过虚拟网卡 → TAP(tap0) → 桥 br0 → 物理网卡，与宿主机所在局域网处于同一二层，可像真实机器一样获取 IP、访问内网和外网。

更完整的 QEMU + TAP 配置见：:doc:`/BuildInfrastructure/openwrt/qemu` 中的“TAP 桥接”部分。


权限与持久化
--------------------------------------------------------------------------------

- **设备节点**：TUN/TAP 对应内核设备为 `/dev/net/tun`，创建接口时需有权限（通常 root 或 `cap_net_admin`）。
- **持久化**：`ip tuntap add` 创建的接口在重启后不会保留，若需开机即有 TAP（例如给 QEMU 用），可在系统脚本中执行上述 `ip tuntap` 和 `ip link` 命令，或使用 systemd-networkd / 自定义 unit。

用户态如何使用 TUN/TAP
--------------------------------------------------------------------------------

参考 lwip 的 tapif.c 实现：
https://github.com/lwip-tcpip/lwip/blob/master/contrib/ports/unix/port/netif/tapif.c


参考
--------------------------------------------------------------------------------

- `Kernel docs: TUN/TAP <https://docs.kernel.org/networking/tuntap.html>`_
- `ip tuntap` 用法：``ip tuntap help``
- QEMU 使用 TAP：:doc:`/BuildInfrastructure/openwrt/qemu`
