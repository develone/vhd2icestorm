# Synopsys, Inc. constraint file
# C:\VHDL\XXX_Experimental\Latte_SPW\constraint\timing.sdc
# Written on Thu Apr 17 17:31:35 2014
# by Synplify Pro, I-2013.09L  Scope Editor

#
# Collections
#

#
# Clocks
#

#Global input clock from crystal, 12MHz
define_clock   {n:clk} -name {clk}  -freq 12 -clockgroup default_clkgroup_0

define_clock   {n:COMP_CLOCK.PLLOUTGLOBALA} -name {spw_clk}  -freq 96 -clockgroup default_clkgroup_1
define_clock   {n:COMP_CLOCK.PLLOUTGLOBALB} -name {sys_clk}  -freq 48 -clockgroup default_clkgroup_2

#
# Clock to Clock
#

#
# Inputs/Outputs
#

#
# Registers
#

#
# Delay Paths
#

#
# Attributes
#

#
# I/O Standards
#

#
# Compile Points
#

#
# Other
#
