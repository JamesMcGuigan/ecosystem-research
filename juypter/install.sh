#!/usr/bin/env bash
set -x
cd $(readlink -f $(dirname $BASH_SOURCE[0]));

./requirements.sh
./install_extensions.sh
./install_ijavascript.sh
./install_almond_
scala.sh
#./install_ijava.sh
#./install_ihaskell.sh