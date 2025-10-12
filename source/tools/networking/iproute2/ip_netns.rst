ip netns 命令
================================================================================

.. todo::

    建议阅读 namespace 章节，理论上放在虚拟化或 linux 技术篇章


网络命名空间增删改查

.. code-block::

    # 查看
    ip netns list

    # 增加
    # ip netns add <NAME>
    ip netns add ns1
    ip netns add ns2
    ip netns add ns3
    ip netns list

    # 删除
    # ip netns delete <NAME>
    # ip -all netns delete
    ip netns delete ns2
    ip netns list
    ip -all netns delete
    ip netns list


网络命名空间中运行命令

.. code-block::

    ip netns add ns1

    # ip netns exec <NAME> <command>
    ip netns exec ns1 bash
    ip netns exec ns1 ip


进程附加到网络命名空间

.. code-block::

ip netns attach <NAME> <PID>


将进程（通过 PID 指定）附加到命名空间。需要进程是单线程的。

---

### 6. 设置命名空间的 NETNSID

.. code-block::

ip netns set <NAME> <NETNSID>


为命名空间设置一个 ID。可以用 `auto` 或整数：

.. code-block::

ip netns set testns 42


---

### 7. 获取进程所属的命名空间

.. code-block::

ip netns identify <PID>


查看指定进程属于哪个命名空间。

---

### 8. 查看命名空间内运行的所有进程

.. code-block::

ip netns pids <NAME>


列出属于该命名空间的所有进程。

---

### 9. 实时监控命名空间事件

.. code-block::

ip netns monitor


监控命名空间创建和删除事件（如监听命名空间变化）。

---

### 10. 使用 NSID 查看命名空间

.. code-block::

ip netns list-id


或带过滤条件：

.. code-block::

ip netns list-id target-nsid 10 nsid 20


这通常用于更复杂的网络虚拟化场景。

---

## 🔁 示例：创建两个命名空间并互通

.. code-block::

# 创建两个命名空间
ip netns add ns1
ip netns add ns2

# 创建 veth 虚拟对
ip link add veth1 type veth peer name veth2

# 分别移动到 ns1 和 ns2
ip link set veth1 netns ns1
ip link set veth2 netns ns2

# 启用接口并设置 IP
ip netns exec ns1 ip addr add 10.0.0.1/24 dev veth1
ip netns exec ns2 ip addr add 10.0.0.2/24 dev veth2
ip netns exec ns1 ip link set veth1 up
ip netns exec ns2 ip link set veth2 up

# 测试连通性
ip netns exec ns1 ping 10.0.0.2


---

## 🧽 清理资源

.. code-block::

ip netns delete ns1
ip netns delete ns2


---

如需我为你生成图示、网络拓扑图、自动化脚本等，请继续告诉我。
