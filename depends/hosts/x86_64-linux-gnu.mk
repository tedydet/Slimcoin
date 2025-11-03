# Host definition for Linux x86_64 (GCC / glibc)

AR := ar
NM := nm
RANLIB := ranlib
STRIP := strip

CC := gcc
CXX := g++
LD := g++

# C/C++ flags
CFLAGS := -O2 -fPIC -fstack-protector-all -D_FORTIFY_SOURCE=2
CXXFLAGS := -O2 -std=c++11 -fPIC -fstack-protector-all -D_FORTIFY_SOURCE=2

# Prefix for final installed libs/includes
INSTALL_PREFIX := $(DESTDIR)
