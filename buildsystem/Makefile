
IDAS = release-edxapp release-registrar
.PHONY: all build-% push-% clean clean-%

all: $(IDAS)

release-%: build-%
	cd contexts/$* && $(MAKE) push

build-%: contexts/%
	cd contexts/$* && $(MAKE) build

contexts: $(wildcard contexts/*)

contexts/%: %
	mkdir -p contexts/$*
	cp $*/* contexts/$*/
	if [ ! -f $*/Makefile ]; then \
		cp Makefile.default contexts/$*/Makefile; \
	fi
	if [ ! -f $*/Dockerfile ]; then \
		cp Dockerfile.default contexts/$*/Dockerfile; \
	fi

clean:
	rm -rf contexts

clean-%:
	rm -rf contexts/$*

