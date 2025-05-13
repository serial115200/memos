CMake 笔记
================================================================================

.. toctree::
    :maxdepth: 1

    cmake_tips
    cmake_debug

现代 Cmake



教程杂项：

   * `cmake-examples <https://github.com/ttroy50/cmake-examples>`_
   * `awesome-cmake <https://github.com/onqtam/awesome-cmake>`_
   * `learning-cmake <https://github.com/Akagi201/learning-cmake>`_

问答记录

* https://stackoverflow.com/questions/2152077/is-it-possible-to-get-cmake-to-build-both-a-static-and-shared-library-at-the-sam
* https://aiden-dong.github.io/2019/07/20/CMake%E6%95%99%E7%A8%8B%E4%B9%8BCMake%E4%BB%8E%E5%85%A5%E9%97%A8%E5%88%B0%E5%BA%94%E7%94%A8/


$ mkdir -p build
$ cd build
$ cmake ..

跨平台

cmake -H. -Bbuild


cmake -H 和 cmake -S 是 CMake 中用于指定项目源文件路径的选项，但它们的用法和含义有所不同：

-H 选项：

-H 用于指定 CMakeLists.txt 文件的路径。
语法：cmake -H<path>，其中 <path> 是包含 CMakeLists.txt 的目录。
示例：cmake -H. -Bbuild 表示在当前目录中查找 CMakeLists.txt。
-S 选项：

-S 也是用于指定源目录，但它是 CMake 3.13 及更高版本引入的。
语法：cmake -S <path>，同样 <path> 是包含 CMakeLists.txt 的目录。
示例：cmake -S . -B build 也表示在当前目录中查找 CMakeLists.txt。
总结：
-H 是较旧的语法，主要用于指定源文件路径。
-S 是新语法，提供了更清晰的命令行参数格式，推荐在新项目中使用。
在实际使用中，-S 更加直观和现代化。
