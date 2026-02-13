QEMU 系统模式运行
================================================================================


准备镜像
--------------------------------------------------------------------------------

.. code-block:: shell

    mkdir -p openwrt-qemu
    cd openwrt-qemu
    wget https://downloads.openwrt.org/releases/23.05.0/targets/x86/64/openwrt-23.05.0-x86-64-generic-ext4-combined.img.gz
    gunzip -k openwrt-23.05.0-x86-64-generic-ext4-combined.img.gz


启动虚拟机
--------------------------------------------------------------------------------

.. code-block:: shell

    qemu-system-x86_64 \
        -drive file=openwrt-23.05.0-x86-64-generic-ext4-combined.img,format=raw \
        -nographic

- 退出虚拟机按下 :kbd:`Ctrl+A` 然后 :kbd:`x` 键
- -drive 参数指定硬盘镜像，可理解为装了 openwrt 的硬盘，细节后续说明
- -nographic 不需要图形界面，嵌入式开发大多不需要图形界面


配置机型（可选）
--------------------------------------------------------------------------------

``-M <machine>`` 指定 QEMU 模拟哪一套主板/芯片组，类似整机型号。

未指定时，QEMU 会使用该架构的默认机型。指定机型可以选更合适的硬件，获得功能更全的虚拟机，
更好的性能和兼容性。

.. code-block:: shell

    # 获取帮助
    qemu-system-x86_64 -machine help
    # 部分截取
    q35                  Standard PC (Q35 + ICH9, 2009) (alias of pc-q35-8.2)

    # 获取帮助
    qemu-system-aarch64 -M help
    # 部分截取
    virt                 QEMU 8.2 ARM Virtual Machine (alias of virt-8.2)


**x86_64：q35**

  对应以 Intel Q35 芯片组为原型的 “现代 PC”

**aarch64：virt**

  无对应真实板子的“虚拟平台”，专为虚拟化设计。

.. code-block:: shell

    qemu-system-x86_64 \
        -M q35 \
        -drive file=openwrt-23.05.0-x86-64-generic-ext4-combined.img,format=raw \
        -nographic


配置 CPU（可选）
--------------------------------------------------------------------------------

QEMU 会使用该架构的默认 CPU 模型，需要时可用 ``-cpu <model>`` 显式指定。

.. code-block:: shell

    # 获取帮助
    qemu-system-x86_64 -cpu help
    # 部分截取
    x86 qemu64  alias configured by machine type
    x86 base    base CPU model type with no features enabled
    x86 host    processor with all supported host features
    x86 max     Enables all features supported by the accelerator in the current host

- host 追求性能，需要开启 kvm 加速。
- max  追求功能，暴露所有支持的指令集。


以下是两种配置 host 的示例，只是开启 kvm 加速的方式不同，第一种更为现代，推荐使用。

.. code-block:: shell

        qemu-system-x86_64 \
        -M q35,accel=kvm \
        -cpu host \
        -drive file=openwrt-23.05.0-x86-64-generic-ext4-combined.img,format=raw \
        -nographic

.. code-block:: shell

        qemu-system-x86_64 -enable-kvm \
        -M q35 \
        -cpu host \
        -drive file=openwrt-23.05.0-x86-64-generic-ext4-combined.img,format=raw \
        -nographic


配置内存（可选）
--------------------------------------------------------------------------------

``-m <size>`` 指定虚拟机内存大小，默认单位为 MiB，可用 M 或 G 作为后缀。

.. code-block:: shell

    -m 1024
    -m 1024M
    -m 1G


.. code-block:: shell

    qemu-system-x86_64 \
    -M q35 \
    -cpu max \
    -m 512M \
    -drive file=openwrt-23.05.0-x86-64-generic-ext4-combined.img,format=raw \
    -nographic


配置网卡（可选，重点）
--------------------------------------------------------------------------------

网卡有两个概念，前端和后端，我们要站在虚拟机的角度去理解，前端是虚拟机内的网卡设备，后端
是宿主机上网络配置。

