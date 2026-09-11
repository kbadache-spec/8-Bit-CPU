library ieee;

use ieee.std_logic_1164.all;

entity reg is
	Port(I : in std_logic_vector(7 downto 0);
		  clk, en_r, en_w, turn_on : in std_logic;
		  outp : out std_logic_vector(7 downto 0));
end entity;

architecture arch of reg is
	signal data : std_logic_vector(7 downto 0);
	signal ctrl : std_logic;
begin
	process(clk)
		begin
			if (clk' event and clk = '1') then
				if (en_w ='1' and turn_on = '1') then
					data <= I;
				end if;
			end if;
		end process;
	ctrl <= en_r and turn_on;
	with ctrl select 
		outp <= data when '1',
				  (others => 'Z') when others;
end arch;