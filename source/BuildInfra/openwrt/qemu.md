# OpenWrt QEMU 环境搭建指南

## 1. 环境准备

### 1.1 安装必要软件
```bash
# Ubuntu/Debian
sudo apt update
sudo apt install -y qemu-system-x86 qemu-utils

# Fedora/RHEL/CentOS
sudo dnf install -y qemu-system-x86 qemu-img
```

### 1.2 下载 OpenWrt 镜像
```bash
# 创建目录
mkdir -p openwrt-qemu
cd openwrt-qemu

# 下载必要文件（以 x86_64 为例）
wget https://downloads.openwrt.org/releases/23.05.0/targets/x86/64/openwrt-23.05.0-x86-64-generic-kernel.bin
wget https://downloads.openwrt.org/releases/23.05.0/targets/x86/64/openwrt-23.05.0-x86-64-rootfs.tar.gz
```

## 2. 创建磁盘镜像

### 2.1 使用 loop 设备方法
```bash
#!/bin/bash

# 创建镜像
qemu-img create -f qcow2 openwrt.qcow2 1G
qemu-img convert -O raw openwrt.qcow2 openwrt.raw

# 设置 loop 设备
sudo losetup -f openwrt.raw
LOOP_DEV=$(losetup -a | grep openwrt.raw | cut -d: -f1)

# 分区和格式化
sudo fdisk $LOOP_DEV << EOF
n
p
1

w
EOF
sudo mkfs.ext4 ${LOOP_DEV}p1

# 挂载和复制
sudo mkdir -p /mnt/openwrt
sudo mount ${LOOP_DEV}p1 /mnt/openwrt
mkdir rootfs
tar xzf openwrt-23.05.0-x86-64-rootfs.tar.gz -C rootfs
sudo cp -a rootfs/* /mnt/openwrt/

# 清理
sudo umount /mnt/openwrt
sudo losetup -d $LOOP_DEV
qemu-img convert -O qcow2 openwrt.raw openwrt.qcow2
rm -rf rootfs openwrt.raw
```

## 3. 启动 OpenWrt

### 3.1 基本启动脚本
```bash
#!/bin/bash

KERNEL="openwrt-23.05.0-x86-64-generic-kernel.bin"
ROOTFS="openwrt.qcow2"

qemu-system-x86_64 \
    -M q35 \
    -m 512M \
    -smp 2 \
    -kernel $KERNEL \
    -drive file=$ROOTFS,format=qcow2,id=d0,if=none \
    -device ide-hd,drive=d0,bus=ide.0 \
    -append "root=/dev/sda console=ttyS0" \
    -nographic \
    -netdev user,id=net0,net=192.168.1.0/24,dhcpstart=192.168.1.100 \
    -device virtio-net-pci,netdev=net0
```

### 3.2 带图形界面的启动
```bash
qemu-system-x86_64 \
    -M q35 \
    -m 512M \
    -smp 2 \
    -kernel $KERNEL \
    -drive file=$ROOTFS,format=qcow2,id=d0,if=none \
    -device ide-hd,drive=d0,bus=ide.0 \
    -append "root=/dev/sda console=ttyS0" \
    -display gtk \
    -netdev user,id=net0,net=192.168.1.0/24,dhcpstart=192.168.1.100 \
    -device virtio-net-pci,netdev=net0
```

### 3.3 带调试支持的启动
```bash
qemu-system-x86_64 \
    -M q35 \
    -m 512M \
    -smp 2 \
    -kernel $KERNEL \
    -drive file=$ROOTFS,format=qcow2,id=d0,if=none \
    -device ide-hd,drive=d0,bus=ide.0 \
    -append "root=/dev/sda console=ttyS0 nokaslr" \
    -s -S \
    -nographic
```

## 4. 网络配置

### 4.1 在 OpenWrt 中配置网络
```bash
# 登录 OpenWrt（默认用户名：root，无密码）
uci set network.lan.ipaddr='192.168.1.1'
uci commit network
/etc/init.d/network restart
```

### 4.2 多网卡配置
```bash
qemu-system-x86_64 \
    -netdev user,id=net0,net=192.168.1.0/24,dhcpstart=192.168.1.100 \
    -device virtio-net-pci,netdev=net0 \
    -netdev user,id=net1,net=192.168.2.0/24 \
    -device virtio-net-pci,netdev=net1
```

## 5. 注意事项

1. 确保系统已安装 QEMU 和相关工具
2. 根据实际需求调整内存大小
3. 网络配置可以根据需要修改
4. 建议使用 virtio 设备提高性能
5. 首次启动可能需要等待较长时间
6. 确保有足够的磁盘空间
7. 需要 root 权限创建和挂载镜像

## 6. 故障排除

1. 如果无法启动，检查：
   - 镜像文件权限
   - 磁盘空间是否足够
   - QEMU 版本兼容性

2. 如果网络不通，检查：
   - 网络配置是否正确
   - 防火墙设置
   - QEMU 网络参数

3. 如果性能不佳，尝试：
   - 使用 virtio 设备
   - 增加内存大小
   - 调整 CPU 核心数

## 7. 参考链接

- OpenWrt 官方文档：https://openwrt.org/docs/guide-user/installation/generic.x86
- QEMU 文档：https://www.qemu.org/docs/master/system/index.html
- Loop 设备文档：https://www.kernel.org/doc/html/latest/admin-guide/blockdev/loop.html


你提到的两个参数是 QEMU 中 **网络配置的核心部分**，分别定义了 **网络后端**（`-netdev`）和 **前端虚拟设备**（`-device`）。它们的组合实现了虚拟机与宿主机的网络通信。以下是详细解释：

---

