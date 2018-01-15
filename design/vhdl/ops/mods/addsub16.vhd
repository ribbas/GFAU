
-- addsub16.vhd

-- Sabbir Ahmed
-- 2018-01-14


library ieee;
use ieee.std_logic_1164.all;

entity addsub16 is
    port ( 
        i     : in  std_logic_vector (15 downto 0);
        j     : in  std_logic_vector (15 downto 0);
        bitxor  : out  std_logic_vector (15 downto 0)
    );
end addsub16;

architecture structural of addsub16 is

begin

    bitxor <= i xor j;

end structural;
