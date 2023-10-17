#Project top entity

export PROJ = top

#Path to vhdl source files
SRC = vhd

#Pin definition file
export PIN_DEF = $(CURDIR)/constraint/helloworld.pcf
export DEVICE = hx8k

#path to vhd2vl
VHD2VL	= $(CURDIR)/vhd2vl/src/vhd2vl
GHDL	= ghdl

# Intermediate verilog directory (output from vhd2vl)
# Needs to contain makefile from icestorm
# examples/icestick/Makefile
# Comment out PROJ in the file, exported from here
VERILOG  = verilog

#Read exclude file in src directory
EXCLUDE  = $(shell cat $(SRC)/exclude)
EXCLUDE := $(basename $(EXCLUDE))
EXCLUDE := $(addsuffix .vhd,$(EXCLUDE))

#List vhd files in src directory
VHDLS    = $(sort $(wildcard $(SRC)/*.vhd))
VHDLS   := $(notdir $(VHDLS))

#Place and route tool
PNR := nextpnr

all: vhd2vl translate
	@make -C $(VERILOG) PNR=$(PNR)

#Translate VHDL to Verilog
syntax-check:
	@echo "Checking VHDL syntax with GHDL"
	(GHDL) --clean
	@cd $(SRC); \
	$(foreach VHDL,$(VHDLS), echo "Processing: $(VHDL)";\
	$(GHDL) -a $(VHDL);)

translate:
	@echo "Translating vhdl to verilog"
	@cd $(SRC); \
	$(foreach VHDL,$(VHDLS), echo "Processing: $(VHDL)";\
	$(VHD2VL) --quiet $(VHDL) ../$(VERILOG)/$(basename $(VHDL)).v;)
	@echo "Done."

prog: vhd2vl translate
	make prog -C verilog

prog-ram: vhd2vl translate
	make prog-ram -C verilog

#Download vhd2vl from github
vhd2vl: vhd2vl-check
	make -C vhd2vl/src

vhd2vl-check:
	@echo "Checking for vhd2vl ."
	@if [ ! -d "./vhd2vl" ]; then \
		git clone https://github.com/ldoolitt/vhd2vl; \
	fi

clean:
	make clean -C verilog
	rm -f $(VERILOG)/*.v
	rm -fr *.log

dist-clean: clean
	rm -fr vhd2vl

