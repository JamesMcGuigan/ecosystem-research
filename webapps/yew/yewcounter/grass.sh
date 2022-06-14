#!/usr/bin/env bash
cd $(dirname $BASH_SOURCE[0]);  # cd current directory

# BUGFIX: <link data-trunk rel="scss" href="src/counter.scss"/> fails to compile
# WORKAROUND: ./grass.sh is called as a watch/build [hook] in Trunk.toml

if [[ ! `command -v grass` ]]; then
  cargo install grass
fi

# Lazy compile with caching
# Find all .scss + .sass files, newer than .css (or if .css missing), then compile through grass
CSS='{=1 s/\.s[ac]ss$/.css/ =}'
find . -name '*.s[ac]ss' |
  parallel --group "if [ ! -f $CSS ] || [ {1} -nt $CSS ]; then echo 'grass {1} > $CSS'; grass {1} > $CSS; fi;"
