package = boost
version = 1_57_0

BASEDIR ?= $(CURDIR)/../..
HOST ?= x86_64-linux-gnu

src_tar = $(BASEDIR)/sources/boost_$(version).tar.gz
src_dir = $(BASEDIR)/work/build-$(HOST)/boost_$(version)
stage_dir = $(BASEDIR)/work/stage-$(HOST)
url = https://archives.boost.io/release/1.57.0/source/boost_$(version).tar.gz

$(package)_download:
	@mkdir -p $(BASEDIR)/sources
	@if [ ! -f "$(src_tar)" ]; then wget -O "$(src_tar)" "$(url)"; fi

$(package)_extract: $(package)_download
	@mkdir -p $(BASEDIR)/work/build-$(HOST)
	tar -xf "$(src_tar)" -C "$(BASEDIR)/work/build-$(HOST)"

$(package)_configure: $(package)_extract
	cd "$(src_dir)" && ./bootstrap.sh --prefix="$(stage_dir)" \
		--with-libraries=system,filesystem,thread,chrono,program_options \
		--with-python=no

$(package)_build: $(package)_configure
	cd "$(src_dir)" && ./b2 -j1 \
		link=static \
		threading=multi \
		--prefix="$(stage_dir)"

$(package)_stage: $(package)_build
	cd "$(src_dir)" && ./b2 install
