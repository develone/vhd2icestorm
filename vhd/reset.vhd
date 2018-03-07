-- reset.vhd
library IEEE;
use IEEE.std_logic_1164.all;

entity reset is
	generic(
		LENGTH : integer := 3
	);
	port(
		preset : in std_logic;
		clk : in std_logic;
		rst_out : out std_logic
);
end reset;

architecture behavioral of reset is
--------------------------------------------------------------------------------
-- SIGNAL DECLARATIONS
--------------------------------------------------------------------------------
signal sig_rst : std_logic_vector(LENGTH downto 0) ;

begin
	rst_out <= sig_rst(0);
	sig_rst(LENGTH) <= '0';

GEN_FF : for i in 0 to (LENGTH-1) generate
	PROC_RESET : process(clk, preset)
	begin
		if(preset = '1') then
			sig_rst(i) <= '1';
		elsif(rising_edge(clk)) then
			sig_rst(i) <= sig_rst(i+1);
		end if;
	end process PROC_RESET;
end generate GEN_FF;
	
end behavioral;
