
Wi-Fi 笔记
================================================================================

.. toctree::
    :maxdepth: 1

    mac80211_hwsim

    hostapd
    hostapd_conf/hostapd_conf


.. code-block::

    PSK(Pre-Shared Key)
    PMK(Pairwise Master Key)
    PTK(Pairwise Transit Key)
    GTK(Group Temporal Key)
    GMK(Group Master Key)
    ANONCE
    SNONCE
    MIC

.. code-block::

    +------+------+-------+
    | 11n  | 11ac | 11ax  |
    +======+======+=======+
    | - 20 | - 20 | - 20  |
    |      | - 40 | - 40  |
    |      | - 80 | - 80  |
    |      |      | - 160 |
    +------+------+-------+


+------+------+-------+
| 11n  | 11ac | 11ax  |
+======+======+=======+
| - 20 | - 20 |  20 | |
|      | - 40 |  40 | |
|      | - 80 |  80 | |
|      |      |  160 ||
+------+------+-------+


+------------------------+------------+----------+----------+
| Header row, column 1   | Header 2   | Header 3 | Header 4 |
| (header rows optional) |            |          |          |
+========================+============+==========+==========+
| body row 1, column 1   | column 2   | column 3 | column 4 |
+------------------------+------------+----------+----------+
| body row 2             | Cells may span columns.          |
+------------------------+------------+---------------------+
| body row 3             | Cells may  | - Table cells       |
+------------------------+ span rows. | - contain           |
| body row 4             |            | - body elements.    |
+------------------------+------------+---------------------+


.. list-table:: 多行单元格示例
   :header-rows: 1
   :widths: 30 70

   * - 字段
     - 描述
   * - 客户ID
     - | 用户的唯一标识符
       | 格式：数字+字母组合
   * - 订单号
     - | 订单的唯一标识符
       | 示例：A123456
