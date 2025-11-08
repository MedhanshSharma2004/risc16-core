library ieee;
use ieee.std_logic_1164.all;

entity DataPath is
	port(
			clk: in std_logic; state: in std_logic_vector(4 downto 0); 
			opcode: out std_logic_vector(3 downto 0);
			alu_Co: out std_logic_vector(15 downto 0);
			z_out: out std_logic
		 );
end entity Datapath;

architecture trivial of DataPath is
	
	signal t1_in, t1_out, t2_in, t2_out, t3_in, t3_out, rf_d1, rf_d2, rf_d3, m_a, m_in,  alu_a, alu_b, m_out, alu_c, l8_in, l8_out, se7_out, se10_out: std_logic_vector(15 downto 0):=(others=>'0');
	signal rf_a1, rf_a2, rf_a3: std_logic_vector(2 downto 0):=(others=>'0');
	signal alu_ctrl: std_logic_vector(3 downto 0);
	signal z_flag, rf_write, enable_1, enable_2, enable_3, enable_4, m_wr: std_logic;
	signal se7_in: std_logic_vector(8 downto 0):="000000000";
	signal se10_in: std_logic_vector(5 downto 0):="000000";
	signal ir_in, ir_out: std_logic_vector(15 downto 0);
	signal op_code: std_logic_vector(3 downto 0):= ir_out(15 downto 12);
	signal alu_enable: std_logic;
	
	
		
	--Represents id for each state we we using
	constant s0  : std_logic_vector(4 downto 0):= "00000";  
	constant s1  : std_logic_vector(4 downto 0):= "00001";  
	constant s2  : std_logic_vector(4 downto 0):= "00010";
	constant s3  : std_logic_vector(4 downto 0):= "00011";
	constant s4  : std_logic_vector(4 downto 0):= "00100";
	constant s5  : std_logic_vector(4 downto 0):= "00101";
	constant s6  : std_logic_vector(4 downto 0):= "00110";
	constant s7  : std_logic_vector(4 downto 0):= "00111";
	constant s8  : std_logic_vector(4 downto 0):= "01000";
	constant s9  : std_logic_vector(4 downto 0):= "01001";  
	constant s10 : std_logic_vector(4 downto 0):= "01010";
	constant s11 : std_logic_vector(4 downto 0):= "01011";
	constant s12 : std_logic_vector(4 downto 0):= "01100";
	constant s13 : std_logic_vector(4 downto 0):= "01101";
	constant s14 : std_logic_vector(4 downto 0):= "01110";
	constant s15 : std_logic_vector(4 downto 0):= "01111";
	constant s16 : std_logic_vector(4 downto 0):= "10000";
	constant s17 : std_logic_vector(4 downto 0):= "10001";
	constant s5a : std_logic_vector(4 downto 0):= "10010";
	constant s7a : std_logic_vector(4 downto 0):= "10011";
	constant s7b : std_logic_vector(4 downto 0):= "10100";

	
component T_reg is
	port (input:in std_logic_vector(15 downto 0);
			w_enable, clk: in std_logic;
			output: out std_logic_vector(15 downto 0));
end component T_reg;

component rf is 
	port (rf_write_in, clk: in std_logic;
	      rf_a1, rf_a2, rf_a3: in std_logic_vector(2 downto 0); 
	      rf_d3: in std_logic_vector(15 downto 0);
		   rf_d1, rf_d2: out std_logic_vector(15 downto 0) 
			);
end component;


component sign_extend7 is
	port (ip: in std_logic_vector(8 downto 0); 
	      ex_op: out std_logic_vector(15 downto 0));
end component sign_extend7;

component sign_extend10 is
	port (ip: in std_logic_vector(5 downto 0); 
	      ex_op: out std_logic_vector(15 downto 0)
			);
end component sign_extend10;

component Lshifter8 is
	port (inp : in std_logic_vector (15 downto 0);
			outp : out std_logic_vector (15 downto 0));
end component LShifter8;

component Memory is 
	port (clk, m_wr: in std_logic; 
			mem_addr, mem_in: in std_logic_vector(15 downto 0);
			mem_out: out std_logic_vector(15 downto 0)); 
end component Memory;

