library ieee;
use ieee.std_logic_1164.all;

entity or_16_bit is
	port(A, B: in std_logic_vector(15 downto 0);
		  C: out std_logic_vector(15 downto 0)
		 ); 
end entity or_16_bit;

architecture struct of or_16_bit is

	begin
		C <= A or B;
end struct;