# PROJ = example
# PROJ = rs232demo
# PROJ = checker
# PROJ = top

#PIN_DEF = ../constraint/icestick.pcf
#DEVICE = hx1k

SRC := $(shell find . -name '*.v')
#SRC := top.v uart.v

#all: $(PROJ).rpt $(PROJ).bin

#%.blif: %.v
#	yosys -p 'synth_ice40 -top top -blif $@' $<

#$(PROJ).blif: $(SRC)
#	yosys -q -Q -p "synth_ice40 -top $(PROJ) -blif $@" $(SRC)

#%.asc: $(PIN_DEF) %.blif
#	arachne-pnr -d $(subst hx,,$(subst lp,,$(DEVICE))) -o $@ -p $^

$(PROJ).json: $(SRC)
	yosys -q -Q -p "synth_ice40 -top $(PROJ) -json $@" $(SRC)

%.asc: $(PIN_DEF) %.json
	nextpnr-ice40 --pcf-allow-unconstrained --$(DEVICE) --asc $@ --pcf $(PIN_DEF) --json $(PROJ).json

%.bin: %.asc
	icepack $< $@

%.rpt: %.asc
	icetime -d $(DEVICE) -mtr $@ $<

all: $(PROJ).rpt $(PROJ).bin

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
