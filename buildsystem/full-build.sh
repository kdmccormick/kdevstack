#!/bin/sh

./load-idas.sh
./prep-buildcontexts.sh
./build-images.sh push
