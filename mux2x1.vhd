library ieee;
use ieee.std_logic_1164.all;

entity Mux_2x1 is
    port (A: in std_logic_vector(1 downto 0); 
	       S: out std_logic;
			sel: in  std_logic_vector(1 downto 0)
			 );
end entity Mux_2x1;

architecture struct of Mux_2x1 is
	
begin
	S <= (A(0) and Sel(0)) or (A(1) and sel(1)); 
end struct;