# Makefile for 2.6 kernel "cz" demo driver
# This Makefile idiom from the Rubini & Corbet (LDD3) book.

ifneq ($(KERNELRELEASE),)
	obj-m       := kvalloc.o
	#obj-m       := vmall1.o

# turn on debug mode
EXTRA_CFLAGS += -DDEBUG

else
#	KDIR        := /lib/modules/$(shell uname -r)/build
#########################################
# To support cross-compiling for the ARM:
# For ARM, invoke make as:
# make ARCH=arm CROSS_COMPILE=arm-none-linux-gnueabi- 
ifeq ($(ARCH),arm)
# Update 'KDIR' below to point to the ARM Linux kernel source tree
KDIR ?= ~/trg/beagleboard/linux-2.6.33.2
else
KDIR ?= /lib/modules/$(shell uname -r)/build 
endif
#########################################

	PWD         := $(shell pwd)
default:
	$(MAKE) -C $(KDIR) SUBDIRS=$(PWD) modules
clean:
	find . -name \*.o -exec rm -rf '{}' ';' 
	find . -name .\*.o.cmd -exec rm -rf '{}' ';' 
	find . -name \*.*~ -exec rm -rf '{}' ';' 
	find . -name \*.*.bak -exec rm -rf '{}' ';' 
	rm -f *.ko *.o *.mod.* .*.cmd 
	rm -fr .tmp_versions 
	rm -rf Module.symvers 
	rm -rf modules.order
endif


