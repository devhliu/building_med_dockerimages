#!/bin/bash

# determine if mirror is used
USING_MIRROR=true
# mirror only used in mainland China
if $USING_MIRROR; then
    if [ ! -f /etc/apt/sources.list.ubuntu ]; then
        cp /etc/apt/sources.list /etc/apt/sources.list.ubuntu
    fi
    echo "# only used in mainland China" > /etc/apt/sources.list
    echo "# mirror source from TUNA" > /etc/apt/sources.list
    echo "deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic main restricted universe multiverse" | tee -a /etc/apt/sources.list
    echo "deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-updates main restricted universe multiverse" | tee -a /etc/apt/sources.list
    echo "deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-backports main restricted universe multiverse" | tee -a /etc/apt/sources.list
    echo "deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-security main restricted universe multiverse" | tee -a /etc/apt/sources.list
    echo "# end of mirror source from TUNA" > /etc/apt/sources.list
    cp /etc/apt/sources.list /etc/apt/sources.list.tuna
fi

# update system
apt-get update && apt-get upgrade

# install the dev packages for toolkits compile.
apt-get install linux-headers-$(uname -r)
apt install build-essential

# intel opencl
#add-apt-repository ppa:intel-opencl/intel-opencl
#apt-get update
#apt-get install intel-opencl-icd
#add-apt-repository --remove ppa:intel-opencl/intel-opencl

# install Node.js LTS (v14.x)
curl -sL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
apt-get install -y nodejs
npm install -g configurable-http-proxy

# https://ip-address:9090
apt-get install cockpit cockpit-docker
systemctl start cockpit.socket
systemctl enable cockpit.socket

# https://ip-address:10000
apt --fix-broken install
apt-get install libnet-ssleay-perl libauthen-pam-perl libio-pty-perl unzip
wget http://prdownloads.sourceforge.net/webadmin/webmin_1.962_all.deb
dpkg --install webmin_1.962_all.deb

# install juypterhub
pip install jupyterhub
jupyterhub

sudo adduser hliu
sudo usermod -aG sudo hliu
