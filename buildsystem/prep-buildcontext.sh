#!/bin/sh

IDA=$1
IMAGE=$2

IDA_PATH=idas/$IDA
IMAGE_PATH=$IDA_PATH/$IMAGE_PATH

. ./buildsystem.env
. $IDA_PATH/ida.env
. $IMAGE_PATH/image.env

BUILDCONTEXT_PATH=$IMAGE_PATH/build
mkdir -p $BUILDCONTEXT_PATH

TYPE=$MODSTACK_BUILD_IMAGE_TYPE
MAKEFILE_SRC=${TYPE}.Makefile.default
DOCKERFILE_SRC=${TYPE}.Dockerfile.default
MAKEFILE_DEST=$IMAGE_PATH/${TYPE}.Makefile
DOCKERFILE_DEST=$BUILDCONTEXT_PATH/${TYPE}.Dockerfile

if [ -f $MAKEFILE_SRC ]; then \
	if [ ! -f $MAKEFILE_DEST ]; then \
		cp $MAKEFILE_SRC $MAKEFILE_DEST
	fi
fi

if [ -f $DOCKERFILE_SRC ]; then \
	if [ ! -f $DOCKERFILE_DEST ]; then \
		cp $DOCKERFILE_SRC $DOCKERFILE_DEST
	fi
fi

cd $IMAGE_PATH
make prep
