library ieee;
use ieee.std_logic_1164.all;

entity imp_16_bit is
	port(A, B: in std_logic_vector(15 downto 0);
		  C: out std_logic_vector(15 downto 0)
		 ); 
end entity imp_16_bit;

architecture struct of imp_16_bit is

	begin
		C <= (not A) or B;
end struct;