.. code-block:: shell

    qemu-system-x86_64 \
        -M q35 \
        -cpu max \
        -m 512M \
        -drive file=openwrt-23.05.0-x86-64-generic-ext4-combined.img,format=raw \
        -nographic \
        -netdev user,id=net0 \
        -device virtio-net-pci,netdev=net0

默认情况，openwrt 把第一个网卡，也就是 eth0 作为 lan 网卡，我们需要进行配置。

.. code-block:: shell

    uci set network.@device[0].ports=''
    uci set network.wan=interface
    uci set network.wan.device='eth0'
    uci set network.wan.proto='dhcp'
    uci commit network
    /etc/init.d/network restart

此时，ping 功能是无法工作的（需要查明），我们可以使用 opkg 来测试网络。后续发现需要 sudo
来执行命令，才能 ping 通，猜测是 ping 需要 raw 套接字权限。

.. code-block:: shell

    opkg update

现在我们来说明一下参数含义，-netdev 定义后端，-device 定义前端。

.. code-block:: shell

    # 定义后端，id 为 net0
    -netdev user,id=net0 \
    # 定义前端，绑定到后端 id 为 net0
    -device virtio-net-pci,netdev=net0

通常先写 ``-netdev``，然后写 ``-device``，这样前端可以知道绑定那个后端。

**前端**：多数情况只选 ``virtio-net-pci`` 即可（半虚拟化、性能好，Linux/OpenWrt 自带驱动）。
其他如 ``e1000``、``rtl8139`` 特殊需求时再换。

.. code-block:: shell

    # 多网卡，或特殊情况可以指定 MAC 地址，用于区分不同虚拟机。
    -device virtio-net-pci,netdev=net0,mac=52:54:00:12:34:56

**后端**：通常用 ``user`` 或 ``tap`` 两种模式。

- user 模式提供 NAT 网络，qemu 内置 dhcp 服务
- tap 模式引出网线，需要手动接入宿主机网络，通常是网桥

user 模式有一些配置参数，比如 hostfwd，可以实现端口转发。

.. code-block:: shell

    # hostfwd=[协议]:[宿主机IP]:[宿主机端口]-[虚拟机IP]:[虚拟机端口]
    # 宿主机任意地址都可以通过 8080/2222 端口访问虚拟机 80/22 端口
    -netdev user,id=net0,hostfwd=tcp::8080-:80,hostfwd=tcp::2222-:22

    # 宿主机只能通过 127.0.0.1:8080 端口访问虚拟机 80 端口
    -netdev user,id=net0,hostfwd=tcp:127.0.0.1:8080-:80,hostfwd=tcp::2222-:22


openwrt 默认不允许 wan 访问，需要开放 wan 的 80 和 22 端口。

.. code-block:: shell

    # 添加 SSH 放行规则
    uci add firewall rule
    uci set firewall.@rule[-1].name='Allow-SSH-WAN'
    uci set firewall.@rule[-1].src='wan'
    uci set firewall.@rule[-1].dest_port='22'
    uci set firewall.@rule[-1].proto='tcp'
    uci set firewall.@rule[-1].target='ACCEPT'

    # 添加 HTTP 放行规则
    uci add firewall rule
    uci set firewall.@rule[-1].name='Allow-HTTP-WAN'
    uci set firewall.@rule[-1].src='wan'
    uci set firewall.@rule[-1].dest_port='80'
    uci set firewall.@rule[-1].proto='tcp'
    uci set firewall.@rule[-1].target='ACCEPT'

    uci commit firewall
    /etc/init.d/firewall restart

    # 确保 Dropbear 监听所有接口（留空即代表监听所有）
    uci set dropbear.@dropbear[0].Interface=''
    uci commit dropbear
    /etc/init.d/dropbear restart

如果在虚拟机中运行 qemu，还需在宿主机上开放端口。

.. code-block:: shell

    sudo ufw allow 8080/tcp
    sudo ufw allow 2222/tcp
    sudo ufw enable

此外还可以对网络进行配置,这类参数还有很多，建议需要的时候查阅手册。

