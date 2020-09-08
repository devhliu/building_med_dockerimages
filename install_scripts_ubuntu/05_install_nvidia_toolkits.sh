#!/bin/bash

#------------------ install NVIDIA driver and CUDA ----------------------------#
# nvidia driver and cuda installation reference documentation:
# https://docs.nvidia.com/cuda/cuda-installation-guide-linux/index.html

# verify you have a CUDA-capable GPU
lspci | grep -i nvidia
# verify you have a supported version of linux
uname -m && cat /etc/*release

#.................. install using package manager .............................#

#.................. install using run file ....................................#

# 1. disable the nouveau
sudo vi /etc/modprobe.d/blacklist-nouveau.conf
# put following contents in to conf.
# blacklist nouveau
# options nouveau modeset=0
sudo update-initramfs -u

wget http://developer.download.nvidia.com/compute/cuda/10.1/Prod/local_installers/cuda_10.1.243_418.87.00_linux.run
sudo sh cuda_10.1.243_418.87.00_linux.run

# setup environment
export PATH=/usr/local/cuda-11.0/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/cuda-11.0/lib64:$LD_LIBRARY_PATH

#------------------ install cuDNN ---------------------------------------------#
# install documentation:
# https://docs.nvidia.com/deeplearning/cudnn/install-guide/index.html
# register and manual the cuDNN runtime library
sudo dpkg -i libcudnn7_7.6.5.32-1+cuda10.1_amd64.deb



