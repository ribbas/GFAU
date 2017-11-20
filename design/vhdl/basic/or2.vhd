--and.vhd

library std;
library ieee;
use ieee.std_logic_1164.all;

entity or2 is
    port(
        in1     :   in  std_logic;
        in2     :   in  std_logic;
        out1    :   out std_logic
    );
end or2;

architecture structural of or2 is
begin

    out1 <= in1 or in2;

end structural;
