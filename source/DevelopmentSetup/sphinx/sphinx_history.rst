Sphinx 探索历史
================================================================================

* 寻找笔记软件

  Markdown 最先出现在我的视野里，但功能过于孱弱，也没统一规范，野蛮生长。随后尝试了
  Asciidoctor 和 Sphinx，功能上大致符合，用了一段时间的 Asciidoctor ，发现配套缺失，
  在看到内核也使用 Sphinx 后，开始了摸索之旅。

* 解决构建环境

  在 Windows 的泥潭里挣扎，环境配置实在是痛点，辛亏 VsCode 横空出世，配合 Remote SSH，
  快速解决了环境问题，具体配置如下：

    * 虚拟机安装 Linux，然后配置环境
    * VsCode 配合安装 Remote SSH，进行文档编辑
    * Python 提供简易 HTTP 服务，在浏览器呈现文档
    * 每次编辑后，手动进行编译，然后刷新网页

* 自动化流程探索

  能偷懒是最好的，开始简化流程

    * 使用 inotify 等机制监控文件实现自动编译
    * 使用 livereload  等浏览器插件实现自动刷新

* 环境迁移和固化

  虚拟机对于环境管理还是不便，此时 docker 技术开始火热，在查阅资料后，发现已经有人用
  docker 固化 sphinx 环境，我开始了环境迁移

* 更多插件的诞生

  VsCode 快速发展，出现了很多插件：

    * Live Server 代替了原先的 livereload，浏览器不在需要插件
    * reStructuredText 及其配套提供了语法高亮和检查服务

  Sphinx 也有很多插件：

    * sphinx-autobuild ： 自动编译工具，代替了 inotify 和 Live Server（集成度更高）
    * sphinx-copybutton ： 代码复制
    * sphinxnotes-strike ： 删除线
    * sphinx-cjkspace ： 中文支持
    * sphinxcontrib-mermaid ： 图片支持
    * sphinxcontrib-kroki ： 图片支持
    * 等等等

  历史的倒车：

    reStructuredText 提供了很多功能，包括自动编译功能，为此我一度放弃了
    sphinx-autobuild，这期间遇上很多问题，比如不完全编译，更新单个文件但没有更新目录，
    即不会处理依赖，无意间再次启用 sphinx-autobuild，上述问题随之消失。还是官方插件好。

* DevContainer 最终方案

  到此方案已经很成熟了，但还是存在痛点，不能全部通过配置文件实现自动化

    * docker 存在权限问题，需要用脚本挂载

    .. literalinclude:: ../docker/docker.bash
        :language: bash

    * 镜像不能及时更新
    * 容器还需要自己管理

  我的痛点也是大家的痛点，DevContainer 是完美的方案

    * VsCode 安装 DevContainer
    * 编写容器配置，打开工作区， VsCode 自动构建镜像，启动容器，权限问题一并处理

* 附加方案

  在本地使用很难同步，在最便宜的 VPS 上使用该方案很完美，只需本地安装 VsCode