component alu is
    port (ALU_A, ALU_B: in std_logic_vector(15 downto 0);
			Z_flag: out std_logic;
			alu_enable: in std_logic;
			Control: in std_logic_vector(3 downto 0);
			ALU_C: out std_logic_vector(15 downto 0));
end component alu;
	
	begin
		
		T1: T_reg port map(t1_in, enable_1, clk, t1_out);
		T2: T_reg port map(t2_in, enable_2, clk, t2_out);
		T3: T_reg port map(t3_in, enable_3, clk, t3_out);
		IR: T_reg port map(ir_in, enable_4, clk, ir_out);
		reg_file: rf port map(rf_write_in=>rf_write,clk=> clk,rf_a1=> rf_a1,rf_a2=> rf_a2,rf_a3=> rf_a3,rf_d3=>rf_d3,rf_d1=> rf_d1, rf_d2=>rf_d2);
		se7: sign_extend7 port map(se7_in, se7_out);	
		se10: sign_extend10 port map(se10_in, se10_out);
	   l8: Lshifter8 port map(l8_in, l8_out); 	
		mem: Memory port map(clk, m_wr, m_a, m_in, m_out);
		alu_comp: ALU port map(alu_a, alu_b, z_flag, alu_enable, alu_ctrl, alu_c);
			

		only_process: process(state, clk, t1_in, t2_in, enable_2,  enable_1, t3_in, enable_3, enable_4, ir_in, rf_write, rf_a1, rf_a2, rf_a3, rf_d3, rf_d1, rf_d2, se7_in, se10_in, l8_in,  m_wr,  m_a, m_in,alu_a, alu_b, alu_ctrl, z_flag)
		begin
			
			
			case state is
			   
				when s0 =>
				   rf_write<='0';
					m_wr<='0';
		
					enable_1<='0';
					enable_2<='0';
					enable_3<='0';
					enable_4<='0';
					alu_ctrl<="0000";
					alu_enable<='0';
					
				     
				when s1 =>
					--Data Flow
					rf_a1<="111";
					m_a<=rf_d1;
					ir_in <= m_out; 
				   opcode <= m_out(15 downto 12);
	
					
					--Control Signals
					rf_write<='0';
					m_wr<='0';
					--m_rd<='1';
					enable_1<='0';
					enable_2<='0';
					enable_3<='0';
					enable_4<='1';
					alu_ctrl<="0000";
					alu_enable<='0';

				when s2 =>
					--Data Flow
					rf_a1 <= ir_out(11 downto 9);
					rf_a2 <= ir_out(8 downto 6);
					t1_in<=rf_d1; 
					t2_in<=rf_d2;
					rf_a3<=ir_out(5 downto 3);
				

					
					--Control Signals
					rf_write<='0';
					m_wr<='0';
					--m_rd<='0';
					enable_1<='1';
					enable_2<='1';
					enable_4<='0';
					alu_ctrl<="0000";
					alu_enable<='0';
					
				when s3 =>
					--Data Flow
					op_code <= ir_out(15 downto 12);
					alu_a<=t1_out;
					alu_b<=t2_out;
					rf_a3<=ir_out(5 downto 3);
					rf_d3<=alu_c;
					
					
					--Control Signal
					rf_write<='1';
					m_wr<='0';
					--m_rd<='0';
					enable_1<='0';
					enable_2<='0';
					enable_3<='1';
					enable_4<='0';
					alu_enable<='1';


