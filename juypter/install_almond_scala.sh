#!/usr/bin/env bash
set -x

# Install Almond Scala Kernel
# - http://almond-sh.github.io/almond/stable/docs/quick-start-install
# - https://github.com/coursier/coursier/blob/master/doc/FORMER-README.md
cd $(readlink -f $(dirname $BASH_SOURCE[0]));
cd install/;

curl -L -o coursier https://git.io/vgvpD && chmod +x coursier && ./coursier --help
SCALA_VERSION=2.12.7 ALMOND_VERSION=0.1.11
./coursier bootstrap \
    -i `whoami` -I user:sh.almond:scala-kernel-api_$SCALA_VERSION:$ALMOND_VERSION \
    sh.almond:scala-kernel_$SCALA_VERSION:$ALMOND_VERSION \
    -o almond -f
./almond --install --force
