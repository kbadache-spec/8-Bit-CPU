Library ieee;

use ieee.std_logic_1164.all;

entity Mux_2_4 is
	port(IN1, IN2 : in std_logic_vector(3 downto 0);
		  sel : in integer range 1 downto 0;
		  outp : out std_logic_vector(3 downto 0));
end entity;

architecture arch of Mux_2_4 is
begin
	process(IN1, IN2, sel)
	begin
		case sel is
		when 0 => outp <= IN1;
		when 1 => outp <= IN2;
		end case;
	end process;
end arch;