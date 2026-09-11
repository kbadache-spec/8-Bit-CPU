Library ieee;

use ieee.std_logic_1164.all;

entity dmux_4_8 is
	port(Data : in std_logic_vector(7 downto 0);
		  sel : in integer range 0 to 3;
		  out1, out2, out3, out4 : out std_logic_vector(7 downto 0));
end entity;

architecture arch of dmux_4_8 is
	begin
		process(Data, sel)
			begin
				out1 <= (others => 'Z');
				out2 <= (others => 'Z');
				out3 <= (others => 'Z');
				out4 <= (others => 'Z');
				case sel is
					when 0 => out1 <= Data;
					when 1 => out2 <= Data;
					when 2 => out3 <= Data;
					when 3 => out4 <= Data;
				end case;
			end process;
	end arch;