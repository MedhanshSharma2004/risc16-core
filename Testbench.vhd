library ieee;
use ieee.std_logic_1164.all;

entity Testbench is 
end; 
architecture TB_BEHAVIOR of Testbench is 

component CPU is 
port(clk: in std_logic);
end component;

signal D_CLK: std_logic:= '0'; 
begin 
  

process
constant OFF_PERIOD: TIME := 10 ns; 
constant ON_PERIOD : TIME := 10 ns; 
begin 
wait  for OFF_PERIOD; 
D_CLK <= '1'; 
wait for ON_PERIOD; 
D_CLK <= '0'; 
end process;



EUT: CPU port map (D_CLK) ; 

end TB_BEHAVIOR;