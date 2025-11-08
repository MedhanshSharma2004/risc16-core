library ieee;
use ieee.std_logic_1164.all;

entity CPU is 
	port(clk, reset: in std_logic;
	     switch: in std_logic_vector(4 downto 0);
		  ml_toggle: in std_logic;
		  addmode: in std_logic_vector(1 downto 0);
		  output: out std_logic_vector(7 downto 0));
end entity;

architecture completete of CPU is
	
	component FSM is 
	port( opcode:in std_logic_vector(3 downto 0);
         z: in std_logic;
			clk:in std_logic;
			output_state: out std_logic_vector(4 downto 0)
		 );
	end component;
   
	component DataPath is
	port(
			clk: in std_logic; state: in std_logic_vector(4 downto 0); 
			opcode: out std_logic_vector(3 downto 0);
			alu_Co: out std_logic_vector(15 downto 0);
			z_out: out std_logic
		 );
	end component;
	
--	
--	component rf is 
--	port (rf_write_in, clk: in std_logic;
--	      rf_a1, rf_a2, rf_a3: in std_logic_vector(2 downto 0); 
--	      rf_d3: in std_logic_vector(15 downto 0);
--		   rf_d1, rf_d2: out std_logic_vector(15 downto 0) 
--			);
--	end component;

   component rf is 
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
	end component;
	
	
	signal alu_Co, r_0, r_1, r_2, r_3, r_4, r_5, r_6, r_7, rf_d3: std_logic_vector(15 downto 0);
	signal state: std_logic_vector(4 downto 0);
	signal opcode: std_logic_vector(3 downto 0);
	signal z, rf_write_in: std_logic;
	signal rf_a1, rf_a2, rf_a3: std_logic_vector(2 downto 0); 

	
	begin
		Main_Data: component Datapath
			port map(clk, state, opcode, alu_Co, z);
			
		Main_FSM: component FSM
			port map(opcode, z, clk, state);
			
		Reg_file: component rf
		   port map(rf_write_in=>rf_write_in, rf_a1=>rf_a1, rf_a2=>rf_a2, rf_a3=>rf_a3, rf_d3=>rf_d3, clk=> clk, r0=>r_0, r1=>r_1, r2=>r_2, r3=>r_3, r4=>r_4, r5=>r_5, r6=>r_6, r7=>r_7);
			
		process(clk, reset, switch, ml_toggle, addmode)
		
		begin
		
		   if(addmode = "00") then
					
					if (ml_toggle = '0') then
			     
					 case switch(2 downto 0) is
					 
					 when "000" =>
				    output <= r_0(7 downto 0);
					 
					 when "001" =>
					 output <= r_1(7 downto 0);
					 
					 when "010" =>
					 output <= r_2(7 downto 0);
					 
					 when "011" =>
					 output <= r_3(7 downto 0);
					 
					 when "100" =>
					 output <= r_4(7 downto 0);
					 
					 when "101" =>
					 output <= r_5(7 downto 0);	 
					 
					 when "110" =>
					 output <= r_6(7 downto 0);
					 
					 when "111" =>
					 output <= r_7(7 downto 0);
					 
					 end case;
					 
					 else
					 
					 case switch(2 downto 0) is
					 
					 when "000" =>
				    output <= r_0(15 downto 8);
					 
					 when "001" =>
					 output <= r_1(15 downto 8);
					 
					 when "010" =>
					 output <= r_2(15 downto 8);
					 
					 when "011" =>
					 output <= r_3(15 downto 8);
					 
					 when "100" =>
					 output <= r_4(15 downto 8);
					 
					 when "101" =>
					 output <= r_5(15 downto 8);	 
					 
					 when "110" =>
					 output <= r_6(15 downto 8);
					 
					 when "111" =>
					 output <= r_7(15 downto 8);
					 
					 end case;
					 
					 end if;
					 end if;
					 
					 end process;
						 
					 
					 
			   
			   
end architecture;