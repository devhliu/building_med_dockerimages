#!/bin/bash

if [ "$#" -lt 1 ];then
	echo "Usage: $0 <install folder (absolute path)>"
	echo "For sudoer recommend: $0 /opt"
	echo "For normal user recommend: $0 $HOME/app"
	exit 0
fi

echo -n "installing FreeSurfer-6.0..." #-n without newline

DEST=$1
mkdir -p $DEST

FREESURFER6_DIR=$DEST/freesurfer
if [ -d $FREESURFER6_DIR ]; then
	rm -rf $FREESURFER6_DIR
fi

cd $HOME
mkdir temp
cd temp

# install dependencies
apt-get update && apt-get -y install bc binutils libgomp1 perl psmisc sudo tar tcsh unzip uuid-dev vim-common libjpeg62-dev

wget https://surfer.nmr.mgh.harvard.edu/pub/dist/freesurfer/6.0.0/freesurfer-Linux-centos6_x86_64-stable-pub-v6.0.0.tar.gz
tar -xzvf freesurfer-Linux-centos6_x86_64-stable-pub-v6.0.0.tar.gz
rm freesurfer-Linux-centos6_x86_64-stable-pub-v6.0.0.tar.gz

# get PROFILE
if [ -e $HOME/.profile ]; then #ubuntu
	PROFILE=$HOME/.profile
elif [ -e $HOME/.bash_profile ]; then #centos
	PROFILE=$HOME/.bash_profile
else
	echo "Add PATH manualy: PATH=$FREESURFER6_DIR"
	exit 0
fi

# add freesurfer-6.0 into PROFILE
if grep -xq "export FREESURFER_HOME=$FREESURFER6_DIR" $PROFILE #return 0 if exist
then
	echo "FREESURFER_HOME=$FREESURFER6_DIR" in the FREESURFER_HOME already.
else
	echo "" >> $PROFILE
	echo "# freesurfer-6.0" >> $PROFILE
	echo "FREESURFER6_DIR=$FREESURFER6_DIR" >> $PROFILE
	echo "export FREESURFER_HOME=$FREESURFER6_DIR" >> $PROFILE
	echo "source $FREESURFER_HOME/SetUpFreeSurfer.sh" >> $PROFILE
fi