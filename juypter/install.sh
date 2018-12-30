#!/usr/bin/env bash
set -x
cd $(readlink -f $(dirname $BASH_SOURCE[0]));

./requirements.sh
./install_ijava.sh
./install_almond_scala.sh
#./install_ihaskell.sh