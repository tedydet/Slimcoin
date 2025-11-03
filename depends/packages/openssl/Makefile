package = openssl
version = 1.0.2u

BASEDIR ?= $(CURDIR)/../..
HOST ?= x86_64-linux-gnu

src_tar = $(BASEDIR)/sources/openssl-$(version).tar.gz
src_dir = $(BASEDIR)/work/build-$(HOST)/openssl-$(version)
stage_dir = $(BASEDIR)/work/stage-$(HOST)
url = https://www.openssl.org/source/old/1.0.2/openssl-$(version).tar.gz

$(package)_download:
	@mkdir -p $(BASEDIR)/sources
	@if [ ! -f "$(src_tar)" ]; then \
		wget -O "$(src_tar)" "$(url)"; \
	fi

$(package)_extract: $(package)_download
	@mkdir -p $(BASEDIR)/work/build-$(HOST)
	@tar -xf $(src_tar) -C $(BASEDIR)/work/build-$(HOST)

$(package)_configure: $(package)_extract
	@echo "Configuring OpenSSL..."
	cd "$(src_dir)" && \
		chmod u+w . && \
		./config \
			--prefix=$(stage_dir) \
			--openssldir=$(stage_dir)/openssl \
			no-shared \
			no-ssl3 \
			no-asm \
			no-gost \
			no-aria \
			no-psk || exit 1

$(package)_build: $(package)_configure
	@echo "Building OpenSSL..."
	$(MAKE) -C "$(src_dir)"

$(package)_stage: $(package)_build
	@echo "Installing OpenSSL..."
	$(MAKE) -C "$(src_dir)" install_sw install_ssldirs
	@touch $(BASEDIR)/packages/openssl/.stamp_built
