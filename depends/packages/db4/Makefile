package = db4
version = 4.8.30

BASEDIR ?= $(CURDIR)/../..
HOST ?= x86_64-linux-gnu

src_tar = $(BASEDIR)/sources/db-$(version).tar.gz
src_dir = $(BASEDIR)/work/build-$(HOST)/db-$(version)
build_dir = $(src_dir)/build_unix
stage_dir = $(BASEDIR)/work/stage-$(HOST)
url = https://download.oracle.com/berkeley-db/db-$(version).tar.gz

$(package)_download:
	@mkdir -p $(BASEDIR)/sources
	@if [ ! -f "$(src_tar)" ]; then \
		wget -O "$(src_tar)" "$(url)"; \
	fi

$(package)_extract: $(package)_download
	@mkdir -p $(src_dir)
	tar -xf "$(src_tar)" -C "$(BASEDIR)/work/build-$(HOST)"

#$(package)_patch: $(package)_extract
#	@echo "Applying db4 atomic patch..."
#	cd "$(src_dir)" && \
#		chmod u+w dbinc/atomic.h && \
#		patch -p0 --no-backup-if-mismatch < "$(BASEDIR)/packages/db4/fix_atomic.patch"

$(package)_patch: $(package)_extract
	@echo "Applying db4 atomic rename..."
	cd "$(src_dir)" && \
		chmod u+w dbinc/atomic.h && \
		sed -i \
		  -e 's/\b__atomic_compare_exchange\b/__db_atomic_compare_exchange/g' \
		  -e 's/atomic_add_explicit/atomic_fetch_add_explicit/g' \
		  dbinc/atomic.h

$(package)_configure: $(package)_patch
	@mkdir -p "$(build_dir)"
	cd "$(build_dir)" && \
		CFLAGS="-fPIC" \
		CXXFLAGS="-fPIC" \
		db_cv_mutex="POSIX/pthreads" \
		../dist/configure \
			--host=$(HOST) \
			--prefix="$(stage_dir)" \
			--disable-shared \
			--enable-cxx \
			--disable-replication \
			--with-pic

$(package)_build: $(package)_configure
	$(MAKE) -C "$(build_dir)"

$(package)_stage: $(package)_build
	$(MAKE) -C "$(build_dir)" install_lib install_include 
