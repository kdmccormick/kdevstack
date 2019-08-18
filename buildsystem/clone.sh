#!/bin/bash

set -e

do_clone() {
	while read line; do
		if [[ "$line" = \#* ]] || [[ -z "$line" ]]; then
			continue
		fi
		repo_url=$(cut -d' ' -f1 <<<"$line")
		branch=$(cut -d' ' -f2 <<<"$line")
		dest_folder_name=$(cut -d' ' -f3 <<<"$line")
		dest_folder="repos/$dest_folder_name"

		if [[ -d "$dest_folder/.git" ]]; then
			here=$(pwd)
			cd $dest_folder && git pull
			cd $here
		else
			git clone --single-branch \
			          --config core.symlinks=true \
			          --depth=1 \
			          --branch $branch \
			          $repo_url \
			          $dest_folder
		fi
	done
}

mkdir -p repos
do_clone < repos.lst
