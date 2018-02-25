module clocking(REFERENCECLK,
                PLLOUTCOREA,
                PLLOUTCOREB,
                PLLOUTGLOBALA,
                PLLOUTGLOBALB,
                RESET,
                LOCK);

input REFERENCECLK;
input RESET;    /* To initialize the simulation properly, the RESET signal (Active Low) must be asserted at the beginning of the simulation */ 
output PLLOUTCOREA;
output PLLOUTCOREB;
output PLLOUTGLOBALA;
output PLLOUTGLOBALB;
output LOCK;

SB_PLL40_2F_CORE clocking_inst(.REFERENCECLK(REFERENCECLK),
                               .PLLOUTCOREA(PLLOUTCOREA),
                               .PLLOUTCOREB(PLLOUTCOREB),
                               .PLLOUTGLOBALA(PLLOUTGLOBALA),
                               .PLLOUTGLOBALB(PLLOUTGLOBALB),
                               .EXTFEEDBACK(),
                               .DYNAMICDELAY(),
                               .RESETB(RESET),
                               .BYPASS(1'b0),
                               .LATCHINPUTVALUE(),
                               .LOCK(LOCK),
                               .SDI(),
                               .SDO(),
                               .SCLK());

//\\ Fin=12, Fout=96;
defparam clocking_inst.DIVR = 4'b0000;
defparam clocking_inst.DIVF = 7'b0111111;
defparam clocking_inst.DIVQ = 3'b011;
defparam clocking_inst.FILTER_RANGE = 3'b001;
defparam clocking_inst.FEEDBACK_PATH = "SIMPLE";
defparam clocking_inst.DELAY_ADJUSTMENT_MODE_FEEDBACK = "FIXED";
defparam clocking_inst.FDA_FEEDBACK = 4'b0000;
defparam clocking_inst.DELAY_ADJUSTMENT_MODE_RELATIVE = "FIXED";
defparam clocking_inst.FDA_RELATIVE = 4'b0000;
defparam clocking_inst.SHIFTREG_DIV_MODE = 2'b00;
defparam clocking_inst.PLLOUT_SELECT_PORTA = "GENCLK";
defparam clocking_inst.PLLOUT_SELECT_PORTB = "GENCLK_HALF";
defparam clocking_inst.ENABLE_ICEGATE_PORTA = 1'b0;
defparam clocking_inst.ENABLE_ICEGATE_PORTB = 1'b0;

endmodule
