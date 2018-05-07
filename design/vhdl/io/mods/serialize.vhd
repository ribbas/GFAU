----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:08:56 04/27/2018 
-- Design Name: 
-- Module Name:    serialize - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity serialize is
port(
    clk         :   in  std_logic;
    enable      :   in  std_logic;
    rst         :   in  std_logic;
    in_data     :   in  std_logic_vector(15 downto 0); --from gfau
    count       :   in  std_logic_vector(1 downto 0);
    bus_size    :   in  std_logic_vector(1 downto 0);
    num_clks    :   in  std_logic_vector(1 downto 0);
    done        :   out std_logic;
    out_data    :   out std_logic_vector(15 downto 0) --to extern device
);
end serialize;

architecture Behavioral of serialize is

    signal output_reg   :   std_logic_vector(15 downto 0); --reg to extern dev

begin

    out_data <= output_reg;

    ser :   process(clk)
    begin
        if (falling_edge(clk) and (enable = '1') and (rst = '0')) then
        
            if (bus_size = "00") then -- 8 bit bus
            
                if (num_clks = "00") then -- 8 bit data, 1 clock
                
                    output_reg(7 downto 0) <= in_data(7 downto 0);
                    done <= '1'; --finished taking input
                    
                else -- 8 bit data, 2 clocks
                
                    if (count = "00") then -- part 1
                        output_reg(7 downto 0) <= in_data(7 downto 0);
                    else  -- part 2
                        output_reg(7 downto 0) <= in_data(15 downto 8);
                        done <= '1';
                    end if;
                    
                end if;
                
            else --16 bit bus or bigger
                
                output_reg <= in_data;
                done <= '1';
                
            end if;
            
        elsif falling_edge(clk) and (rst = '1') then -- synchronous reset
        
            done <= '0';
            
        end if;
    end process ser;
end Behavioral;

