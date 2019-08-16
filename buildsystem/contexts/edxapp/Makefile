
include env.mk

IDA=$(MODSTACK_BUILD_IDA)
REPO=$(or $(MODSTACK_BUILD_REPO),$(IDA))
BRANCH=$(or $(MODSTACK_BUILD_BRANCH),master)
IMAGE_PREFIX=$(or $(MODSTACK_BUILD_IMAGE_PREFIX), kdmccormick96/edx-)
REPO_ROOT=$(or $(MODSTACK_BUILD_REPO_ROOT), https://github.com/edx)
IMAGE=$(IMAGE_PREFIX)$(IDA)

.PHONY: build
build: pull_master
	docker build . -t $(IMAGE) \
	               --build-arg IDA=$(IDA) \
	               --build-arg REPO=$(REPO)

.PHONY: push
push:
	docker push $(IMAGE)

.PHONY: pull_master
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


# For testing only

CONTAINER=$(IDA)

.PHONY: up
up:
	docker run -d --name $(CONTAINER) $(IMAGE)

.PHONY: shell
shell:
	docker exec -it $(CONTAINER) /bin/bash

.PHONY: down
down:
	docker stop $(CONTAINER)
	docker rm $(CONTAINER)
