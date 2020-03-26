#/home/user/.profile

# add for 3rd parties applications

# anaconda3
export ANACONDA3="/opt/anaconda3/bin"
export PATH="$ANACONDA3:$PATH"

# cuda 10.1
export CUDA_HOME="/usr/local/cuda-10.1"
export LD_LIBRARY_PATH="$CUDA_HOME/lib64:$LD_LIBRARY_PATH"
export PATH="$CUDA_HOME/bin:$PATH"

# mrtrix3
export MRTRIX3="/opt/mrtrix3/bin"
export PATH="$MRTRIX3:$PATH"

# fsl
export FSLDIR="/usr/local/fsl"
export PATH="$FSLDIR/bin:$PATH"

