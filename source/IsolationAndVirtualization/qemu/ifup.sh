#!/bin/bash
BRIDGE="br0"
INTERFACE=$1

# 检查网桥是否存在，不存在则创建
if [ ! -d "/sys/class/net/$BRIDGE" ]; then
    sudo ip link add $BRIDGE type bridge
    sudo ip link set $BRIDGE up
fi

# 激活 QEMU 传进来的接口
sudo ip link set $INTERFACE up
# 挂载到网桥
sudo ip link set $INTERFACE master $BRIDGE

echo "Interface $INTERFACE is now connected to $BRIDGE."
