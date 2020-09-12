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
systemctl start docker && systemctl enable docker

# install docker compose

VERSION=1.27.0
curl -L https://github.com/docker/compose/releases/download/$VERSION/docker-compose-`uname -s`-`uname -m` \
     -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

#-----------------------------------------------------------------------------------------------------------------------
#
# install nvidia-docker
#
#-----------------------------------------------------------------------------------------------------------------------
# remove of old nvidia-docker
docker volume ls -q -f driver=nvidia-docker | xargs -r -I{} -n1 docker ps -q -a -f volume={} | xargs -r docker rm -f
apt-get purge nvidia-docker

# add the package repositories
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list
apt-get update
apt-get install -y nvidia-container-toolkit
apt-get update
apt-get install -y nvidia-docker2
systemctl restart docker

# to run docker without sudo
groupadd docker
usermod -a -G docker $USER # and then log out and back in
systemctl restart docker
chown "$USER":"$USER" /home/"$USER"/.docker -R
chmod g+rwx "$HOME/.docker" -R