.. code-block:: shell

    #net=192.168.10.0/24: 修改虚拟机所在的子网。
    #host=192.168.10.1: 修改宿主机（网关）在虚拟机眼中的 IP。
    #dhcpstart=192.168.10.50: 指定 DHCP 分配的起始地址。
    -netdev user,id=net0,net=192.168.10.0/24,dhcpstart=192.168.10.50


现在来介绍 tap 模式，tap 模式和 user 模式类似，只是后端变成了 tap 设备。更好的理解是引出
了一根网线，这根网线需要手动接入宿主机网络，通常是网桥。

.. code-block:: shell

    # ifname=tap0: 指定使用 tap0 设备。
    # script=no,downscript=no: 禁用 QEMU 的默认网络配置脚本。
    -netdev tap,id=net1,ifname=tap0,script=no,downscript=no
    # 定义前端，绑定到后端 id 为 net0
    -device virtio-net-pci,netdev=net1


首先，我们忽略 down 和 up 脚本，手动管理网络配置。


创建 tap 和网桥，且 tap 加入网桥

.. code-block:: shell

    sudo ip tuntap add mode tap name tap0
    sudo ip link set tap0 up
    sudo ip link add name br0 type bridge
    sudo ip link set br0 up
    sudo ip link set tap0 master br0


启动 qemu，此处为 lan 接口，因为 wan 接口很复杂，需要配置 dhcp 服务器，还需转发规则。

.. code-block:: shell

    qemu-system-x86_64 \
    -M q35 \
    -cpu max \
    -m 512M \
    -drive file=openwrt-23.05.0-x86-64-generic-ext4-combined.img,format=raw \
    -nographic \
    -netdev user,id=net0,hostfwd=tcp::8080-:80,hostfwd=tcp::2222-:22 \
    -device virtio-net-pci,netdev=net0 \
    -netdev tap,id=net1,ifname=tap0,script=no,downscript=no \
    -device virtio-net-pci,netdev=net1


最后把 eth1 加入 openwrt 的 br-lan

.. code-block:: shell

   uci set network.@device[0].ports='eth1'
   uci commit
   /etc/init.d/network restart

现在进行测试，从openwrt 主机获取地址，并 ping 虚拟机。

.. code-block:: shell

    # 先安装 dhcp 客户端
    sudo apt update
    sudo apt install isc-dhcp-client -y
    # 获取地址
    sudo dhclient br0
    # 查看地址
    ip addr show br0
    #  ping 虚拟机或从虚拟机反 ping br0
    ping 192.168.1.1

完成上述步骤，理论上可以通过 web 页面看到这个客户端。


现在来讨论忽略的 down 和 up 脚本，让 qemu 自动管理网络。

.. literalinclude::  ifup.sh
    :language: bash

.. literalinclude::  ifdown.sh
    :language: bash

.. code-block:: shell

    chmod +x ifup.sh
    chmod +x ifdown.sh
    sudo ip link delete tap0
    sudo ip link delete br0

.. code-block:: shell

    sudo qemu-system-x86_64 \
        -M q35 \
        -cpu max \
        -m 512M \
        -drive file=openwrt-23.05.0-x86-64-generic-ext4-combined.img,format=raw \
        -nographic \
        -netdev user,id=net0,hostfwd=tcp::8080-:80,hostfwd=tcp::2222-:22 \
        -device virtio-net-pci,netdev=net0 \
        -netdev tap,id=net1,ifname=tap0,script=ifup.sh,downscript=ifdown.sh \
        -device virtio-net-pci,netdev=net1

本次启动，qemu 自动配置网络。细节如下：

- qemu-system-x86_64 没有创建接口的权限，所以需要 sudo 执行。
- qemu 启动后，会自动创建 tap0 和 br0，并将其加入网桥。
- qemu 退出时，会自动删除 tap0 和 br0。
- 脚本内可以不使用 sudo，因为 qemu-system-x86_64 已经以 root 权限执行。

在说明完 tap 的同时，多网卡也附带进行了说明，但多网卡会遇到一个问题，网卡顺序。

通常网卡配置的顺序就是 eth 的顺序，当然你也可以指定网卡顺序，比如：