--					
               if op_code = "0000" or op_code = "0010" or op_code = "0011" or op_code = "0100" or op_code = "0101" or op_code = "0110" then
					alu_ctrl <= op_code;
					end if;
					
				when s4 =>
					--Data Flow
					rf_a1 <= "111";
					alu_a<=rf_d1;
					alu_b<="0000000000000001";	
			      rf_a3<="111";		
					rf_d3<=alu_c;

					
					--Control Signals
					rf_write<='1';
					m_wr<='0';
					--m_rd<='0';
					enable_1<='0';
					enable_2<='0';
					enable_3<='0';
					enable_4<='0';
					alu_ctrl<="0000";
					alu_enable<='1';
					
				when s5 =>
					--Data Flow
					rf_a1 <= ir_out(11 downto 9);
					t1_in<=rf_d1; 
					se10_in <= ir_out(5 downto 0);
					t2_in<=se10_out;
					rf_a3<=ir_out(8 downto 6);

					
					--Control Signals
					rf_write<='0';
					m_wr<='0';
					--m_rd<='0';
					enable_1<='1';
					enable_2<='1';
					enable_3<='0';
					enable_4<='0';
					alu_ctrl<="0000";
					alu_enable<='0';
					
				when s5a =>
					--Data Flow
					alu_a<=t1_out;
					alu_b<=t2_out;
					rf_a3<=ir_out(8 downto 6);
					rf_d3<=alu_c;

					
					--Control Signals
					rf_write<='1';
					m_wr<='0';
					--m_rd<='0';
					enable_1<='0';
					enable_2<='0';
					enable_3<='1';
					enable_4<='0';
					alu_ctrl<="0000";
					alu_enable<='1';
					
					
				when s6 =>
					--Data Flow
					se7_in <= ir_out(8 downto 0);
					t1_in <= se7_out;
					rf_a3 <= ir_out(11 downto 9);
					rf_d3 <= t1_out;
					
					
					--Control Signals
					rf_write<='1';
					m_wr<='0';
					--m_rd<='0';
					enable_1<='1';
					enable_2<='0';
					enable_3<='0';
					enable_4<='0';
					alu_ctrl<="0000";
					alu_enable<='0';
				
					
				when s7 =>
					--Data Flow
					se7_in <= ir_out(8 downto 0);
					l8_in <= se7_out;
					t1_in<= l8_out;
					rf_a3 <= ir_out(11 downto 9);
					

					
					--Control Signals
					rf_write<='1';
					m_wr<='0';
					--m_rd<='0';
					enable_1<='1';
					enable_2<='0';
					enable_3<='0';
					enable_4<='0';
					alu_ctrl<="0000";
					alu_enable<='0';
					
				
				when s7b =>
					--Data Flow
					rf_d3 <= t1_out;
					
					--Control Signals
					rf_write<='1';
					m_wr<='0';
					--m_rd<='0';
					enable_1<='0';
					enable_2<='0';
					enable_3<='0';
					enable_4<='0';
					alu_ctrl<="0000";
					alu_enable<='0';
					
				
				when s7a =>
					--Data Flow
					se7_in <= ir_out(8 downto 0);
