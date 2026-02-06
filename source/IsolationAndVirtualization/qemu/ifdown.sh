#!/bin/bash
BRIDGE="br0"
INTERFACE=$1

# 移出并关闭接口
sudo ip link set "$INTERFACE" nomaster
sudo ip link set "$INTERFACE" down
sudo ip link delete "$INTERFACE"
sudo ip link delete "$BRIDGE"

echo "Interface $INTERFACE is now disconnected from $BRIDGE."
