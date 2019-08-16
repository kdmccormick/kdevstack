
RELEASE_IDAS = release-edxapp release-discovery release-registrar

.PHONY: all release-% build-% push-% context-% clean-% clean

all: $(RELEASE_IDAS)

release-%: build-%
	cd contexts/$* && $(MAKE) push

build-%: context-%
	cd contexts/$* && $(MAKE) build

context-%:
	mkdir -p contexts/$*
	cp $*/* contexts/$*/
	if [ ! -f $*/Makefile ]; then \
		cp Makefile.default contexts/$*/Makefile; \
	fi
	if [ ! -f $*/Dockerfile ]; then \
		cp Dockerfile.default contexts/$*/Dockerfile; \
	fi

clean-%:
	rm -rf contexts/$*

clean:
	rm -rf contexts

