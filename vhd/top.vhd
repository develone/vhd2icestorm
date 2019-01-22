--------------------------------------------------------------------------------
-- File: top.vhd
--------------------------------------------------------------------------------

library IEEE;

use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity top is
generic(
	uarts : integer := 8
);
port (
	clk		: in 	std_logic;
	
	rx	: in std_logic_vector(uarts-1 downto 0);
	tx	: out std_logic_vector(uarts-1 downto 0);

	--LEDs
	led : out std_logic_vector(4 downto 0)
	
);
end top;

architecture behavioural of top is

constant BIT_WIDTH		: integer := 11;
constant BAUD_RATE 		: integer := 9600;
constant CLOCK_FREQ_HZ 	: integer := 12000000;

signal sig_counter : unsigned(23 downto 0);

signal sig_send : std_logic_vector(uarts-1 downto 0);
signal sig_valid : std_logic_vector(uarts-1 downto 0);

signal sig_rx_data : std_logic_vector(8*(uarts-1) + 7 downto 0);
signal sig_tx_data : std_logic_vector(8*(uarts-1) + 7 downto 0);

--signal sig_rx_data : std_logic_vector(7 downto 0);
--signal sig_tx_data : std_logic_vector(7 downto 0);
signal sig_led : std_logic_vector(4 downto 0);

begin

led <= sig_led;

sig_led(4) <= sig_counter(sig_counter'left);
--led(3) <= sig_counter(sig_counter'left - 1);
--led(2) <= sig_counter(sig_counter'left - 2);
--led(1) <= sig_counter(sig_counter'left - 3);
--led(0) <= sig_counter(sig_counter'left - 4);
sig_send <= sig_valid;
sig_tx_data <= sig_rx_data;


process(clk)
begin
	if rising_edge(clk) then
		sig_counter <= sig_counter + to_unsigned(1, 24);
	end if;
end process;

process(clk)
begin
	if rising_edge(clk) then
		if sig_valid(0) = '1' then
			
			if sig_rx_data(7 downto 0) = x"31" then
				sig_led(0) <= not sig_led(0);
			elsif sig_rx_data(7 downto 0) = x"32" then
				sig_led(1) <= not sig_led(1);
			elsif sig_rx_data(7 downto 0) = x"33" then
				sig_led(2) <= not sig_led(2);
			elsif sig_rx_data(7 downto 0) = x"34" then
				sig_led(3) <= not sig_led(3);
			end if;
		end if;
	end if;
end process;

gen_loop : for i in 0 to uarts-1 generate
	uart_inst : entity work.uart
	generic map(
		BIT_WIDTH => BIT_WIDTH,
		BAUD_RATE => BAUD_RATE,
		CLOCK_FREQ_HZ => CLOCK_FREQ_HZ
	)
	port map(
		clk => clk,
		rx => rx(i),
		tx => tx(i),
	
		send => sig_send(i),
		valid => sig_valid(i),
	
		rx_data => sig_rx_data(7+8*i downto 8*i),
		tx_data => sig_tx_data(7+8*i downto 8*i)
	);
end generate;

end behavioural;
