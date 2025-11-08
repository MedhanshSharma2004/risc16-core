library ieee;
use ieee.std_logic_1164.all;

entity alu is
    port (
        ALU_A, ALU_B: in std_logic_vector(15 downto 0);
		  Z_flag: out std_logic;
		  alu_enable: in std_logic;
        Control: in std_logic_vector(3 downto 0);
        ALU_C: out std_logic_vector(15 downto 0)
    );
end entity alu;

architecture struct of ALU is
    component adder_16_bit is
        port (
            A, B: in std_logic_vector(15 downto 0);
            S: out std_logic_vector(15 downto 0);
            Cout: out std_logic
        );
    end component;

    component sub_16_bit is
        port (
            A, B: in std_logic_vector(15 downto 0);
            S: out std_logic_vector(15 downto 0);
            Cout: out std_logic
        );
    end component;

    component and_16_bit is
        port (
            A, B: in std_logic_vector(15 downto 0);
            C: out std_logic_vector(15 downto 0)
        );
    end component and_16_bit;

    component or_16_bit is
        port (
            A, B: in std_logic_vector(15 downto 0);
            C: out std_logic_vector(15 downto 0)
        );
    end component or_16_bit;

    component imp_16_bit is
        port (
            A, B: in std_logic_vector(15 downto 0);
            C: out std_logic_vector(15 downto 0)
        );
    end component imp_16_bit;

    component mul_16_bit is
        port (
            A, B: in std_logic_vector(15 downto 0);
            C: out std_logic_vector(15 downto 0)
        );
    end component mul_16_bit;
	 
   component mux_6to1 is
    port (
        s1, s8, s2, s3, s4, s5: in std_logic_vector(15 downto 0);
		  enable: in std_logic;
        Sel: in std_logic_vector(3 downto 0);
        Output: out std_logic_vector(15 downto 0)
    );
end component mux_6to1;

    signal s1, s2, s3, s4, s8: std_logic_vector(15 downto 0);
    signal s6, s7: std_logic;
    signal s5: std_logic_vector(15 downto 0);
begin
    add_instance: adder_16_bit
        port map (
            A => ALU_A, B => ALU_B, S => s1, Cout => s6
        );
    sub_instance: sub_16_bit
        port map (
            A => ALU_A, B => ALU_B, S => s8, Cout => s7
        );
    and_instance: and_16_bit
        port map (
            A => ALU_A, B => ALU_B, C => s2
        );
    imp_16_instance: imp_16_bit
        port map (
            A => ALU_A, B => ALU_B, C => s3
        );

    or_16_instance: or_16_bit
        port map (
            A => ALU_A, B => ALU_B, C => s4
        );
 
    mul_16_instance: mul_16_bit
        port map (
            A => ALU_A, B => ALU_B, C => s5
        );
		  
    mux_6x1_instance: mux_6to1
	     port map (s1 => s1, s8 => s8, s2 => s2, s3 => s3, s4 => s4, s5 => s5, enable=> alu_enable, Sel => Control, Output => ALU_C
		  ); 

	
	Z_flag <= s8(15) or s8(14) or s8(13) or s8(12) or s8(11) or s8(10)  or s8(9)  or s8(8)  or s8(7)  or s8(6)  or s8(5)  or s8(4)  or s8(3)  or s8(2)  or s8(1)  or s8(0);  
	

end architecture struct;
