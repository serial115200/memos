提交规范
================================================================================


https://www.conventionalcommits.org/zh-hans/v1.0.0/
https://medium.com/neudesic-innovation/conventional-commits-a-better-way-78d6785c2e08
https://www.ruanyifeng.com/blog/2016/01/commit_message_change_log.html
https://yanhaijing.com/git/2016/02/17/my-commit-message/


整体格式
--------------------------------------------------------------------------------

.. code-block::

    <Header>

    <Body>

    <Footer>

Header
--------------------------------------------------------------------------------

Header 部分只有一行，包括俩个字段：type（必需）和subject（必需）。

.. code-block::

    <type>: <subject>

type
type用于说明 commit 的类别，可以使用如下类别：

* feat ： 新功能（feature）
* fix ： 修补bug
* doc ： 文档（documentation）
* style ： 格式（不影响代码运行的变动）
* refactor ： 重构（即不是新增功能，也不是修改bug的代码变动）
* test ：增加测试
* chore ：构建过程或辅助工具的变动

subject
subject是 commit 目的的简短描述。

以动词开头，使用第一人称现在时，比如change，而不是changed或changes
第一个字母小写
结尾不加句号（。）


Body
Body 部分是对本次 commit 的详细描述，可以分成多行。下面是一个范例。

.. code-block::

    More detailed explanatory text, if necessary.  Wrap it to
    about 72 characters or so.

    Further paragraphs come after blank lines.

    - Bullet points are okay, too
    - Use a hanging indent


Footer
Footer 部分只用于两种情况：

    关联 Issue
    关闭 Issue

关联 Issue
本次提交如果和摸个issue有关系则需要写上这个，格式如下：

.. code-block::

    Issue #1, #2, #3

关闭 Issue
如果当前提交信息解决了某个issue，那么可以在 Footer 部分关闭这个 issue，关闭的格式如下：

.. code-block::

    Close #1, #2, #3
