#!/bin/bash

set -e

do_clone() {
	while read line; do
		if [[ "$line" = \#* ]] || [[ -z "$line" ]]; then
			continue
		fi
		echo $line | \
		xargs git clone --single-branch \
	                    --config core.symlinks=true \
	                    --depth=1 \
	                    --branch
	done
}

do_clone < repos.lst