--					l8_in <= se7_out;
					--t1_in<= l8_out;
					rf_a3 <= ir_out(11 downto 9);
					t1_in <= se7_out;
					

					
					--Control Signals
					rf_write<='1';
					m_wr<='0';
					--m_rd<='0';
					enable_1<='1';
					enable_2<='0';
					enable_3<='0';
					enable_4<='0';
					alu_ctrl<="0000";
					alu_enable<='0';
			
					
				when s8 =>
					--Data Flow
					rf_a1 <= ir_out(11 downto 9);
					rf_a2 <= ir_out(8 downto 6);
					t1_in <= rf_d1;
					t2_in <= rf_d2;

					
					--Control Signals
					rf_write<='0';
					m_wr<='0';
					--m_rd<='0';
					enable_1<='1';
					enable_2<='1';
					enable_3<='0';
					enable_4<='0';
					alu_ctrl<="0000";
					alu_enable<='0';
			
					
				when s9 =>
					--Data Flow
					rf_a1 <= "111";
					ALu_A <= t1_out;
					ALU_B <= t2_out;
					ALU_A <= rf_d1;
				   se10_in <= ir_out(5 downto 0);
					ALU_B <= se10_out;
					rf_a3 <="111";
					rf_d3 <= ALU_C;
					
					
					
					--Control Signals
					rf_write<='1';
					m_wr<='0';
					--m_rd<='0';
					enable_1<='0';
					enable_2<='0';
					enable_3<='0';
					enable_4<='0';
					alu_ctrl<="0000";
					alu_enable<='1';
					
					
				when s10 =>
					--Data Flow
					rf_a1 <= "111";
					ALu_A <= t1_out;
					ALU_B <= t2_out;
					ALU_A <= rf_d1;
					ALU_B <= "0000000000000001";
					rf_a3<="111";
					rf_d3 <= ALU_C;

					
					--Control Signals
					rf_write<='1';
					m_wr<='0';
					--m_rd<='0';
					enable_1<='0';
					enable_2<='0';
					enable_3<='0';
					enable_4<='0';
					alu_ctrl<="0000";
					alu_enable<='1';
					
				when s11 =>
					--Data Flow
					rf_a1 <= "111";
					rf_a3 <= ir_out(11 downto 9);
				   rf_d3 <= rf_d1;	
					t1_in <= rf_d1;
					se10_in <= ir_out(5 downto 0);
					t2_in <= se10_out;
					

					--Control Signals
					rf_write<='1';
					m_wr<='0';
					--m_rd<='0';
					enable_1<='1';
					enable_2<='1';
					enable_3<='0';
					enable_4<='0';
					alu_ctrl<="0000";
					alu_enable<='0';
					
				when s12 =>
					--Data Flow
					ALU_A <= t1_out;
					ALU_B <= t2_out;
					rf_a3 <= "111";
					rf_d3 <= ALU_C;

					
					--Control Signals
					rf_write<='1';
					m_wr<='0';
					--m_rd<='0';
					enable_1<='0';
					enable_2<='0';
					enable_3<='0';
					enable_4<='0';
					alu_ctrl<="0000";
					alu_enable<='1';
					
	
				when s16 =>
					--Data Flow
				   rf_a3 <= ir_out(11 downto 9);
					rf_d3 <= m_out;
					
					--Control Signals
					rf_write<='1';
					m_wr<='0';
					--m_rd<='1';
					enable_1<='0';
					enable_2<='0';
					enable_3<='0';
					enable_4<='0';
					alu_ctrl<="0000";
					alu_enable<='0';
					
				when s17 =>
					--Data Flow
					rf_a1 <= ir_out(11 downto 9);
					m_in <= rf_d1;
--					m_in <= t1_out;
--               rf_a1 <= "111";
--					alu_a<=rf_d1;
--					alu_b<="0000000000000001";	
--			      rf_a3<="111";		
--					rf_d3<=alu_c;
               
					
					
					--Control Signals
					rf_write<='0';
					m_wr<='1';
					--m_rd<='1';
					enable_1<='1';
					enable_2<='0';
					enable_3<='0';
					enable_4<='0';
					alu_ctrl<="0000";
					alu_enable<='0';
					
				when s15 =>
					--Data Flow
					rf_a2 <= ir_out(8 downto 6);
					alu_b <= rf_d2;
					se10_in <= ir_out(5 downto 0);
					alu_a <= se10_out;
					m_a <= ALU_C;
					
					--Control Signals
					rf_write<='0';
					m_wr<='0';
					--m_rd<='0';
					enable_1<='1';
					enable_2<='0';
					enable_3<='0';
					enable_4<='0';
					alu_ctrl<="0000";
					alu_enable<='1';
					
            			
				when s13 =>
					--Data Flow
					rf_a1 <= "111";
					rf_a3 <= ir_out(11 downto 9);
					rf_d3 <= rf_d1;
					
					--Control Signals
					rf_write<='1';
					m_wr<='0';
					--m_rd<='0';
					enable_1<='0';
					enable_2<='0';
					enable_3<='0';
					enable_4<='0';
					alu_ctrl<="0000";
					alu_enable<='0';
					
					
				when s14 =>
					--Data Flow
					rf_a1 <= ir_out(8 downto 6);
					rf_a3 <= "111";
					rf_d3 <= rf_d1;
					
					--Control Signals
					rf_write<='1';
					m_wr<='0';
					--m_rd<='0';
					enable_1<='0';
					enable_2<='0';
					enable_3<='0';
					enable_4<='0';
					alu_ctrl<="0000";
					alu_enable<='0';
					
				when others =>
				--Control Signals
					rf_write<='0';
					m_wr<='0';
					--m_rd<='0';
					enable_1<='0';
					enable_2<='0';
					enable_3<='0';
					enable_4<='0';
					alu_ctrl<="0000";
					alu_enable<='0';
					

			end case;
		end process;
		
		alu_Co<=alu_c(15 downto 0);
		z_out <= z_flag;
	
end architecture trivial;