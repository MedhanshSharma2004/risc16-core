library ieee;
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;

entity Memory is 
	port (clk, m_wr: in std_logic; 
			mem_addr, mem_in: in std_logic_vector(15 downto 0);
			mem_out: out std_logic_vector(15 downto 0)); 
end entity Memory;

architecture mem of Memory is 
	type mem_vect is array (65535 downto 0) of std_logic_vector (15 downto 0);
	signal memo : mem_vect := (0=> "0000000001010000", 1=>"0000000001011000",
--										1=>"0010000001010000", 2=>"0011000001010000", 3=>"0000011001010001",
--										4=>"0010011001010000", 5=>"0010111110010001", 6=>"0010101001010010", 7=>"0001001010010000", 8=>"0011010100000000",9=>"1000011000010100", 
--										29=>"1100011011001011", 40=>"0110010001101100", 41=>"0111011001101100", 42=>"0101001010000001", 43=>"0100001010000001", 44=>"1001010010000000",
--										32768=>"0000000000000001", 32769=>"0000000000000010", 32770=>"0000000000000100", 32771=>"0000000000001000", 32772=>"0000000000010000", 32773=>"0000000000100000", 32774=>"0000000001000000", 32775=>"0000000010000000", 
										others => "0000000000000000");		 
begin	
	mem_process : process (mem_addr) is
	begin
	      
--Memory read
			mem_out <= memo(to_integer(unsigned(mem_addr)));
--Memory write
		if rising_edge(clk) then
			if m_wr = '1' then
				memo(to_integer(unsigned(mem_addr))) <= mem_in;
			end if;
		end if;
	end process;
end architecture mem;