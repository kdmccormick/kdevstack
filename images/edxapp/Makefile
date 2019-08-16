
MODSTACK_BUILD_IDA=edxapp
MODSTACK_BUILD_REPO=edx-platform

IDA=$(MODSTACK_BUILD_IDA)
REPO=$(or $(MODSTACK_BUILD_REPO),$(IDA))
BRANCH=$(or $(MODSTACK_BUILD_BRANCH),master)
IMAGE_PREFIX=$(or $(MODSTACK_BUILD_IMAGE_PREFIX), kdmccormick/edx-)
REPO_ROOT=$(or $(MODSTACK_BUILD_REPO_ROOT), https://github.com/edx)
IMAGE=$(IMAGE_PREFIX)$(IDA)

.PHONY: run image pull_master

image: pull_master
	docker build . -t $(IMAGE) \
	               --build-arg IDA=$(IDA) \
	               --build-arg REPO=$(REPO)

run:
	docker run -d $(IMAGE) --name $(IDA)

shell:
	docker exec -it $(IDA) /bin/bash

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

up:
	docker run -d --name $(CONTAINER) $(IMAGE)

shell:
	docker exec -it $(CONTAINER) /bin/bash

down:
	docker stop $(CONTAINER)
	docker rm $(CONTAINER)
