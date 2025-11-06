SHELL := /bin/bash
HOST ?= x86_64-linux-gnu
BASEDIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

.DEFAULT_GOAL := all

all: $(BASEDIR)/work/build-$(HOST)/.stamp_built

include $(BASEDIR)/deps.mk

.PHONY: all clean
clean:
	rm -rf $(BASEDIR)/work $(BASEDIR)/sources
