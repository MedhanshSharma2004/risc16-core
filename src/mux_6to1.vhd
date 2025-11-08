library ieee;
use ieee.std_logic_1164.all;

entity mux_6to1 is
    port (
        s1, s8, s2, s3, s4, s5: in std_logic_vector(15 downto 0);
		  enable: in std_logic;
        Sel: in std_logic_vector(3 downto 0);
        Output: out std_logic_vector(15 downto 0)
    );
end entity mux_6to1;

architecture behavioral of mux_6to1 is
begin
    process(Sel, s1, s8, s2, s3, s4, s5)
    begin
	     if(enable= '0') then
		     output <= "0000000000000000";
		  
		  else   
        case Sel is
            when "0000" =>
                Output <= s1;
            when "0010" =>
                Output <= s8;
            when "0100" =>
                Output <= s2;
            when "0011" =>
                Output <= s3;
            when "0101" =>
                Output <= s4;
            when "0110" =>
                Output <= s5;
				when others =>
                Output <= "1111111111111111";
        end case;
		  end if;
    end process;
end architecture behavioral;
