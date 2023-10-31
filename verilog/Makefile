

YOSYS_OPTS := -l ../yosys.log -Q -p hierarchy -p proc -p opt -p "tee -o ../synthesis.log"
NEXTPNR_OPTS := --pcf-allow-unconstrained --package ct256 -l ../place_and_route.log

SRC := $(shell find . -name '*.v')

all: $(PROJ).rpt $(PROJ).bin

ifeq ($(PNR), arachne-pnr)

%.blif: %.v
	yosys -p 'synth_ice40 -top top -blif $@' $<

$(PROJ).blif: $(SRC)
	yosys $(YOSYS_OPTS) -p "synth_ice40 -top $(PROJ) -blif $@" $(SRC)

%.asc: $(PIN_DEF) %.blif
	arachne-pnr -d $(subst hx,,$(subst lp,,$(DEVICE))) -o $@ -p $^

else

$(PROJ).json: $(SRC)
	yosys $(YOSYS_OPTS) -p "synth_ice40 -top $(PROJ) -json $@" $(SRC)

%.asc: $(PIN_DEF) %.json
	nextpnr-ice40 $(NEXTPNR_OPTS) --$(DEVICE) --pcf $(PIN_DEF) --asc $@ --json $(PROJ).json

endif

%.bin: %.asc
	icepack $< $@

%.rpt: %.asc
	icetime -d $(DEVICE) -mtr $@ $<

%_tb: %_tb.v %.v
	iverilog -o $@ $^

%_tb.vcd: %_tb
	vvp -N $< +vcd=$@

%_syn.v: %.blif
	yosys -p 'read_blif -wideports $^; write_verilog $@'

%_syntb: %_tb.v %_syn.v
	iverilog -o $@ $^ `yosys-config --datdir/ice40/cells_sim.v`

%_syntb.vcd: %_syntb
	vvp -N $< +vcd=$@

prog: $(PROJ).bin
	iceprog $<

prog-ram: $(PROJ).bin
	iceprog -S $<

sudo-prog: $(PROJ).bin
	@echo 'Executing prog as root!!!'
	sudo iceprog $<

clean:
	rm -f $(PROJ).blif $(PROJ).asc $(PROJ).rpt $(PROJ).bin $(PROJ).json

.SECONDARY:
.PHONY: all prog clean
