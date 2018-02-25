#!/usr/bin/make

TEMP = ../temp/vhdl

all:
ifneq ($(shell which ghdl),)
	@mkdir -p $(TEMP)
	@echo "##### Checking sources with GHDL ##############################"
	#ghdl -a --workdir=$(TEMP) *.vhd
	ghdl -a --workdir=$(TEMP) $(sort $(wildcard *.vhd))
endif

clean:
	rm -fr $(TEMP)