.. code-block:: shell

    # q35 机器前面的地址有别的设备，通常从 0x03 开始
    -netdev user,id=net0,hostfwd=tcp::8080-:80,hostfwd=tcp::2222-:22 \
    -device virtio-net-pci,netdev=net0,addr=0x3\
    -netdev tap,id=net1,ifname=tap0,script=ifup.sh,downscript=ifdown.sh \
    -device virtio-net-pci,netdev=net1,addr=0x4


其实前面我已经发现了问题，但偷懒没改，那就按 openwrt 的 eth0 是 lan，eth1 是 wan，现在
全部清空，我再操作一遍，本次操作不需要 uci 修改网卡配置。

.. code-block:: shell

    $ ls -al
    total 11060
    drwxrwxr-x 2 user user     4096 Feb  5 08:05 .
    drwxr-x--- 9 user user     4096 Feb  5 07:51 ..
    -rwxrwxr-x 1 user user      200 Feb  5 07:51 ifdown.sh
    -rwxrwxr-x 1 user user      391 Feb  5 07:38 ifup.sh
    -rw-rw-r-- 1 user user 11308720 Oct 12  2023 openwrt-23.05.0-x86-64-generic-ext4-combined.img.gz
    $ gunzip -k openwrt-23.05.0-x86-64-generic-ext4-combined.img.gz

.. code-block:: shell

    sudo qemu-system-x86_64 \
        -M q35 \
        -cpu max \
        -m 512M \
        -drive file=openwrt-23.05.0-x86-64-generic-ext4-combined.img,format=raw \
        -nographic \
        -netdev tap,id=net1,ifname=tap0,script=ifup.sh,downscript=ifdown.sh \
        -device virtio-net-pci,netdev=net1 \
        -netdev user,id=net0,hostfwd=tcp::8080-:80,hostfwd=tcp::2222-:22 \
        -device virtio-net-pci,netdev=net0

现在配置上 Allow-SSH-WAN 和 Allow-HTTP-WAN 规则即可完成测试。

网卡的配置十分复杂，但网络开发在嵌入式中占据重要部分，这对后续仿真很重要。

最后介绍一下，简化方案，本质就是语法糖，最大的好处就是 id 绑定不会混淆，但灵活性和对原理
的理解不足。

.. code-block:: shell

    -nic user,model=virtio-net-pci,hostfwd=tcp::8080-:80,hostfwd=tcp::2222-:22
    -nic tap,model=virtio-net-pci,ifname=tap0,script=ifup.sh,downscript=ifdown.sh


配置磁盘
--------------------------------------------------------------------------------

磁盘部分可以解决定制化问题，此时我们不能再用合一的镜像。

由于我们指定了 kernel 和 rootfs，启动速度会更快，且定制化程度更高。

.. code-block::

    wget https://downloads.openwrt.org/releases/23.05.0/targets/x86/64/openwrt-23.05.0-x86-64-generic-ext4-rootfs.img.gz
    wget https://downloads.openwrt.org/releases/23.05.0/targets/x86/64/openwrt-23.05.0-x86-64-generic-kernel.bin

    # 可选，openwrt-23.05.0-x86-64-generic-ext4-rootfs.img.gz 由此生成
    wget https://downloads.openwrt.org/releases/23.05.0/targets/x86/64/openwrt-23.05.0-x86-64-rootfs.tar.gz

    gunzip -k openwrt-23.05.0-x86-64-generic-ext4-rootfs.img.gz

    sudo qemu-system-x86_64 \
        -M q35 \
        -cpu max \
        -m 512M \
        -kernel openwrt-23.05.0-x86-64-generic-kernel.bin \
        -drive file=openwrt-23.05.0-x86-64-generic-ext4-rootfs.img,format=raw \
        -append "root=/dev/sda console=ttyS0" \
        -nographic \
        -netdev tap,id=net1,ifname=tap0,script=ifup.sh,downscript=ifdown.sh \
        -device virtio-net-pci,netdev=net1 \
        -netdev user,id=net0,hostfwd=tcp::8080-:80,hostfwd=tcp::2222-:22 \
        -device virtio-net-pci,netdev=net0

