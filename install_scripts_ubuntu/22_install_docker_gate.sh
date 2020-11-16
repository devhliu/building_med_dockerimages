#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
#
# install clara on docker
#
#-----------------------------------------------------------------------------------------------------------------------

# install clara-train-sdk
export claratrainsdk=nvcr.io/nvidia/clara-train-sdk:v3.0
docker pull $claratrainsdk

docker run -it --rm --gpus all --shm-size=1G --ulimit memlock=-1 --ulimit stack=67108864 -v /home/hliu/workspace/clara/experiments:/workspace/clara-experiments $claratrainsdk /bin/bash

# download models
ngc registry model list nvidia/med/*

MODEL_NAME=clara_train_deepgrow_aiaa_inference_only
VERSION=1
ngc registry model download-version nvidia/med/$MODEL_NAME:$VERSION --dest /workspace/clara-experiments/nv-models