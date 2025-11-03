include $(BASEDIR)/deps.mk

$(BASEDIR)/work/build-$(HOST)/.stamp_installed:
	$(MAKE) -C $(BASEDIR)/work/build-$(HOST)
	@touch $@
