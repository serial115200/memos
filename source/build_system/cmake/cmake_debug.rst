CMake 调试
================================================================================

显示编译日志

cmake .
make VERBOSE=1


cmake -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON .
make

新版本
cd project
cmake -B build/
cmake --build build --verbose

不推荐

set(CMAKE_VERBOSE_MAKEFILE ON)
