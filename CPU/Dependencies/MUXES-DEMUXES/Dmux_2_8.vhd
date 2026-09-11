Library ieee;

use ieee.std_logic_1164.all;

entity Dmux_2_8 is
	port(Data1, Data2 : in std_logic_vector(7 downto 0);
		  sel : in integer range 0 to 1;
		  outp : out std_logic_vector(7 downto 0));
end entity;

architecture arch of Dmux_2_8 is
begin
	process(Data1, Data2, sel)
		begin
			case sel is
				when 0 => outp <= Data1;
				when 1 => outp <= Data2;
			end case;
		end process;
end arch;