这些是 OpenWrt x86/64 的官方镜像，按用途可以这样理解：

---

| 文件 | 说明 |
|------|------|
| **generic-kernel.bin** | 仅 **Linux 内核**。需要自己准备根文件系统（rootfs）和启动方式，用 `-kernel` 直接加载时用这个。 |
| **generic-ext4-rootfs.img.gz** | 仅 **ext4 根文件系统镜像**（压缩）。一个分区镜像，不含内核、不含引导，要自己分区、写盘，再配合上面的 kernel 或别的内核用。 |
| **generic-squashfs-rootfs.img.gz** | 仅 **squashfs 只读根文件系统镜像**（压缩）。同上，但是只读根分区，适合“系统只读 + overlay”的用法。 |
| **generic-ext4-combined.img.gz** | **整盘镜像（BIOS/传统引导）**：分区表 + 引导 + 内核 + **ext4 根分区**，解压后整盘 `dd` 到硬盘即可从该盘启动；在 QEMU 里用 `-kernel` 时也可以只当“盘”用，root 在 **sda2**。 |
| **generic-ext4-combined-efi.img.gz** | 同上，但是 **UEFI 引导** 的整盘镜像，用于 UEFI 机器或 `-bios uefi` 的 QEMU。 |
| **generic-squashfs-combined.img.gz** | **整盘镜像（BIOS/传统引导）**：分区表 + 引导 + 内核 + **squashfs 只读根分区**，体积比 ext4 小，写好后也是整盘启动或当盘用。 |
| **generic-squashfs-combined-efi.img.gz** | 同上，**UEFI 引导** 的 squashfs 整盘镜像。 |
| **rootfs.tar.gz** | **根文件系统打包成 tar**。不是块设备镜像，是目录树，用来自己建分区、挂载、解压进去，适合自定义分区布局或已有 kernel+引导 时“只装 rootfs”。 |

---

**简要对照：**

- **combined** = 一整块盘（分区表 + 引导 + 内核 + root），直接写盘或给 QEMU 当硬盘。
- **rootfs.img.gz** = 只有根分区镜像，没有内核和引导，要配合 **generic-kernel.bin** 和自建分区/引导用。
- **ext4** = 根分区是 ext4，可写、可扩容。
- **squashfs** = 根分区只读，改动用 overlay，通常更小、更省空间。
- **efi** = UEFI 启动；不带 efi = 传统 BIOS 启动。
- **rootfs.tar.gz** = 只是“根目录打包”，不是镜像，用于手动部署 rootfs。