.. code-block:: shell

    # 加载 kernel 和 rootfs,并配置启动参数，如果是 arm 架构，还需配置 dtb 文件
    -kernel openwrt-23.05.0-x86-64-generic-kernel.bin \
    -drive file=openwrt-23.05.0-x86-64-generic-ext4-rootfs.img,format=raw \
    -append "root=/dev/sda console=ttyS0" \

启动参数需要注意一点，q35 默认是 ide 设备，if 参数为 sda，如果是 virtio 设备，if 参数
为 vda。ide 的 root 参数为 /dev/sda，如果是 virtio 设备，root 参数为 /dev/vda。

.. code-block:: shell

    # 推荐写法（使用 Virtio）
    -drive file=my_disk.img,format=raw,if=virtio \
    -append "root=/dev/vda console=ttyS0"

    # 兼容写法（使用 IDE）
    -drive file=my_disk.img,format=raw,if=ide \
    -append "root=/dev/sda console=ttyS0"


我们可以使用以下方式定制文件系统，比如把 Allow-HTTP-WAN 和 Allow-SSH-WAN 规则写入文件系统。

.. code-block:: shell

    mkdir loop
    sudo mount -o loop openwrt-23.05.0-x86-64-generic-ext4-rootfs.img loop
    cd loop/
    # 配置文件系统和防火墙规则
    # 配置需要参考 openwrt 的启动规则，可以 uci 配置，可以放在 default 启动脚本
    ...
    cd ..
    sudo umount loop

建议使用 chroot 进行配置，因为 chroot 可以隔离文件系统，避免配置错误影响其他系统。另外，
软件安装等操作必须使用 chroot 进行。

建议阅读 :doc:`../tools/chroot` 文档，了解 chroot 的原理和使用。

.. code-block:: shell

    mkdir loop
    sudo mount -o loop openwrt-23.05.0-x86-64-generic-ext4-rootfs.img loop

    sudo mount -t proc /proc loop/proc
    sudo mount --rbind /sys  loop/sys
    sudo mount --make-rprivate loop/sys
    sudo mount --rbind /dev  loop/dev
    sudo mount --make-rprivate loop/dev
    # 创建锁文件目录，避免 chroot 过程中出现错误
    sudo chroot loop mkdir /var/lock/
    # 配置并备份 resolv.conf 文件，避免 chroot 过程中 DNS 解析错误
    sudo mv loop/etc/resolv.conf loop/etc/resolv.conf.bak
    sudo cp /etc/resolv.conf loop/etc/resolv.conf
    sudo chroot loop opkg update
    sudo chroot loop opkg install bash
    # 恢复 resolv.conf 文件
    sudo mv loop/etc/resolv.conf.bak loop/etc/resolv.conf
    # 卸载文件系统
    sudo umount --recursive loop/proc
    sudo umount --recursive loop/sys
    sudo umount --recursive loop/dev

    sudo umount loop


使用 qemu-img 创建磁盘镜像，并格式化为 ext4 文件系统，然后挂载并解压 rootfs 文件系统。
虽然现在从零开始，使用 busybox 和 kernel 启动很少，但后续可能会有用。

.. code-block:: shell

    qemu-img create -f raw openwrt.img 1G
    sudo mkfs.ext4 openwrt.img
    mkdir loop
    sudo mount -o loop openwrt.img loop/
    sudo tar -C loop -xf openwrt-23.05.0-x86-64-rootfs.tar.gz
    sudo umount loop

.. code-block:: shell

    sudo qemu-system-x86_64 \
        -M q35 \
        -cpu max \
        -m 512M \
        -kernel openwrt-23.05.0-x86-64-generic-kernel.bin \
        -drive file=openwrt.img,format=raw \
        -append "root=/dev/sda console=ttyS0" \
        -nographic \
        -netdev tap,id=net1,ifname=tap0,script=ifup.sh,downscript=ifdown.sh \
        -device virtio-net-pci,netdev=net1 \
        -netdev user,id=net0,hostfwd=tcp::8080-:80,hostfwd=tcp::2222-:22 \
        -device virtio-net-pci,netdev=net0


