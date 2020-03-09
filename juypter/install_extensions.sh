#!/usr/bin/env bash
set -x

### DOCS: https://github.com/ipython-contrib/jupyter_contrib_nbextensions
### DOCS: https://jupyter-contrib-nbextensions.readthedocs.io/en/latest/

#jupyter contrib nbextension install --system
jupyter contrib nbextension install --user --symlink --debug
jupyter nbextensions_configurator enable --user


### Jupyter Themes
### DOCS: https://towardsdatascience.com/bringing-the-best-out-of-jupyter-notebooks-for-data-science-f0871519ca29
# pip install jupyterthemes

## List of available themes - only works for jupiter notebook, not jupiter lab
jt -l
#Available Themes:
#   chesterish
#   grade3
#   gruvboxd
#   gruvboxl
#   monokai
#   oceans16
#   onedork
#   solarizedd
#   solarizedl
## reverting to original Theme
#jt -r
## selecting a particular theme
jt -t grade3
