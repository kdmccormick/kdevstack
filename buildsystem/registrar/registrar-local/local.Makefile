
IDA=$(MODSTACK_BUILD_IDA)
REPO_NAME=$(MODSTACK_BUILD_REPO_NAME)
BRANCH=$(MODSTACK_BUILD_BRANCH)
IMAGE=$(MOCKSTACK_BUILD_IMAGE)
IMAGE_TAG_PREFIX=$(MODSTACK_BUILD_IMAGE_TAG_PREFIX)
REPO_ROOT=$(MODSTACK_BUILD_REPO_ROOT)

IMAGE_TAG=$(IMAGE_TAG_PREFIX)$(IMAGE)
REPO_PATH=$(BUILDCONTEXT_PATH)/$(REPO_NAME)
BUILDCONTEXT_PATH=./build

.PHONY: build
build: pull_master
	cd $(BUILDCONTEXT_PATH) && \
	docker build . -t $(IMAGE_TAG) \
	               --build-arg IDA=$(IDA) \
	               --build-arg REPO_SRC=$(REPO_NAME)

.PHONY: push
push:
	docker push $(IMAGE_TAG)

.PHONY: pull_master
pull_master: $(REPO_PATH)
	cd $(REPO_PATH) && git pull

$(REPO_PATH):
	rm -rf $(REPO_PATH)
	git clone --single-branch \
	          --branch $(BRANCH) \
	          --config core.symlinks=true \
	          --depth=1 \
	          $(REPO_ROOT)/$(REPO).git \
	          $(REPO_PATH)


# For testing only

CONTAINER=$(IMAGE)

.PHONY: up
up:
	docker run -d --name $(CONTAINER) $(IMAGE_TAG)

.PHONY: shell
shell:
	docker exec -it $(CONTAINER) /bin/bash

.PHONY: down
down:
	docker stop $(CONTAINER)
	docker rm $(CONTAINER)