配置串口
--------------------------------------------------------------------------------

首先我们需要理清几个概念,这部分内容理论上应该放在计算机历史章节。

- terminal： 终端，泛指各种终端设备，如 ssh 远程终端、串口终端、telnet 终端等
- console： 控制台，终端的一种，通常直连计算机，因此拥有较高的权限。很多时候是串口。
- tty： 这是各种终端抽象，如提供统一的交互接口
    - ttyS0： 串口终端设备，
    - pts: ssh 远程终端

以上很多概念和最初的情况也出现了偏差，可以阅读下文

https://jeffreytse.net/computer/2024/07/15/understanding-console-terminal-tty-shell.html

.. code-block:: shell

    root@OpenWrt:/dev# ls tty*
    tty     tty16   tty24   tty32   tty40   tty49   tty57   tty8    ttyS15
    tty0    tty17   tty25   tty33   tty41   tty5    tty58   tty9    ttyS2
    tty1    tty18   tty26   tty34   tty42   tty50   tty59   ttyS0   ttyS3
    tty10   tty19   tty27   tty35   tty43   tty51   tty6    ttyS1   ttyS4
    tty11   tty2    tty28   tty36   tty44   tty52   tty60   ttyS10  ttyS5
    tty12   tty20   tty29   tty37   tty45   tty53   tty61   ttyS11  ttyS6
    tty13   tty21   tty3    tty38   tty46   tty54   tty62   ttyS12  ttyS7
    tty14   tty22   tty30   tty39   tty47   tty55   tty63   ttyS13  ttyS8
    tty15   tty23   tty31   tty4    tty48   tty56   tty7    ttyS14  ttyS9
    root@OpenWrt:/dev#
    root@OpenWrt:/dev# ls pts/*
    pts/0     pts/ptmx
    root@OpenWrt:/dev#
    root@OpenWrt:/dev# cat /proc/tty/driver/serial
    serinfo:1.0 driver revision:
    0: uart:16550A port:000003F8 irq:4 tx:11882 rx:1137 RTS|CTS|DTR|DSR|CD
    1: uart:unknown port:000002F8 irq:3
    ......
    14: uart:unknown port:00000000 irq:0
    15: uart:unknown port:00000000 irq:0

- ttyS[0-15]： 串口终端设备，每个设备对应一个串口。通常卡位 16 个，从驱动来看只有一个串口。
- pts/0： pts 是 pseudo terminal slave 的缩写。同时就是 ssh 远程终端。来一个创建一个。
- tty[0-63]: 虚拟终端，当年的系统和显示器无法实现窗口，切换终端就是切换窗口。
- tty 指向当前终端，这样串口、ssh 都可以直接找到自己

.. code-block:: shell

    -append "root=/dev/sda console=ttyS0" \
    -nographic \

所以上面的含义是，使用串口终端设备 ttyS0 作为控制台，nographic 约等于以下两个参数

.. code-block:: shell

    -display none
    -serial mon:stdio

- display none： 不显示图形界面
- serial mon:stdio： 将串口终端和 qemu 的 monitor 输出到当前宿主机的终端

串口终端好理解，monitor 是什么？monitor 是 qemu 的控制台，可以查看 qemu 的运行状态，执行命令等。
我们可以使用 :kbd:`Ctrl+a+c` 在串口终端和 monitor 之间切换。默认是串口终端。

.. code-block:: shell

    root@OpenWrt:/dev#
    # Ctrl+a+c 进入 monitor 模式
    root@OpenWrt:/dev# QEMU 8.2.2 monitor - type 'help' for more information
    (qemu)

    # Ctrl+a+c 进入串口
    root@OpenWrt:/dev#
    (qemu)
    (qemu)

    root@OpenWrt:/dev# (qemu)

    root@OpenWrt:/dev#

另外这和以下参数也不等价，分开写会相互影响，失去协调功能。

.. code-block:: shell

    -nographic
    # 约等于
    -display none
    -serial mon:stdio

    # QEMU 知道这是“混合流”
    Guest serial ─┐
                  ├──▶ stdio  （单一通道）
    QEMU monitor ─┘
    -----------------------------------------------------
    # 全部分开处理
    -display none
    -serial stdio
    -monitor stdio

    # QEMU 无法准确处理，会混淆。
    Guest serial ─▶ stdio
    QEMU monitor ─▶ stdio


