#!/usr/bin/env bash
set +x

### Install iHaskel
cd $(readlink -f $(dirname $BASH_SOURCE[0]));
cd install/;

curl -sSL https://get.haskellstack.org/ | sh
git clone https://github.com/gibiansky/IHaskell
cd IHaskell

PATH="$PATH:/home/$USER/.local/bin"
for VENV in ../../venv/bin/activate ../../venv_windows/Scripts/activate; do
    source $VENV;
    pip3 install -r requirements.txt
    stack install gtk2hs-buildtools
    stack install --fast
    ihaskell install --stack
done