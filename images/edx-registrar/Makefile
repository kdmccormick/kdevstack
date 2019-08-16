
MODSTACK_BUILD_IDA=registrar

IDA=$(MODSTACK_BUILD_IDA)
REPO=$(or $(MODSTACK_BUILD_REPO),$(IDA))
BRANCH=$(or $(MODSTACK_BUILD_BRANCH),master)
IMG_PREFIX=$(or $(MODSTACK_BUILD_IMAGE_PREFIX), kdmccormick/edx-)
REPO_ROOT=$(or $(MODSTACK_BUILD_REPO_ROOT), https://github.com/edx)

.PHONY: image pull_master

image: pull_master
	docker build . -t $(IMG_PREFIX)$(IDA) \
	               --build-arg IDA=$(IDA)

pull_master: repo/
	cd repo/$(REPO) && git pull

repo/:
	rm -rf repo
	mkdir repo
	cd repo && \
	git clone --single-branch \
	          --branch $(BRANCH) \
	          --config core.symlinks=true \
	          --depth=1 \
	          $(REPO_ROOT)/$(REPO).git
