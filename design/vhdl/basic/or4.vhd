-- or4.vhd
--
-- Sabbir Ahmed
-- 2018-01-16
--
--
--

library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity or4 is

port (
    in1     :   in  std_logic;
    in2     :   in  std_logic;
    in3     :   in  std_logic;
    in4     :   in  std_logic;
    out1    :   out std_logic);
end or4;

architecture structural of or4 is

begin

    out1 <= in1 or in2 or in3 or in4;

end structural;
