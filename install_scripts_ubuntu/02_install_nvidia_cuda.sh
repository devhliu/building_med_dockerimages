#!/bin/bash

# verify the system has a CUDA-capable GPU
if lspci | grep -i nvidia; then
  echo "NVIDIA GPU exists."
else
  exit 0
fi

# verify if gcc exists
if gcc --version; then
  echo "GCC ok."
else
  apt-get install linux-headers-$(uname -r)
fi

# install with runfile
if [ "$#" -lt 1 ]; then
	echo "Usage: $0 <install folder (absolute path)> $1 <cuda_runfile>"
	exit 0
fi

# uninstall previously installed CUDA
#/usr/local/cuda/bin/cuda-uninstaller
# uninstall previously installed NVIDIA GPU Driver
#/usr/bin/nvidia-uninstall

NVIDIA_CUDA_RUNFILE=$1
$NVIDIA_CUDA_RUNFILE

# add CUDA into PROFILE
if grep -xq "export PATH=/usr/local/cuda-10.1/bin:\$PATH" $PROFILE #return 0 if exist
then
	echo "PATH=/usr/local/cuda-10.1/bin" in the PATH already.
else
	echo "" >> $PROFILE
	echo "# CUDA" >> $PROFILE
	echo "export PATH=/usr/local/cuda-10.1/bin:\$PATH" >> $PROFILE
	# echo "export LD_LIBRARY_PATH=/usr/local/cuda-10.1/lib64:\$LD_LIBRARY_PATH" >> $PROFILE
fi
if grep -xq "/usr/local/cuda-10.1/lib64" /etc/ld.so.conf
then
  echo "/usr/local/cuda-10.1/lib64" /etc/ld.so.conf
fi
ldconfig


