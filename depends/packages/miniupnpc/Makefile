package = miniupnpc
version = 1.6

BASEDIR ?= $(CURDIR)/../..
HOST ?= x86_64-linux-gnu

src_tar = $(BASEDIR)/sources/miniupnpc-$(version).tar.gz
src_dir = $(BASEDIR)/work/build-$(HOST)/miniupnpc-$(version)
stage_dir = $(BASEDIR)/work/stage-$(HOST)
url = https://miniupnp.tuxfamily.org/files/miniupnpc-$(version).tar.gz

$(package)_download:
	@mkdir -p $(BASEDIR)/sources
	@if [ ! -f "$(src_tar)" ]; then wget -O "$(src_tar)" "$(url)"; fi

$(package)_extract: $(package)_download
	@mkdir -p $(BASEDIR)/work/build-$(HOST)
	tar -xf "$(src_tar)" -C "$(BASEDIR)/work/build-$(HOST)"

$(package)_configure: $(package)_extract
	@echo "No configure step required for miniupnpc $(version)"

$(package)_build: $(package)_configure
	$(MAKE) -C "$(src_dir)"

$(package)_stage: $(package)_build
	mkdir -p "$(stage_dir)/lib" "$(stage_dir)/include"
	cp "$(src_dir)/libminiupnpc.a" "$(stage_dir)/lib/"
	cp "$(src_dir)"/*.h "$(stage_dir)/include/"
