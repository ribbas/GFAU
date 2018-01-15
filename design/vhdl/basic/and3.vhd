
-- and3.vhd

-- Sabbir Ahmed
-- 2018-01-14


--and3.vhd

library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity and3 is

port (
    in1     :   in  std_logic;
    in2     :   in  std_logic;
	 in3     :   in  std_logic;
    out1    :   out std_logic);
end and3;

architecture structural of and3 is

begin

    out1 <= in1 and in2 and in3;

end structural;