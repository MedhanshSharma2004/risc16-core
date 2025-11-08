library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Lshifter8 is
	port (inp : in std_logic_vector (15 downto 0);
			outp : out std_logic_vector (15 downto 0));
end entity LShifter8;

architecture struct of Lshifter8 is
	begin
		outp(15 downto 8) <= inp(7 downto 0);
		outp(7 downto 0) <= "00000000";
end struct;