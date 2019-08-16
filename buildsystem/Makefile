
RELEASE_IDAS = release-edxapp release-discovery release-registrar
BUILD_DIR=buildcontexts
IDA_DIR=idas

.PHONY: all release-% build-% push-% context-% clean-% clean

all: $(RELEASE_IDAS)

release-%: build-%
	cd contexts/$* && $(MAKE) push

build-%: context-%
	cd contexts/$* && $(MAKE) build

config-%:
	./generate-buildcontext.sh $(IDA_DIR) $(BUILD_DIR) $*

clean-%:
	rm -rf $(BUILD_DIR)/$*

clean:
	rm -rf $(BUILD_DIR)

