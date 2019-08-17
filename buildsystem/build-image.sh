!/bin/sh

IDA=$1
IMAGE=$2
PUSH=${3:-nopush}

IDA_PATH=idas/$IDA
IMAGE_PATH=$IDA_PATH/$IMAGE_PATH

. ./buildsystem.env
. $IDA_PATH/ida.env
. $IMAGE_PATH/image.env

cd $IMAGE_PATH
make build
if [ "$push" == "push" ]; then
	make push
fi
