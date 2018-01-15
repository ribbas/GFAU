
-- or3.vhd

-- Sabbir Ahmed
-- 2018-01-14


--or3.vhd

library std;
library ieee;
use ieee.std_logic_1164.all;

entity or3 is
    port(
        in1     :   in  std_logic;
        in2     :   in  std_logic;
        in3     :   in  std_logic;
        out1    :   out std_logic
    );
end or3;

architecture structural of or3 is
begin

    out1 <= in1 or in2 or in3;

end structural;
