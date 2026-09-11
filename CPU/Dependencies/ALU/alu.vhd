library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu is 
 Port(sel : in unsigned(2 downto 0);
		A,B : in signed(7 downto 0);
		en : in std_logic;
		outp : out signed(7 downto 0);
		zr,ng : out std_logic);
end entity;

architecture arch of alu is
	signal out_temp : signed(7 downto 0);
begin
	process(en, sel, A, B)
	begin
		if(en ='1') then
			case sel is
				when "000" => out_temp <= not(A);
				when "001" => out_temp <= A and B;
				when "010" => out_temp <= A or B;
				when "011" => out_temp <= A nand B;
				when "100" => out_temp <= A nor B;
				when "101" => out_temp <= A xor B;
				when "110" => out_temp <= A + B;
				when "111" => out_temp <= A - B;
				when others => out_temp <= (others => '0');
			end case;	
		else
			out_temp <= (others => '0');
		end if;	
	end process;
	
	
	zr <= '1' when out_temp = x"00"
	else 	'0';
	
	
	ng <= '1' when out_temp < x"00"
	else 	'0';
	
	
	outp <= out_temp;
	
end architecture;
				