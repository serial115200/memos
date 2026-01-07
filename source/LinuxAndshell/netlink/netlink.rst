Netlink 解析
================================================================================

Netlink 协议格式文档
--------------------------------------------------------------------------------

基本结构
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Netlink 消息由消息头和消息体组成::

  struct nlmsghdr {
      __u32 nlmsg_len;    /* Length of message including header */
      __u16 nlmsg_type;   /* Message content */
      __u16 nlmsg_flags;  /* Additional flags */
      __u32 nlmsg_seq;    /* Sequence number */
      __u32 nlmsg_pid;    /* Sending process port ID */
  };

消息头 (nlmsghdr)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

- **nlmsg_len**: 整个消息长度，包括头部
- **nlmsg_type**: 消息类型 (如: NLMSG_NOOP, NLMSG_ERROR, NLMSG_DONE)
- **nlmsg_flags**: 控制标志 (如: NLM_F_REQUEST, NLM_F_MULTI)
- **nlmsg_seq**: 序列号用于追踪消息
- **nlmsg_pid**: 发送进程的端口ID

属性格式 (nlattr)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

消息体通常包含多个属性::

  struct nlattr {
      __u16 nla_len;      /* Length of attribute including header */
      __u16 nla_type;     /* Type of attribute */
      /* Attribute payload follows */
  };

消息类型
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

常见消息类型:

- **RTM_NEWLINK**: 创建/修改网络接口
- **RTM_DELLINK**: 删除网络接口
- **RTM_GETLINK**: 查询网络接口
- **RTM_NEWADDR**: 添加IP地址
- **RTM_DELADDR**: 删除IP地址

协议家族
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

- **NETLINK_ROUTE**: 网络路由和接口
- **NETLINK_FIREWALL**: 防火墙相关
- **NETLINK_NFLOG**: Netfilter日志
- **NETLINK_GENERIC**: 通用协议

错误处理
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

错误消息格式::

  struct nlmsgerr {
      int error;         /* Negative errno or 0 for acknowledgements */
      struct nlmsghdr msg; /* Original message header */
  };

示例消息
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

获取网络接口列表的请求示例::

  struct {
      struct nlmsghdr nh;
      struct ifinfomsg ifi;
  } req = {
      .nh = {
          .nlmsg_len = NLMSG_LENGTH(sizeof(struct ifinfomsg)),
          .nlmsg_type = RTM_GETLINK,
          .nlmsg_flags = NLM_F_REQUEST | NLM_F_DUMP,
          .nlmsg_seq = 1,
      },
      .ifi = {
          .ifi_family = AF_PACKET,
      },