理解以上概念后，让我们开始添加串口

.. code-block:: shell

    #最简单
    -nographic

    # 串口终端和 monitor 合一，输出到当前宿主机的终端
    -display none
    -serial mon:stdio

    # 各种形式的串口和 monitor
    -serial stdio
    -serial file:/tmp/serial.log
    -serial unix:/tmp/serial.sock,server,nowait
    -serial tcp:127.0.0.1:5001,server,nowait

    -monitor stdio
    # -monitor file:/tmp/monitor.log
    -monitor unix:/tmp/monitor.sock,server,nowait
    -monitor tcp:127.0.0.1:5002,server,nowait

组合多种多样，根据实际需求选择，但应当需要注意一下情况:

- 串口和 monitor 都输出到当前宿主机的终端，这个问题已经有说明了，这里不再赘述。

.. code-block:: shell

    -monitor stdio
    -serial stdio

- monitor 输出到文件，这会导致无法操作，不建议使用。
- monitor 必须配置，避免无法操作虚拟机
- serial  通常配置一个，多个串口要手动给串口配置 shell

现在我们可以使用 socat 访问虚拟机

.. code-block:: shell

    sudo tail -f /tmp/serial.log
    sudo socat UNIX-CONNECT:/tmp/serial.sock STDIO,raw,echo=0,escape=0x18
    sudo socat TCP4:127.0.0.1:5001 STDIO,raw,echo=0,escape=0x18

    # monitor 同理
    # sudo tail -f /tmp/monitor.log
    sudo socat UNIX-CONNECT:/tmp/monitor.sock STDIO,raw,echo=0,escape=0x18
    sudo socat TCP4:127.0.0.1:5002 STDIO,raw,echo=0,escape=0x18

    # STDIO 是标准输入输出, 可以用 - 代替
    # raw 提供信号控制，比如 ctrl+c 中断虚拟机中的进程，而不是 socat 自己中断
    # raw 提供字符控制和缓冲行控制，比如 tab 会直接发到虚拟机，而不是空格，也不需要等回车
    # 然后把数据发送给虚拟机，提供了实时交互功能
    # echo=0 是关闭回显
    # escape=0x18 ，因为 raw 接管了 ctrl+c 信号，此时就用 ctrl+x 来中断 socat
    # 0x18 对应 ascii 码的 ctrl+x，这个键位用的最少，可能和 nano 编辑器冲突
    # 0x1d 对应 Ctrl + ]，也是不错的选择，只是按键间距大，不能单手操作


后台运行
--------------------------------------------------------------------------------

 `-daemonize` 可以和 `-display none` 一起使用，后台运行。当然，必须要配合上面的串口和
 monitor 参数一起使用。


.. code-block:: shell

    qemu-system-x86_64 -daemonize -display none ...

此外，这还有一个问题，后台运行往往会存在多个虚拟机，我们可以使用其他参数来确定是哪个虚拟机。

.. code-block:: shell

    sudo qemu-system-x86_64 \
        -display none \
        -daemonize \
        -pidfile /tmp/openwrt_vm1.pid \
        -name "OpenWrt_VM1",process="OpenWrt_VM1"

- `name` 参数可以给虚拟机命名，是 qemu 使用的
- `process` 参数可以给虚拟机进程命名，是 ps killall 等命令使用的
- `pidfile` 参数可以给虚拟机进程写入 pid 文件，可以用于管理虚拟机进程


