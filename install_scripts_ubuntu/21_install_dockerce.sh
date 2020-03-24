#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
#
# install docker-ce and docker-compose
#
#-----------------------------------------------------------------------------------------------------------------------
# remove old
apt-get remove docker docker-engine docker.io containerd runc
apt-get purge docker-ce
rm -rf /var/lib/docker

#  install dependencies
apt-get update
apt-get install apt-transport-https  ca-certificates curl gnupg-agent software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
apt-key fingerprint 0EBFCD88

add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt-get update
apt-get install docker-ce docker-ce-cli containerd.io

# install docker compose

VERSION=1.25.4
curl -L https://github.com/docker/compose/releases/download/$VERSION/docker-compose-`uname -s`-`uname -m` \
     -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

#-----------------------------------------------------------------------------------------------------------------------
#
# install nvidia-docker
#
#-----------------------------------------------------------------------------------------------------------------------
# add the package repositories
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list
apt-get update && sudo apt-get install -y nvidia-container-toolkit
# to run docker without sudo
sudo usermod -a -G docker ubuntu # and then log out and back in
systemctl restart docker