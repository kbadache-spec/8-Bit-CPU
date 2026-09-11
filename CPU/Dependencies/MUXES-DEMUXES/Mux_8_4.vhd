Library ieee;

use ieee.std_logic_1164.all;

entity Mux_8_4 is
	port(data1, data2, data3, data4 : in std_logic_vector(7 downto 0);
		  sel : in integer range 3 downto 0;
		  outp : out std_logic_vector(7 downto 0));
end entity;

architecture arch of Mux_8_4 is
begin
	process(sel,data1,data2,data3,data4)
		begin
			case sel is
				when 0 => outp <= data1;
				when 1 => outp <= data2;
				when 2 => outp <= data3;
				when 3 => outp <= data4;
			end case;
		end process;
end arch;