#!/bin/bash

# update the ubuntu system

apt-get update
apt-get upgrade
apt update
apt upgrade
apt autoremove

# update the anaconda
#/opt/anaconda3/bin/conda update --all
#/opt/anaconda3/bin/conda clean --all

/opt/anaconda3/bin/conda update -c https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main --all
/opt/anaconda3/bin/conda clean -c https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main --all
/opt/anaconda3/bin/conda clean -c https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main -f

#/opt/anaconda3/bin/pip install -i https://pypi.tuna.tsinghua.edu.cn/simple packages
