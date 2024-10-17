位域
================================================================================


https://publications.gbdirect.co.uk/c_book/chapter6/bitfields.html

FAQ
--------------------------------------------------------------------------------

#.  Bitfield 在结构体中的 bit 顺序

  C standard: The order of allocation of bit-fields within a unit (high-order to
  low-order or low-order to high-order) is implementation-defined.

  因此位操作和位域操作并不等价，如将第 0 个 bit 置 1，对应的位域可能是最后一个符号。这
  也意味着要求比特序的操作不能简单使用位域，如网络传输中的 tcp 结构。

  https://stackoverflow.com/questions/6043483/why-bit-endianness-is-an-issue-in-bitfields

#.  Bitfield 和 bit/比特序 完全无法互通吗

  也不是，如实现明确，也可使用，如 gcc 和 Linux 在各种协议定义上经常使用，举例如下：

  .. code-block::

        struct iphdr
          {
        #if __BYTE_ORDER == __LITTLE_ENDIAN
            unsigned int ihl:4;
            unsigned int version:4;
        #elif __BYTE_ORDER == __BIG_ENDIAN
            unsigned int version:4;
            unsigned int ihl:4;
        #else
        # error "Please fix <bits/endian.h>"
        #endif
            u_int8_t tos;
            u_int16_t tot_len;
            u_int16_t id;
            u_int16_t frag_off;
            u_int8_t ttl;
            u_int8_t protocol;
            u_int16_t check;
            u_int32_t saddr;
            u_int32_t daddr;
            /*The options start here. */
          };


#. 何时何地使用 Bitfield

  节约内存，尤其是大量 flag 标记
  改进可读性，替代 bit 的宏操作
  上面提到的 Bitfield 和 bit/比特序 互通，用的好也可以改进协议报文的填充

#.
