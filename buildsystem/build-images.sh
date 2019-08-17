#!/bin/sh

PUSH=${1:-nopush}

for ida in ./idas/*/; do
	for image in ./images/*/; do
		./build-image.sh $ida $image $PUSH
	done
done
