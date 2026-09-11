Library ieee;

use ieee.std_logic_1164.all;

entity dec_16 is
	port(sel : in integer range 0 to 15;
		  outp : out std_logic_vector (15 downto 0));
end entity;

architecture arch of dec_16 is
begin
	process(sel)
	begin
		outp <= (others => '0');
		outp(sel) <= '1';
	end process;
end arch;