#!/bin/sh

IDA_DIR=$1
BUILD_DIR=$2
IDA=$3

SRC_DIR=$IDA_DIR/$IDA/buildcontext
DEST_DIR=$BUILD_DIR/$IDA

mkdir -p $DEST_DIR
cp $SRC_DIR/* $DEST_DIR

if [ ! -f $SRC_DIR/Makefile ]; then \
	cp Makefile.default $DEST_DIR/Makefile; \
fi

if [ ! -f $SRC_DIR/Dockerfile ]; then \
	cp Dockerfile.default $DEST_DIR/Dockerfile; \
fi
