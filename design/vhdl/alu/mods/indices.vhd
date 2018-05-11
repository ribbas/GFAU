-- indices.vhd
--
-- Sabbir Ahmed
-- 2018-01-16
--
-- Generates the indices of the size and the MSB
--

library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;
library work;
    use work.glob.all;

entity indices is
    generic(
        n           : positive := DEGREE;
        clgn1       : positive := CEILLGN1   -- ceil(log2(n - 1))
    );
    port(
        size        : in std_logic_vector(clgn1 downto 0);  -- size
        msb         : out std_logic_vector(clgn1 downto 0)  -- msb
    );
end indices;

architecture behavioral of indices is

begin

    msb <= std_logic_vector(unsigned(size) - 1);

end behavioral;
