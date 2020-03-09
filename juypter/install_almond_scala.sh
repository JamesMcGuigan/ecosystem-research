#!/usr/bin/env bash
set -x
cd $(readlink -f $(dirname $BASH_SOURCE[0]));
mkdir -p install/
cd install/

### Install Scala
### https://www.scala-lang.org/download/
wget -c https://downloads.lightbend.com/scala/2.13.1/scala-2.13.1.deb
sudo apt install ./scala-2.13.1.deb


### DOCS: https://www.scala-sbt.org/release/docs/Installing-sbt-on-Linux.html
echo "deb https://dl.bintray.com/sbt/debian /" | sudo tee -a /etc/apt/sources.list.d/sbt.list
curl -sL "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x2EE0EA64E40A89B84B2DF73499E82A75642AC823" | sudo apt-key add
sudo apt-get update
sudo apt install scala
sudo apt-get install sbt


### Install Almond Scala Kernel
### - https://almond.sh/docs/quick-start-install
### - https://github.com/frgomes/bash-scripts/blob/master/user-install/install-jupyter.sh
### - https://github.com/coursier/coursier/blob/master/doc/FORMER-README.md
### - https://repo1.maven.org/maven2/sh/almond/scala-kernel_2.11.12/
### - https://repo1.maven.org/maven2/sh/almond/scala-kernel_2.13.1/

curl -L -o coursier https://git.io/coursier-cli && chmod +x coursier && ./coursier --help
SCALA_VERSION=2.11.12 ALMOND_VERSION=0.6.0  # Needs compatable versions - based on `scala -version`
SCALA_VERSION=2.13.1  ALMOND_VERSION=0.9.1  # Needs compatable versions - based on `scala -version`

./coursier bootstrap \
    -r jitpack \
    -i user -I user:sh.almond:scala-kernel-api_$SCALA_VERSION:$ALMOND_VERSION \
    sh.almond:scala-kernel_$SCALA_VERSION:$ALMOND_VERSION \
    -o almond -f
./almond --install --force
