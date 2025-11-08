library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity mul_16_bit is
  port (
    A, B: in std_logic_vector(15 downto 0);
    C: out std_logic_vector(15 downto 0)
  ); 
end entity mul_16_bit;

architecture bhv of mul_16_bit is
signal x: std_logic_vector(31 downto 0);
begin
  x <= std_logic_vector(unsigned(A) * unsigned(B));
  C <= x(15 downto 0);
end bhv;
