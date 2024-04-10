alias
================================================================================


技巧
--------------------------------------------------------------------------------

#. sudo 不能调用 alias 命令

.. code-block::

    alias sudo='sudo '

Bash only checks the first word of a command for an alias, any words after
that are not checked. That means in a command like sudo ll, only the first
word (sudo) is checked by bash for an alias, ll is ignored. We can tell bash
to check the next word after the alias (i.e sudo) by adding a space to the
end of the alias value.

https://www.gnu.org/savannah-checkouts/gnu/bash/manual/bash.html#Aliases
https://askubuntu.com/questions/22037/aliases-not-available-when-using-sudo
