#!/usr/bin/env bash
set -x

# Install iJava
# - https://github.com/SpencerPark/IJava
# - doesn't work with: venv_windows/Scripts/activate
cd $(readlink -f $(dirname $BASH_SOURCE[0]));

git clone https://github.com/SpencerPark/IJava.git install/IJava
cd install/IJava;

git pull;
chmod u+x gradlew

for VENV in ../../venv/bin/activate ../../venv_windows/Scripts/activate; do
    source $VENV;
    ./gradlew installKernel
done;
