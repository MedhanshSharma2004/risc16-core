library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity rf is 
	port (rf_write_in, clk: in std_logic;
	      rf_a1, rf_a2, rf_a3: in std_logic_vector(2 downto 0); 
	      rf_d3: in std_logic_vector(15 downto 0);
		   rf_d1, rf_d2: out std_logic_vector(15 downto 0) ;
			r0: out std_logic_vector(15 downto 0);
			r1: out std_logic_vector(15 downto 0);
			r2: out std_logic_vector(15 downto 0);
			r3: out std_logic_vector(15 downto 0);
			r4: out std_logic_vector(15 downto 0);
			r5: out std_logic_vector(15 downto 0);
			r6: out std_logic_vector(15 downto 0);
			r7: out std_logic_vector(15 downto 0)
			);
end entity;

architecture bhv of rf is

	type regarray is array(7 downto 0) of std_logic_vector(15 downto 0);   

	signal register_file: regarray := (0=>"0000000000001000", 1=>"0000000000000001", others => "0000000000000000");

	begin

	rf_d1 <= register_file(to_integer(unsigned(rf_a1)));
	rf_d2 <= register_file(to_integer(unsigned(rf_a2)));
	
	r0 <= register_file(0);
	r1 <= register_file(1);
	r2 <= register_file(2);
	r3 <= register_file(3);
	r4 <= register_file(4);
	r5 <= register_file(5);
	r6 <= register_file(6);
	r7 <= register_file(7);
	
	Mem_write:
	process (rf_write_in, rf_a3, rf_d3, clk)

		begin

		if(rf_write_in = '1') then
			if(rising_edge(clk)) then
				register_file(to_integer(unsigned(rf_a3))) <= rf_d3;
			end if;
		end if;
		
	end process;

end bhv;