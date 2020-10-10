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
/usr/local/cuda/bin/cuda-uninstaller
# uninstall previously installed NVIDIA GPU Driver
/usr/bin/nvidia-uninstall

NVIDIA_CUDA_RUNFILE=$1
$NVIDIA_CUDA_RUNFILE


