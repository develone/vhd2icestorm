
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.math_real.all;

entity uart is
generic(
	BIT_WIDTH		: integer := 12;
	BAUD_RATE 		: integer := 9600;
	CLOCK_FREQ_HZ 	: integer := 12000000
);
port(
	clk : in std_logic;
	rx	: in std_logic;
	tx	: out std_logic;
	
	send	: in std_logic;	
	valid 	: out std_logic;

	rx_data : out std_logic_vector(7 downto 0);
	tx_data : in std_logic_vector(7 downto 0)
);
end uart;

architecture arch of uart is

constant HALF_PERIOD : integer := CLOCK_FREQ_HZ / (2 * BAUD_RATE);

constant cbarrel : std_logic_vector(9 downto 0) := "0000000001";


signal sig_rx_buf : std_logic_vector(7 downto 0);
signal sig_tx_buf : std_logic_vector(7 downto 0);

signal sig_rx_cnt : unsigned(BIT_WIDTH-1 downto 0); --integer range 0 to 2*HALF_PERIOD;
signal sig_tx_cnt : unsigned(BIT_WIDTH-1 downto 0); --integer range 0 to 2*HALF_PERIOD;

--signal sig_rx_bit	: integer range 0 to 9;
--signal sig_tx_bit	: integer range 0 to 9;

signal sig_rx_bit	: std_logic_vector(9 downto 0);
signal sig_tx_bit	: std_logic_vector(9 downto 0);

type states is (idle, work);
signal rxstate : states;
signal txstate : states;

begin


rx_process : process(clk)
begin
if rising_edge(clk) then
	case rxstate is
		when idle =>
			valid <= '0';
			
			sig_rx_cnt <= to_unsigned(HALF_PERIOD, BIT_WIDTH);
			sig_rx_bit <= cbarrel; --0;

			if rx = '0' then
				rxstate <= work;
			end if;
		
		when work =>
			if sig_rx_cnt = to_unsigned(2*HALF_PERIOD, BIT_WIDTH) then
				sig_rx_cnt <= (others => '0');
				sig_rx_bit(9 downto 1) <= sig_rx_bit(8 downto 0); --sig_rx_bit + 1;

				if sig_rx_bit(9) = '1' then
					valid <= '1';
					rxstate <= idle;
					rx_data <= sig_rx_buf;
				else
					sig_rx_buf(6 downto 0) <= sig_rx_buf(7 downto 1);
					sig_rx_buf(7) <= rx;
				end if;
			else
				sig_rx_cnt <= sig_rx_cnt + 1;
			end if;
		when others => NULL;
	end case;
end if;
end process;

tx_process : process(clk)
begin
if rising_edge(clk) then
	case txstate is
		when idle =>
			tx <= '1';

			sig_tx_cnt <= to_unsigned(HALF_PERIOD, BIT_WIDTH);
			sig_tx_bit <= cbarrel; --0;
			sig_tx_buf <= tx_data;
			if send = '1' then
				tx <= '0';
				txstate <= work;
			end if;
		
		when work =>
			if sig_tx_cnt = 2*HALF_PERIOD then
				sig_tx_cnt <= (others => '0');
				sig_tx_bit(9 downto 1) <= sig_tx_bit(8 downto 0); --sig_tx_bit + 1;
				if sig_tx_bit(9) = '1' then
					txstate <= idle;
					--tx_data <= sig_rx_buf;
				else
					--sig_tx_buf(7 downto 1) <= sig_tx_buf(6 downto 0);
					sig_tx_buf(6 downto 0) <= sig_tx_buf(7 downto 1);
					tx <= sig_tx_buf(0);
				end if;
			else
				sig_tx_cnt <= sig_tx_cnt + 1;
			end if;
		when others => NULL;
	end case;
end if;
end process;

end arch;
