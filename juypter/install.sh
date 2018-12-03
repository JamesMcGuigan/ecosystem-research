#!/usr/bin/env bash
set -x
cd $(readlink -f $(dirname $BASH_SOURCE[0]));

./requirements.sh


# Install iJava
# - https://github.com/SpencerPark/IJava
# - doesn't work with: venv_windows/Scripts/activate
cd $(readlink -f $(dirname $BASH_SOURCE[0]));
source venv/bin/activate
git clone https://github.com/SpencerPark/IJava.git install/IJava
cd install/IJava;
git pull;
chmod u+x gradlew && ./gradlew installKernel
cd $(readlink -f $(dirname $BASH_SOURCE[0]));