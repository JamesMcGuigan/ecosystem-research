# Juypter

## Install

## Notes

List of available jupyter kernels
- https://github.com/jupyter/jupyter/wiki/Jupyter-kernels

#### Juypter
Install
```bash
cd juypter
./install.sh
jupyter notebook --generate-config
```
Run
```bash
source venv/bin/activate
juypter lab
```


#### iJava
- https://github.com/SpencerPark/IJava
```bash
# Install Java 11
sudo apt update && apt upgrade
sudo apt install software-properties-common
sudo add-apt-repository ppa:linuxuprising/java
sudo apt update

# Install Gradle
sudo apt install gradle
```

# Install SBT - https://stackoverflow.com/questions/35529913/how-to-install-sbt-on-ubuntu-debian-with-apt-get
```bash
cd install
wget http://dl.bintray.com/sbt/debian/sbt-1.2.6.deb 
sudo dpkg -i sbt-1.2.6.deb 
```


# Haskel - https://github.com/gibiansky/IHaskell
```bash
sudo apt-get install -y python3-pip git libtinfo-dev libzmq3-dev libcairo2-dev libpango1.0-dev libmagic-dev libblas-dev liblapack-dev
```