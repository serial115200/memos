# Configuration file for the Sphinx documentation builder.
#
# For the full list of built-in configuration values, see the documentation:
# https://www.sphinx-doc.org/en/master/usage/configuration.html

# -- Project information -----------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#project-information

import os
import sys

sys.path.insert(0, os.path.abspath('.'))

project = '个人笔记'
copyright = '2024, Pan Chen'
author = 'Pan Chen'
language = 'zh_CN'

# -- General configuration ---------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#general-configuration

extensions = [
    'sphinx_rtd_theme',
    'sphinx_copybutton',
    'sphinx_cjkspace.cjkspace',
    'sphinx_tags',
    'sphinx.ext.todo',
    'sphinx.ext.duration',
    'sphinx.ext.viewcode',
    'sphinx.ext.graphviz',
]

templates_path = ['_templates']
exclude_patterns = []

# -- Options for HTML output -------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#options-for-html-output

html_theme = "sphinx_rtd_theme"
html_static_path = ['_static']

# 添加构建时间
html_last_updated_fmt = '%Y-%m-%d %H:%M:%S'
html_show_sphinx = True
html_show_copyright = False


from config.sphinx_tags import *
from config.sphinx_ext_todo import *
from config.sphinx_copybutton import *

# https://github.com/numpy/numpydoc/issues/69
#numpydoc_show_class_members = False
#class_members_toctree = False
