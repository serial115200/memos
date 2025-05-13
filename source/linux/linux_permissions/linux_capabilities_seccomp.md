# Linux 权限与安全机制

## Linux 运行程序权限判断流程

Linux 在运行程序时会进行一系列权限检查，确保安全性。以下是完整的判断流程：

1. **基本文件权限检查**
   - 检查执行者对程序文件是否有执行权限（x 位）
   - 检查路径上所有目录是否有执行权限（x 位）和读取权限（r 位）

2. **特殊权限位检查**
   - SUID (Set User ID): 程序以文件所有者身份运行
   - SGID (Set Group ID): 程序以文件所属组身份运行
   - Sticky bit: 影响目录中文件的删除权限

3. **文件系统挂载选项检查**
   - `noexec` 挂载选项会阻止执行该文件系统上的程序
   - 内核 2.6.20 后，`MS_NOEXEC` 标志会被严格执行

4. **Capabilities 检查**
   - 如果程序设置了 capabilities，即使非 root 用户也可执行特权操作
   - 例如 `ping` 命令通常设置 `cap_net_raw+ep` 允许非 root 用户发送 ICMP 包

5. **ptrace 访问模式检查**
   - 检查调用进程是否有权限对目标进程执行操作
   - 包括 `PTRACE_MODE_FSCREDS` 和 `PTRACE_MODE_REALCREDS` 两种模式

6. **seccomp 过滤器检查**
   - 如果启用了 seccomp，会根据配置的过滤规则限制系统调用

7. **SELinux/AppArmor 检查**
   - 如果系统启用了 SELinux 或 AppArmor，会根据安全策略进行额外检查

8. **命名空间和容器限制**
   - 在容器或特定命名空间中，可能有额外的权限限制

9. **资源限制检查**
   - 检查是否超过 `RLIMIT_NPROC` 等资源限制

当所有适用的权限检查都通过后，程序才会被执行。

## Capabilities 与 seccomp 比较

### Capabilities 作为细粒度权限白名单

Capabilities 将传统的 root 权限分解成更小、更具体的权限单元：

- 传统模型：进程要么拥有 root 权限（可以做任何事），要么没有（受限）
- Capabilities 模型：将 root 权限分解为约 40 个独立能力
- 常见 capabilities 包括：CAP_NET_RAW, CAP_SYS_ADMIN, CAP_CHOWN 等
- 进程只获得它需要的特定 capabilities，而不是完整的 root 权限
- 例如：ping 命令只需要 CAP_NET_RAW 而不需要完整的 root 权限

### seccomp 作为系统调用过滤器

seccomp (secure computing mode) 是一个系统调用过滤机制：

- strict 模式：白名单模式，只允许 read/write/exit/sigreturn
- filter 模式（更常用）：
  - 可配置为黑名单：阻止特定系统调用，允许其他所有调用
  - 可配置为白名单：只允许特定系统调用，阻止其他所有调用
  - 支持复杂规则：基于系统调用参数值进行判断

### 两者的关系与区别

1. **操作层次不同**：
   - Capabilities 控制特权操作的能力
   - seccomp 控制系统调用的使用

2. **实现方式不同**：
   - Capabilities 是对权限的细分
   - seccomp 是对系统调用的过滤

3. **组合使用**：
   - 在容器和安全敏感环境中，两者通常结合使用
   - Docker 同时使用 capabilities 和 seccomp 来限制容器权限
