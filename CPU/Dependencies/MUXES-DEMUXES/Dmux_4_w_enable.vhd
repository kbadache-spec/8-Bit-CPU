Library ieee;

use ieee.std_logic_1164.all;

entity dmux_4_w_enable is
	port(inp, en : in std_logic;
		  sel : in integer range 0 to 15;
		  outp : out std_logic_vector(15 downto 0));
end entity;

architecture arch of dmux_4_w_enable is
begin
	process(inp,en,sel)
	begin
		if(en='1') then
			outp <= (others => '0');
			outp(sel) <= inp;
		end if;
	end process;
end arch;