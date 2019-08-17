#!/bin/sh

for ida in ./idas/*/; do
	for image in ./images/*/; do
		./prep-buildcontext.sh $ida $image
	done
done
