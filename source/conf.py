# Configuration file for the Sphinx documentation builder.
#
# For the full list of built-in configuration values, see the documentation:
# https://www.sphinx-doc.org/en/master/usage/configuration.html

# -- Project information -----------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#project-information

project = '备忘录'
copyright = '2024, Pan Chen'
author = 'Pan Chen'

# -- General configuration ---------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#general-configuration

extensions = [
    'sphinx_rtd_theme',
    #'sphinx_book_theme',

    'sphinx_copybutton',
    #'sphinx_tabs.tabs',
    #'sphinx_inline_tabs',
    #'sphinxcontrib.github',
    'sphinx-prompt',
    'sphinx_cjkspace.cjkspace',

    #'sphinx.ext.autosectionlabel',
    #'sphinx.ext.duration',
    #'sphinx.ext.extlinks',
    #'sphinx.ext.githubpages',
    #'sphinx.ext.graphviz',
    #'sphinx.ext.mathjax',
    #'sphinx.ext.todo',
]

templates_path = ['_templates']
exclude_patterns = []

language = 'zh_CN'

# -- Options for HTML output -------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#options-for-html-output

#html_theme = 'alabaster'
html_theme = "sphinx_rtd_theme"
html_static_path = ['_static']

copybutton_prompt_text = "~$ "
