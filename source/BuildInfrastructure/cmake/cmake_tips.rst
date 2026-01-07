CMake 临时笔记
================================================================================

https://www.incredibuild.cn/blog/modern-cmake-tips-and-tricks-2

#.  使用现代 CMake

  CMake 3.0 以后的版本，我们称为现代 CMake。如果你还在使用之前的版本，建议进行升级。


#.  设置语言标准

  旧版本向 CMAKE_C_FLAGS 和 CMAKE_CXX_FLAGS 添加 -std=c99 等标记，新方法单独处理。

    .. code-block::

        set(CMAKE_CXX_STANDARD 11)
        set(CMAKE_CXX_STANDARD_REQUIRED True)


#.  避免内部构件

  .. code-block::

      if ( ${CMAKE_SOURCE_DIR} STREQUAL ${CMAKE_BINARY_DIR} )
          message( FATAL_ERROR “In-source builds not allowed! Create a build directory and run CMake from there. ” )
      endif()


#. 使用文档化的选项指定源目录和二进制目录

  .. code-block::

      cmake -S . -B build -G “Visual Studio 16 2019”
      cmake -H. -Bbuild -G “MSYS Makefiles”

  第二条无空格


#. 将 Linter 和 Formatter 集成到 CMake
#. 使用 CMake 将测试集成到构建
#. 使用 TARGET_*()  声明构建标记和依赖关系

  使用 include_directories 并不是过时的做法，或者也可以用target_include_directores
  和 target_link_libraries 替代，强化项目的设计。CMake 拥有 PRIVATE, PUBLIC 和
  INTERFACE 的关键字是有其充分理由的，正确使用这些关键字是保持项目组件单向分层的关键。

#. 清楚何时应该使用宏和函数
#. 使用 CMake 将模块依赖关系可视化

  CMake 支持本机依赖关系的可视化。使用 ZGRViewer 等程序可以很容易地查看输出点文件。

#. 什么时候使用 PRIVATE，PUBLIC  和  INTERFACE

  依赖关系    描述
  PRIVATE     我需要，但是依赖者不需要
  PUBLIC      我和依赖者都需要
  INTERFACE   我不需要，但是依赖者需要

#. FindPackage VS PackageConfig

  Findpackage 是 CMake 或用户提供的搜索脚本，用于查找包文件。现代的包制作方会提供
  <package>Config.cmake. 一旦包已安装，PackageConfig 可以向 CMake 传递其详细信息。

#. 充分利用所有内核加速构建

  在 CMake 构建过程中，可以选择 pass–parallel 标记，进行并行作业。但是，并不是所有的构
  建生成器都可以通过并行加速构建，CMake 3.12 之后的版本才支持并行选项。当使用分布式编译
  来加速 CMake 构建时，例如 Incredibuild，你需要将 –parallel 标记设置成一个非常大的数
  字，例如 300，指示 CMake 执行多达300个并发执行的任务。Incredibuild 可以向远程闲置内
  核分发多达 300 个任务，从而高效加快编译速度。
