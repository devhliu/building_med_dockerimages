#!/bin/bash

# check install path
if [ "$#" -lt 1 ]; then
	echo "Usage: $0 <install folder (absolute path)>"
	echo "For sudoer recommend: $0 /opt"
	echo "For normal user recommend: $0 $HOME/app"
	exit 0
fi

echo -n "installing anaconda3..." #-n without newline

# determine if mirror is used
USING_MIRROR=True

DEST=$1
mkdir -p $DEST

ANACONDA3_DIR=$DEST/anaconda3
if [ -d $ANACONDA3_DIR ]; then
	rm -rf $ANACONDA3_DIR
fi

# install anaconda3
if $USING_MIRROR; then
    REPO_URL=https://mirrors.tuna.tsinghua.edu.cn/anaconda/archive
else
    REPO_URL=https://repo.continuum.io/archive
fi

INST_FILE=Anaconda3-2019.10-Linux-x86_64.sh
#-P: prefix, where there file will be save to
wget -nv -P $ANACONDA3_DIR --tries=10 $REPO_URL/$INST_FILE 
#-b:bacth mode, -f: no error if install prefix already exists
bash $ANACONDA3_DIR/$INST_FILE -b -f -p $ANACONDA3_DIR
rm $ANACONDA3_DIR/$INST_FILE

# using user profile
if [ -e $HOME/.profile ]; then #ubuntu
	PROFILE=$HOME/.profile
elif [ -e $HOME/.bash_profile ]; then #centos
	PROFILE=$HOME/.bash_profile
else
	echo "Add PATH manualy: PATH=$ANACONDA3_DIR/bin"
	exit 0
fi

#check if PATH already exist in $PROFILE
if grep -xq "export PATH=$ANACONDA3_DIR/bin:\$PATH" $PROFILE #return 0 if exist
then 
	echo "PATH=$ANACONDA3_DIR/bin" in the PATH already.
else
	echo "" >> $PROFILE    
	echo "# anaconda3" >> $PROFILE 
	echo "ANACONDA3_DIR=$ANACONDA3_DIR"
	echo "export PATH=$ANACONDA3_DIR/bin:\$PATH" >> $PROFILE
fi

source $PROFILE

# add conda mirror
if $USING_MIRROR; then
	SCRIPT_DIR=dirname $BASH_SOURCE
    cp $SCRIPT_DIR/02_install_anaconda3_mirror.condarc $HOME/.condarc
	python -m pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
fi
conda update --all
conda clean --all

#test installation
echo "test anaconda install: "
conda update conda -y > /dev/null
if [ $? -eq 0 ]; then
	echo 'SUCCESS'
	echo "To update PATH of current terminal: source $PFORFILE"
	echo "To update PATH of all terminal: re-login"
else
    echo 'FAIL.'
fi