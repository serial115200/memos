IPv4 Header Structure
=====================

ASCII Diagram::

  0                   1                   2                   3
  0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
 +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
 |Version|  IHL  |Type of Service|          Total Length         |
 +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
 |         Identification        |Flags|      Fragment Offset    |
 +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
 |  Time to Live |    Protocol   |         Header Checksum       |
 +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
 |                       Source Address                          |
 +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
 |                    Destination Address                        |
 +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
 |                    Options                    |    Padding    |
 +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+

Field Descriptions
----------------------------------

- **Version (4 bits)**: IP version number (4 for IPv4)
- **IHL (4 bits)**: Internet Header Length (number of 32-bit words in header)
- **Type of Service (8 bits)**: QoS parameters (precedence, delay, throughput, reliability)
- **Total Length (16 bits)**: Total packet length (header + data) in bytes
- **Identification (16 bits)**: Unique ID for packet fragmentation/reassembly
- **Flags (3 bits)**: Control flags (reserved, DF, MF)
- **Fragment Offset (13 bits)**: Position of fragment in original packet
- **Time to Live (8 bits)**: Packet lifetime (hops countdown)
- **Protocol (8 bits)**: Upper layer protocol (TCP=6, UDP=17, etc.)
- **Header Checksum (16 bits)**: Error checking for header only
- **Source Address (32 bits)**: Sender's IP address
- **Destination Address (32 bits)**: Recipient's IP address
- **Options (variable)**: Optional fields (security, routing, etc.)
- **Padding (variable)**: Zero padding to ensure header ends on 32-bit boundary

Notes
-----
- Minimum header length is 20 bytes (without options)
- Maximum header length is 60 bytes (with options)
- All multi-byte fields are transmitted in network byte order (big-endian)
