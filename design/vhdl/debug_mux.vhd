----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:04:55 05/17/2018 
-- Design Name: 
-- Module Name:    debug_mux - Behavioral 
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

entity debug_mux is
port(
    in1     :   in  std_logic_vector(7 downto 0);
    in2     :   in  std_logic_vector(7 downto 0);
    in3     :   in  std_logic_vector(7 downto 0);
    in4     :   in  std_logic_vector(7 downto 0);
    in5     :   in  std_logic_vector(7 downto 0);
    in6     :   in  std_logic_vector(7 downto 0);
    in7     :   in  std_logic_vector(7 downto 0);
    in8     :   in  std_logic_vector(7 downto 0);
    sel     :   in  std_logic_vector(2 downto 0);
    op      :   out std_logic_vector(7 downto 0)
);
end debug_mux;

architecture Behavioral of debug_mux is

begin

    mux :   process(in1, in2, in3, in4, in5, in6, in7, in8, sel)
    begin
        case(sel) is 
           when "000" =>
                op <= in1;
           when "001" =>
                op <= in2;                
           when "010" =>
                op <= in3;                
           when "011" =>
                op <= in4;    
           when "100" =>
                op <= in5;
           when "101" =>
                op <= in6;
           when "110" =>
                op <= in7;
           when "111" =>
                op <= in8;  
           when others =>
                op <= in1;
        end case;
    end process mux;

end Behavioral;

