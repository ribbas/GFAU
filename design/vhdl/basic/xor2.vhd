library std;
library ieee;
use ieee.std_logic_1164.all;

entity xor2 is
    port(
        in1     :   in  std_logic;
        in2     :   in  std_logic;
        out1    :   out std_logic
    );
end xor2;

architecture structural of xor2 is
begin

    out1 <= in1 xor in2;

end structural;
