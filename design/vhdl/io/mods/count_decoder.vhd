library STD;
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity count_decoder is
port(
    bus_size    :   in  std_logic_vector(1 downto 0);
    input_size  :   in  std_logic_vector(3 downto 0);
    gen_poly    :   in  std_logic;
    num_clks    :   out std_logic_vector(1 downto 0)
);
end count_decoder;

architecture Behavioral of count_decoder is

begin

    decoder : process(bus_size, input_size, gen_poly)
    begin
        if (bus_size = "00") then
        
            if(to_integer(unsigned(input_size)) < 5) then
                num_clks <= "00";
            elsif(to_integer(unsigned(input_size)) < 9) then
                if(gen_poly = '1') then
                    num_clks <= "00";
                else
                    num_clks <= "01";
                end if;
            elsif(to_integer(unsigned(input_size)) < 13) then
                if (gen_poly = '1') then
                    num_clks <= "01";
                else
                    num_clks <= "10";
                end if;
            else
                if (gen_poly = '1') then 
                    num_clks <= "01";
                else
                    num_clks <= "11";
                end if;
            end if;
        
        elsif (bus_size = "01") then
        
            if (to_integer(unsigned(input_size)) < 9) then
                num_clks <= "00";
            else
                if (gen_poly = '1') then
                    num_clks <= "00";
                else
                    num_clks <= "01";
                end if;
            end if;
            
        else
        
            num_clks <= "00";
            
        end if;
    end process Decoder;

end Behavioral;    