.. code-block:: shell

    # 在 monitor 中使用 info name 命令可以查看虚拟机名称
    (qemu) info name
    OpenWrt_VM1

    # 在 ps 命令中使用 grep 命令可以查看虚拟机进程
    # ef 显示启动该进程的原始二进制路径
    # 注意 sudo 启动的父子孙三代进程
    $ ps -ef | grep qemu
    root       71232   70762  0 09:00 pts/4    00:00:00 sudo qemu-system-x86_64 -M q35 -cpu max -m 512M -drive file=openwrt-23.05.0-x86-64-generic-ext4-combined.img,format=raw -nographic -netdev user,id=net0 -device virtio-net-pci,netdev=net0 -name VM_NAME1,process=VM_NAME2
    root       71233   71232  0 09:00 pts/3    00:00:00 sudo qemu-system-x86_64 -M q35 -cpu max -m 512M -drive file=openwrt-23.05.0-x86-64-generic-ext4-combined.img,format=raw -nographic -netdev user,id=net0 -device virtio-net-pci,netdev=net0 -name VM_NAME1,process=VM_NAME2
    root       71234   71233 12 09:00 pts/3    00:00:29 qemu-system-x86_64 -M q35 -cpu max -m 512M -drive file=openwrt-23.05.0-x86-64-generic-ext4-combined.img,format=raw -nographic -netdev user,id=net0 -device virtio-net-pci,netdev=net0 -name VM_NAME1,process=VM_NAME2
    dummy       71263   70993  0 09:04 pts/6    00:00:00 grep --color=auto qemu

.. code-block:: shell

    # a 显示所有进程
    $ ps -a
    PID TTY          TIME CMD
     4136 tty2     00:00:00 gnome-session-b
    70914 pts/4    00:00:00 sudo
    70916 pts/5    00:00:45 VM_NAME2
    71153 pts/6    00:00:00 ps
    $ sudo killall -9 VM_NAME2

.. code-block:: shell

    # 使用 pidfile 文件可以找到虚拟机进程
    sudo cat /tmp/openwrt_vm1.pid
    71234

    # 使用 pid 杀死进程
    # 其实多数情况是放在当前目录，也就是每个目录为一个虚拟机配置
    # 这样就可以直接 kill 当前目录下的虚拟机进程
    # 也可以避免重复启动
    $ kill $(cat /tmp/openwrt_vm1.pid)

    if [ -f xxx/openwrt_vm.pid ]; then
        # 杀死进程
        # kill $(cat xxx/openwrt_vm.pid)
        # 或退出脚本
        #exit 1
    fi


配置共享目录
--------------------------------------------------------------------------------

启动参数

.. code-block:: shell

    mkdir -p /path/to/your/share
    -virtfs local,path=/path/to/your/share,mount_tag=hostshare,security_model=passthrough,id=fsdev0

- local： 本地目录
- path： 本地目录路径
- mount_tag： 共享目录在虚拟机中的挂载点
- security_model： 安全模式，passthrough 或 mapped-xattr
- id： 共享目录的 id

文件系统的权限是一个很大的问题，这个后续会详细介绍。

openwrt 文件挂载

.. code-block:: shell

    opkg update
    opkg install kmod-9pnet-virtio kmod-fs-9p
    mkdir -p /mnt/shared
    mount -t 9p -o trans=virtio hostshare /mnt/shared

此处，hostshare 是共享目录在虚拟机中的挂载点，也就是启动参数中的 mount_tag。

现在面临的问题就是文件权限

- 因为 qemu 不能操作网络，也就是没有 raw 和 netadmin 权限，此时我们使用sudo 权限启动。
    - passthrough 在虚拟机创建的文件，在外部看来是 root，只读
    - mapped-xattr 在虚拟机创建的文件，在外部看来是 root，无权限

为了解决这个问题，我们可以使用以下方法：

.. code-block:: shell

    # 给 qemu-system-x86_64 添加 net_admin 和 net_raw 权限
    # 此时，qemu-system-x86_64 无需 sudo 权限启动
    sudo setcap 'cap_net_admin,cap_net_raw+ep' $(which qemu-system-x86_64)

    # ifdown.sh 和 ifup.sh 内部加上 sudo 操作网络，sudo 默认关闭密码验证
    # 这涉及 cap 能力继承，此处暂且不表

    # 权限变更为 mapped-xattr
    -virtfs local,path=/path/to/your/share,mount_tag=hostshare,security_model=mapped-xattr,id=fsdev0

现在虚拟机内的文件是 root，而外部宿主机的文件是当前用户。
