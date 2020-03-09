#!/bin/bash

# install mdt - microstructure diffusion toolbox

# note: the opencl can not be installed onto the wsl / virtual machine on windows 10 system.

SRC_ROOT=$HOME/mdt_src
mkdir $SRC_ROOT

cp ./03_install_mdt_silent.cfg $SRC_ROOT/silent.cfg

# install Intel OpenCL runtime
cd $SRC_ROOT
wget http://registrationcenter-download.intel.com/akdlm/irc_nas/9019/opencl_runtime_16.1.1_x64_ubuntu_6.4.0.25.tgz && \
tar -xvzf opencl_runtime_16.1.1_x64_ubuntu_6.4.0.25.tgz && \
mv silent.cfg opencl_runtime_16.1.1_x64_ubuntu_6.4.0.25 && \
cd opencl_runtime_16.1.1_x64_ubuntu_6.4.0.25 && \
./install.sh --silent silent.cfg --cli-mode