strace 命令
================================================================================

软件安装

.. code-block::

    sudo apt update
    sudo apt install strace -y


追踪命令

.. code-block::

    ~$ strace date
    execve("/bin/date", ["date"], 0xffffe1360670 /* 14 vars */) = 0
    set_tid_address(0xffffb1f8e258)         = 6706
    brk(NULL)                               = 0x34238000
    brk(0x3423a000)                         = 0x3423a000
    mmap(0x34238000, 4096, PROT_NONE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x34238000
    openat(AT_FDCWD, "/etc/ld-musl-aarch64.path", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
    openat(AT_FDCWD, "/lib/libgcc_s.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = 3
    fcntl(3, F_SETFD, FD_CLOEXEC)           = 0
    fstat(3, {st_mode=S_IFREG|0644, st_size=132736, ...}) = 0
    read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0\267\0\1\0\0\0\0\0\0\0\0\0\0\0"..., 960) = 960
    mmap(NULL, 200704, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0xffffb1ebb000
    mmap(0xffffb1eea000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x1f000) = 0xffffb1eea000
    close(3)                                = 0
    mprotect(0xffffb1eea000, 4096, PROT_READ) = 0
    mprotect(0x42f000, 4096, PROT_READ)     = 0
    openat(AT_FDCWD, "/etc/TZ", O_RDONLY|O_NONBLOCK|O_LARGEFILE|O_CLOEXEC) = 3
    fstat(3, {st_mode=S_IFREG|0644, st_size=6, ...}) = 0
    mmap(NULL, 6, PROT_READ, MAP_SHARED, 3, 0) = 0xffffb1f86000
    close(3)                                = 0
    ioctl(1, TIOCGWINSZ, {ws_row=46, ws_col=132, ws_xpixel=0, ws_ypixel=0}) = 0
    writev(1, [{iov_base="Wed Sep 18 15:22:22 CST 2024", iov_len=28}, {iov_base="\n", iov_len=1}], 2Wed Sep 18 15:22:22 CST 2024
    ) = 29
    close(1)                                = 0
    close(2)                                = 0
    exit_group(0)                           = ?
    +++ exited with 0 +++


不同系统的输出内容差异很大，毕竟设计系统调用，此外 strace 追踪系统调用，需要注意几点

* 不涉及系统调用的
