Library ieee;

use ieee.std_logic_1164.all;

entity dmux_2_7 is
	port(address : in std_logic;
		  data : in std_logic_vector(6 downto 0);
		  outp1, outp2 : out std_logic_vector(6 downto 0));
end entity;

architecture arch of dmux_2_7 is
begin
	process(address,data)
		begin
			case address is
				when '0' => outp1 <= data; outp2 <= (others => 'Z');
				when '1' => outp1 <= (others => 'Z'); outp2 <= data;
				when others => null;
			end case;
		end process;
end arch;