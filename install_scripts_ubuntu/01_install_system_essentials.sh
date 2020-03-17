#!/bin/bash

# determine if mirror is used
USING_MIRROR=True
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
    echo "# end of mirror source from TUNA"
    cp /etc/apt/sources.list /etc/apt/sources.list.tuna
fi

# update system
apt-get update && apt-get upgrade

# intel opencl
#add-apt-repository ppa:intel-opencl/intel-opencl
#apt-get update
#apt-get install intel-opencl-icd
#add-apt-repository --remove ppa:intel-opencl/intel-opencl