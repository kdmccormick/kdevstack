#!/bin/sh

for ida in ./idas/*/; do
	rm -rf build/
	for image in ./images/*/; do
		rm -rf build/
	done
done
