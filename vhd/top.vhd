--------------------------------------------------------------------------------
-- File: top.vhd
--------------------------------------------------------------------------------

library IEEE;

use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity top is
port (
	clk		: in 	std_logic;

	--LEDs
	led : out std_logic_vector(4 downto 0)
	
);
end top;

architecture behavioural of top is

signal sig_counter : unsigned(26 downto 0);

begin

led(4) <= sig_counter(sig_counter'left);
led(3) <= sig_counter(sig_counter'left - 1);
led(2) <= sig_counter(sig_counter'left - 2);
led(1) <= sig_counter(sig_counter'left - 3);
led(0) <= sig_counter(sig_counter'left - 4);

process(clk)
begin
	if rising_edge(clk) then
		sig_counter <= sig_counter + to_unsigned(1, 8);
	end if;
end process;

end behavioural;
