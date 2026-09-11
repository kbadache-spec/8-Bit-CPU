Library ieee;

use ieee.std_logic_1164.all;

entity mux_8 is
	port(data1, data2, data3, data4, data5, data6, data7, data8, data9, data10, data11, data12, data13, data14, data15, data16 : in std_logic_vector(7 downto 0);
		  address : in integer range 0 to 15;
		  outp : out std_logic_vector(7 downto 0));
end entity;

architecture arch of mux_8 is
begin
	process(address)
	begin
		case address is
			when 0 => outp <= data1;
			when 1 => outp <= data2;
			when 2 => outp <= data3;
			when 3 => outp <= data4;
			when 4 => outp <= data5;
			when 5 => outp <= data6;
			when 6 => outp <= data7;
			when 7 => outp <= data8;
			when 8 => outp <= data9;
			when 9 => outp <= data10;
			when 10 => outp <= data11;
			when 11 => outp <= data12;
			when 12 => outp <= data13;
			when 13 => outp <= data14;
			when 14 => outp <= data15;
			when 15 => outp <= data16;
		end case;
	end process;
end arch;