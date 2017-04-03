export LANGUAGE=en_US:en
export LC_ALL=en_US.UTF-8
sudo locale-gen en_US.UTF-8
echo 'dependency installation started'
sudo apt-get update
sudo apt-get -y install libexpat1 libexpat1-dev libyaml-0-2 libyaml-dev erlang openssl zlib1g zlib1g-dev libssl-dev libpam0g
sudo apt-get -y install automake
sudo apt-get -y install make
sudo apt-get -y install gcc
sudo apt-get -y install g++
echo 'dependency installation done'
echo 'installation done'
