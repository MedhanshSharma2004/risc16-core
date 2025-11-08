library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sign_extend10 is
	port (ip: in std_logic_vector(5 downto 0); 
	      ex_op: out std_logic_vector(15 downto 0)
		  );
end entity sign_extend10;

architecture bhv of sign_extend10 is
	
	begin

	ex_op <= "1111111111" & ip when (ip(5) = '1') else
				"0000000000" & ip;

end bhv;