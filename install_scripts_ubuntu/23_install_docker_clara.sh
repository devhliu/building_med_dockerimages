#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
#
# install gate on docker
#
#-----------------------------------------------------------------------------------------------------------------------

docker pull opengatecollaboration/gate:8.2

# run the gate docker
docker run -it opengatecollaboration/gate:8.2