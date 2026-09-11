Library ieee;

use ieee.std_logic_1164.all;

entity Dec4 is
	port(sel : in integer range 0 to 3;
		  outp : out std_logic_vector(3 downto 0));
end entity;

architecture arch of Dec4 is
	Begin
		process(sel)
			begin
				outp <= (others => '0');
				outp(sel) <= '1';
			end process;
	end arch;