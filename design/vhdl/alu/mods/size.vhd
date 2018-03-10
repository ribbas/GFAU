-- size.vhd
--
-- Sabbir Ahmed
-- 2018-01-16
--
-- Generates the index of the size.
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity size is
    port(
        poly_bcd    : in std_logic_vector (8 downto 0);  -- BCD polynomial
        n           : out std_logic_vector(3 downto 0)    -- size of element
   );
end size;

architecture structural of size is

begin

    n <=    "1000" when (poly_bcd(8) = '1') else   -- 8
            "0111" when (poly_bcd(7) = '1') else   -- 7
            "0110" when (poly_bcd(6) = '1') else   -- 6
            "0101" when (poly_bcd(5) = '1') else   -- 5
            "0100" when (poly_bcd(4) = '1') else   -- 4
            "0011" when (poly_bcd(3) = '1') else   -- 3
            "0010" when (poly_bcd(2) = '1') else   -- 2
            "XXXX";                                -- under 2

end structural;
