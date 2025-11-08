library ieee;
use ieee.std_logic_1164.all;

entity and_16_bit is
	port(A, B: in std_logic_vector(15 downto 0);
		  C: out std_logic_vector(15 downto 0)
		 ); 
end entity and_16_bit;

architecture struct of and_16_bit is

	begin
		C <= A and B;
end struct;