# Helpful debug flags
MAKEFLAGS += --warn-undefined-variables
# (optional) see every command even if prefixed with @
# MAKEFLAGS += --trace

# Handy debug target: `make print-BASEDIR` etc.
print-%:
	@echo '$*=$($*)'

PACKAGES := db4 openssl
BASEDIR ?= $(CURDIR)
HOST ?= x86_64-linux-gnu

# include package definitions
$(foreach pkg,$(PACKAGES),$(eval include $(BASEDIR)/packages/$(pkg)/$(pkg).mk))

# generic rules
#$(BASEDIR)/packages/%/.stamp_built:
#	@echo "=== Building $* ==="
#	$(MAKE) -C $(BASEDIR)/packages/$* $(*)_download
#	$(MAKE) -C $(BASEDIR)/packages/$* $(*)_extract
#	$(MAKE) -C $(BASEDIR)/packages/$* $(*)_configure
#	$(MAKE) -C $(BASEDIR)/packages/$* $(*)_build
#	$(MAKE) -C $(BASEDIR)/packages/$* $(*)_stage
#	@touch $@

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
	@echo "=== DONE: $* ==="

# final completion marker
$(BASEDIR)/work/build-$(HOST)/.stamp_built: \
	$(PACKAGES:%=$(BASEDIR)/packages/%/.stamp_built)
	@echo "=== ALL DEPENDENCIES BUILT ==="
	@mkdir -p $(dir $@)
	@touch $@
