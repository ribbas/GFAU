--inverter.vhd

library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity inverter is

port (
    
    in1     :   in  std_logic;
    out1    :   out std_logic);

end inverter;

architecture structural of inverter is

begin

    out1 <= not in1;

end structural;