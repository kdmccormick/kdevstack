
BRANCH=$(or $(OPENEDX_GIT_BRANCH),master)

.PHONY: image pull_master

image: pull_master
	docker build . -t kdmccormick/edx-edxapp

pull_master: edx-platform/
	cd edx-platform && git pull

edx-platform/:
	git clone --single-branch \
	          --branch $(BRANCH) \
	          --config core.symlinks=true \
	          --depth=1 \
	          https://github.com/edx/edx-platform.git
