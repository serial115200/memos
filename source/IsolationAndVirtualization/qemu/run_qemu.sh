#!/bin/bash
#===============================================================================
# 根据配置文件拼接 QEMU 启动命令并执行（Quickemu 风格：source 配置 + args 数组）
# 用法: run_qemu.sh [配置文件]  默认使用同目录下 qemu.conf
# 选项: --print  仅打印拼接后的命令，不执行
#===============================================================================

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_FILE="${1:-${SCRIPT_DIR}/qemu.conf}"
PRINT_ONLY=false

[ "$1" = "--print" ] && PRINT_ONLY=true && CONFIG_FILE="${2:-${SCRIPT_DIR}/qemu.conf}"

if [ ! -f "$CONFIG_FILE" ]; then
    echo "配置文件不存在: $CONFIG_FILE" >&2
    echo "可复制 qemu.conf.example 为 qemu.conf 并修改后使用。" >&2
    exit 1
fi

CONFIG_DIR="$(cd "$(dirname "$CONFIG_FILE")" && pwd)"
QEMU_BIN="qemu-system-x86_64"

# -----------------------------------------------------------------------------
# 默认配置（可被配置文件中的赋值覆盖）
# -----------------------------------------------------------------------------
MACHINE="${MACHINE:-q35}"
CPU="${CPU:-max}"
MEMORY="${MEMORY:-512M}"
COMBINED_IMAGE=""
KERNEL=""
ROOTFS=""
APPEND=""
DRIVE_IF=""
NETDEV_0=""
DEVICE_0=""
DAEMONIZE=""
NAME=""
PROCESS=""
PIDFILE=""
VIRTFS_PATH=""
VIRTFS_TAG=""
VIRTFS_SECURITY="${VIRTFS_SECURITY:-passthrough}"
EXTRA=""

# 加载配置文件（Shell 语法，可直接写变量赋值与注释）
source "$CONFIG_FILE"

# 相对路径转为基于配置文件所在目录的绝对路径
resolve_path() {
    local v="$1"
    [ -z "$v" ] && return
    case "$v" in /*) echo "$v" ;; *) echo "${CONFIG_DIR}/$v" ;; esac
}
[ -n "$COMBINED_IMAGE" ] && COMBINED_IMAGE="$(resolve_path "$COMBINED_IMAGE")"
[ -n "$KERNEL" ]         && KERNEL="$(resolve_path "$KERNEL")"
[ -n "$ROOTFS" ]         && ROOTFS="$(resolve_path "$ROOTFS")"
[ -n "$VIRTFS_PATH" ]    && VIRTFS_PATH="$(resolve_path "$VIRTFS_PATH")"

# 解析 netdev 中的 script= / downscript= 相对路径
resolve_netdev() {
    local v="$1"
    local s
    s="${v#*script=}"
    if [ "$s" != "$v" ]; then
        s="${s%%,*}"; s="${s%% *}"
        case "$s" in
            /*) ;;
            *) [ -n "$s" ] && v="${v//script=$s/script=${CONFIG_DIR}\/$s}"
        esac
    fi
    s="${v#*downscript=}"
    if [ "$s" != "$v" ]; then
        s="${s%%,*}"; s="${s%% *}"
        case "$s" in
            /*) ;;
            *) [ -n "$s" ] && v="${v//downscript=$s/downscript=${CONFIG_DIR}\/$s}"
        esac
    fi
    echo "$v"
}

# -----------------------------------------------------------------------------
# 用 args 数组拼接 QEMU 参数
# -----------------------------------------------------------------------------
args=()

configure_machine() {
    [ -n "$MACHINE" ] && args+=(-M "$MACHINE")
    [ -n "$CPU" ]     && args+=(-cpu "$CPU")
    [ -n "$MEMORY" ]  && args+=(-m "$MEMORY")
}

configure_drive() {
    if [ -n "$COMBINED_IMAGE" ]; then
        local drive="file=${COMBINED_IMAGE},format=raw"
        [ -n "$DRIVE_IF" ] && drive="${drive},if=${DRIVE_IF}"
        args+=(-drive "$drive")
    elif [ -n "$KERNEL" ] && [ -n "$ROOTFS" ]; then
        args+=(-kernel "$KERNEL")
        local drive="file=${ROOTFS},format=raw"
        [ -n "$DRIVE_IF" ] && drive="${drive},if=${DRIVE_IF}"
        args+=(-drive "$drive")
        [ -n "$APPEND" ] && args+=(-append "$APPEND")
    else
        echo "配置错误: 请设置 COMBINED_IMAGE 或同时设置 KERNEL 与 ROOTFS。" >&2
        exit 1
    fi
}

configure_net() {
    local i=0 nkey dkey nval dval
    while true; do
        nkey="NETDEV_$i"
        dkey="DEVICE_$i"
        nval="${!nkey}"
        dval="${!dkey}"
        [ -z "$nval" ] && break
        nval="$(resolve_netdev "$nval")"
        args+=(-netdev "$nval")
        [ -n "$dval" ] && args+=(-device "$dval")
        i=$((i + 1))
    done
}

configure_display() {
    args+=(-nographic)
    [ "$DAEMONIZE" = "1" ] && args+=(-daemonize)
}

configure_optional() {
    if [ -n "$NAME" ]; then
        if [ -n "$PROCESS" ]; then
            args+=(-name "${NAME},process=${PROCESS}")
        else
            args+=(-name "$NAME")
        fi
    fi
    [ -n "$PIDFILE" ] && args+=(-pidfile "$PIDFILE")
    if [ -n "$VIRTFS_PATH" ] && [ -n "$VIRTFS_TAG" ]; then
        args+=(-virtfs "local,path=${VIRTFS_PATH},mount_tag=${VIRTFS_TAG},security_model=${VIRTFS_SECURITY},id=fsdev0")
    fi
    if [ -n "$EXTRA" ]; then
        for piece in $EXTRA; do
            args+=("$piece")
        done
    fi
}

# -----------------------------------------------------------------------------
# 组装命令并执行
# -----------------------------------------------------------------------------
configure_machine
configure_drive
configure_net
configure_display
configure_optional

CMD=("$QEMU_BIN" "${args[@]}")

if [ "$PRINT_ONLY" = true ]; then
    printf '%q ' "${CMD[@]}"
    echo
    exit 0
fi

echo "执行: $(printf '%q ' "${CMD[@]}")" >&2
exec "${CMD[@]}"
