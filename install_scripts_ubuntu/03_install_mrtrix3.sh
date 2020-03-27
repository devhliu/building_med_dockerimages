#!/bin/bash

if [ "$#" -lt 1 ];then
	echo "Usage: $0 <install folder (absolute path)>"
	echo "For sudoer recommend: $0 /opt"
	echo "For normal user recommend: $0 $HOME/app"
	exit 0
fi

echo -n "installing Matrix3..." #-n without newline

DEST=$1
mkdir -p $DEST

MRTRIX3_DIR=$DEST/mrtrix3
if [ -d $MRTRIX3_DIR ]; then
	rm -rf $MRTRIX3_DIR
fi

# install dependencies
apt-get update && apt-get install -y libeigen3-dev zlib1g-dev libqt4-opengl-dev libgl1-mesa-dev libfftw3-dev libtiff5-dev

cd $HOME
mkdir temp
cd temp

VERSION=3.0_RC3_latest
wget https://github.com/MRtrix3/mrtrix3/archive/$VERSION.tar.gz; tar -xvzf $VERSION.tar.gz; rm $VERSION.tar.gz
cd mrtrix3-$VERSION
./configure
./build

# move all executive and library fiels into mrtrix3
mdkir $MRTRIX3_DIR
mv $HOME/temp/mrtrix3-$VERSION/bin $MRTRIX3_DIR
mv $HOME/temp/mrtrix3-$VERSION/lib $MRTRIX3_DIR
mv $HOME/temp/mrtrix3-$VERSION/share $MRTRIX3_DIR
mv $HOME/temp/mrtrix3-$VERSION/matlab $MRTRIX3_DIR

cd $HOME
rm -rf $HOME/temp/mrtrix3-$VERSION

# get PROFILE
if [ -e $HOME/.profile ]; then #ubuntu
	PROFILE=$HOME/.profile
elif [ -e $HOME/.bash_profile ]; then #centos
	PROFILE=$HOME/.bash_profile
else
	echo "Add PATH manualy: PATH=$MRTRIX3_DIR/bin"
	exit 0
fi

# add mrtrix3 into PROFILE
if grep -xq "export PATH=$MRTRIX3_DIR/bin:\$PATH" $PROFILE #return 0 if exist
then 
	echo "PATH=$MRTRIX3_DIR/bin" in the PATH already.
else
	echo "" >> $PROFILE    
	echo "# mrtrix3" >> $PROFILE
	echo "MRTRIX3_DIR=$MRTRIX3_DIR" 
	echo "export PATH=$MRTRIX3_DIR/bin:\$PATH" >> $PROFILE    
fi