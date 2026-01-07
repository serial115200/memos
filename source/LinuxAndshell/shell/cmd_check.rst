命令检测
================================================================================

https://stackoverflow.com/questions/592620/how-can-i-check-if-a-program-exists-from-a-bash-script
https://unix.stackexchange.com/questions/404146/what-is-the-best-method-to-test-if-a-program-exists-for-a-shell-script


POSIX compatible:

.. code-block::

    command -v <the_command>


Example use:

.. code-block::

    if ! command -v <the_command> &> /dev/null
    then
        echo "<the_command> could not be found"
        exit 1
    fi


For Bash specific environments:

.. code-block::

    hash <the_command> # For regular commands. Or...
    type <the_command> # To check built-ins and keywords


.. code-block::

    command -v foo >/dev/null 2>&1 || { echo >&2 "I require foo but it's not installed.  Aborting."; exit 1; }
    type    -v foo >/dev/null 2>&1 || { echo >&2 "I require foo but it's not installed.  Aborting."; exit 1; }
    hash    -v foo >/dev/null 2>&1 || { echo >&2 "I require foo but it's not installed.  Aborting."; exit 1; }