### **1. 参数解析**
#### **`-netdev tap,id=net0,ifname=tap0,script=no,downscript=no`**
- **作用**：定义一个基于 TAP 设备的网络后端。
  - `tap`：使用 TAP 模式（直接连接到宿主机的网络接口）。
  - `id=net0`：为此网络后端命名，后续通过 `-device` 绑定。
  - `ifname=tap0`：指定使用宿主机上的 TAP 设备 `tap0`。
  - `script=no` 和 `downscript=no`：禁用 QEMU 的默认网络配置脚本（避免自动修改网络配置）。

#### **`-device virtio-net-pci,netdev=net0`**
- **作用**：在虚拟机内创建一个 PCI 虚拟网卡，并将其绑定到 `net0` 网络后端。
  - `virtio-net-pci`：使用 VirtIO 半虚拟化网卡（高性能驱动）。
  - `netdev=net0`：关联到之前定义的 `id=net0` 网络后端。

---

### **2. 为什么需要同时配置？**
QEMU 的网络模型分为 **后端**（网络连接方式）和 **前端**（虚拟硬件设备），二者需配合使用：

| **组件**       | **功能**                                     | **类比现实场景**           |
|----------------|---------------------------------------------|--------------------------|
| **`-netdev`**  | 定义虚拟机如何连接到宿主机网络（如 TAP 桥接） | 网线连接到路由器的物理端口 |
| **`-device`**  | 定义虚拟机内部的网卡硬件类型（如 VirtIO）     | 电脑主板上的网卡芯片       |

#### **协作流程**
1. **后端 (`-netdev`)**：创建 TAP 设备 `tap0`，并将其桥接到宿主机的物理网络（例如通过 `br0` 桥接）。
2. **前端 (`-device`)**：在虚拟机内模拟一个高性能的 VirtIO 网卡，并通过 `netdev=net0` 绑定到后端。
3. **通信**：虚拟机通过 VirtIO 网卡发送数据 → 数据经过 TAP 设备 `tap0` → 转发到宿主机网络。

---

### **3. 关键参数详解**
#### **`script=no` 和 `downscript=no`**
- **默认行为**：QEMU 会尝试自动执行 `/etc/qemu-ifup` 和 `/etc/qemu-ifdown` 脚本来配置网络（例如设置 TAP 设备的 IP）。
- **设置为 `no` 的原因**：
  - 用户希望 **手动管理网络配置**（例如通过 `ip` 命令创建桥接）。
  - 避免权限问题（QEMU 可能因权限不足无法执行脚本）。

#### **`virtio-net-pci` 的优势**
- **高性能**：VirtIO 是半虚拟化驱动，减少模拟硬件开销。
- **兼容性**：现代 Linux 内核默认支持 VirtIO 驱动。
- **必选条件**：虚拟机内需有 VirtIO 驱动（OpenWrt 默认已包含）。

---

### **4. 完整网络配置示例**
#### **步骤 1：宿主机创建 TAP 设备和桥接**
```bash
# 创建 TAP 设备
sudo ip tuntap add mode tap name tap0
sudo ip link set tap0 up

# 创建桥接并绑定到物理网卡（例如 eth0）
sudo ip link add name br0 type bridge
sudo ip link set br0 up
sudo ip link set tap0 master br0
sudo ip link set eth0 master br0  # 替换为你的物理网卡名
```

#### **步骤 2：启动 QEMU**
```bash
qemu-system-x86_64 \
  -netdev tap,id=net0,ifname=tap0,script=no,downscript=no \
  -device virtio-net-pci,netdev=net0 \
  -drive file=openwrt.img,format=raw
```

#### **步骤 3：虚拟机内配置网络**
在 OpenWrt 中为 VirtIO 网卡分配 IP（例如通过 LuCI 界面或命令行）：
```bash
# 登录 OpenWrt
uci set network.lan.ipaddr='192.168.1.2'
uci commit
service network restart
```

---

### **5. 对比其他网络模式**
#### **用户模式网络（简单但功能有限）**
```bash
-netdev user,id=net0 -device virtio-net-pci,netdev=net0
```
- **优点**：无需宿主机配置，虚拟机可直接通过 NAT 访问外网。
- **缺点**：外部无法直接访问虚拟机，性能较低。

#### **TAP 桥接模式（高性能且灵活）**
```bash
-netdev tap,id=net0,ifname=tap0 -device virtio-net-pci,netdev=net0
```
- **优点**：虚拟机与宿主机网络平级，支持双向通信和高吞吐量。
- **缺点**：需手动配置桥接。

---

### **6. 常见问题**
#### **Q1：虚拟机内无法识别 VirtIO 网卡**
- **原因**：虚拟机内核未包含 VirtIO 驱动。
- **解决**：编译 OpenWrt 时启用 `kmod-virtio-net`。

#### **Q2：TAP 设备无流量**
- **检查桥接状态**：
  ```bash
  brctl show br0  # 确认 tap0 和 eth0 已桥接
  ```
- **验证防火墙规则**：
  ```bash
  sudo iptables -I FORWARD -i br0 -j ACCEPT
  ```

#### **Q3：为什么要用 `virtio-net-pci` 而不是 `e1000`？**
- **性能**：VirtIO 的吞吐量比完全模拟的 `e1000` 高 2-3 倍。
- **开销**：VirtIO 减少 CPU 占用（适合高负载场景）。

---

### **总结**
- **`-netdev`** 定义虚拟机如何连接宿主机网络（TAP 桥接）。
- **`-device`** 定义虚拟机内的网卡硬件类型（VirtIO 高性能驱动）。
- 二者通过 `id=net0` 和 `netdev=net0` 关联，共同实现完整的网络功能。
