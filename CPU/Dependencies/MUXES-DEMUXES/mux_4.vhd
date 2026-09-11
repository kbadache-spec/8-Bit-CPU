Library ieee;

use ieee.std_logic_1164.all;

entity dmux_4 is
	port(sel : in integer range 0 to 15;
		  inp : in std_logic;
		  outp : out std_logic_vector(15 downto 0));
end entity;

architecture arch of dmux_4 is
begin
	process(sel, inp)
		begin
			outp <= (others => '0');
			outp(sel) <= inp;
		end process;
end arch;