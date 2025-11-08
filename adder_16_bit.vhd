library ieee;
use ieee.std_logic_1164.all;

entity adder_16_bit is
port (A, B: in std_logic_vector(15 downto 0);
      S: out std_logic_vector(15 downto 0);
		Cout: out std_logic
	  );
end entity;

architecture struct of adder_16_bit is

  component full_adder is
    port (
      A, B, Cin: in std_logic;
      S, Cout: out std_logic
    );
  end component;

  signal carry : std_logic_vector(15 downto 0);

begin

fadd0 : full_adder port map(A=>A(0), B=>B(0), Cin=>'0', S=>S(0), Cout=>carry(0));
fadd1 : full_adder port map(A=>A(1), B=>B(1), Cin=>carry(0), S=>S(1), Cout=>carry(1));
fadd2 : full_adder port map(A=>A(2), B=>B(2), Cin=>carry(1), S=>S(2), Cout=>carry(2));
fadd3 : full_adder port map(A=>A(3), B=>B(3), Cin=>carry(2), S=>S(3), Cout=>carry(3));
fadd4 : full_adder port map(A=>A(4), B=>B(4), Cin=>carry(3), S=>S(4), Cout=>carry(4));
fadd5 : full_adder port map(A=>A(5), B=>B(5), Cin=>carry(4), S=>S(5), Cout=>carry(5));
fadd6 : full_adder port map(A=>A(6), B=>B(6), Cin=>carry(5), S=>S(6), Cout=>carry(6));
fadd7 : full_adder port map(A=>A(7), B=>B(7), Cin=>carry(6), S=>S(7), Cout=>carry(7));
fadd8 : full_adder port map(A=>A(8), B=>B(8), Cin=>carry(7), S=>S(8), Cout=>carry(8));
fadd9 : full_adder port map(A=>A(9), B=>B(9), Cin=>carry(8), S=>S(9), Cout=>carry(9));
fadd10 : full_adder port map(A=>A(10), B=>B(10), Cin=>carry(9), S=>S(10), Cout=>carry(10));
fadd11 : full_adder port map(A=>A(11), B=>B(11), Cin=>carry(10), S=>S(11), Cout=>carry(11));
fadd12 : full_adder port map(A=>A(12), B=>B(12), Cin=>carry(11), S=>S(12), Cout=>carry(12));
fadd13 : full_adder port map(A=>A(13), B=>B(13), Cin=>carry(12), S=>S(13), Cout=>carry(13));
fadd14 : full_adder port map(A=>A(14), B=>B(14), Cin=>carry(13), S=>S(14), Cout=>carry(14));
fadd15 : full_adder port map(A=>A(15), B=>B(15), Cin=>carry(14), S=>S(15), Cout=>carry(15));

Cout<= carry(15);

end struct;
