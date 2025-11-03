PACKAGES := db4 openssl boost miniupnpc
BASEDIR ?= $(CURDIR)
HOST ?= x86_64-linux-gnu

# include package vars (harmless if they don't define any)
$(foreach pkg,$(PACKAGES),$(eval include $(BASEDIR)/packages/$(pkg)/Makefile))

$(BASEDIR)/packages/%/.stamp_built:
	@echo "=== BUILDING PACKAGE: $* ==="
	$(MAKE) -C $(BASEDIR)/packages/$* $*_download
	@echo "--- $*: extract ---"
	$(MAKE) -C $(BASEDIR)/packages/$* $*_extract
	@echo "--- $*: configure ---"
	$(MAKE) -C $(BASEDIR)/packages/$* $*_configure
	@echo "--- $*: build ---"
	$(MAKE) -C $(BASEDIR)/packages/$* $*_build
	@echo "--- $*: stage ---"
	$(MAKE) -C $(BASEDIR)/packages/$* $*_stage
	@touch $@

$(BASEDIR)/work/build-$(HOST)/.stamp_built: \
	$(PACKAGES:%=$(BASEDIR)/packages/%/.stamp_built)
	@echo "=== ALL DEPENDENCIES BUILT ==="
	@mkdir -p $(dir $@)
	@touch $@
