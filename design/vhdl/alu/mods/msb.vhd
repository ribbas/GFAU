-- msb.vhd
--
-- Sabbir Ahmed
-- 2018-01-16
--
-- Generates the index of the most significant bit.
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity msb is
    port(
        poly_bcd    : in std_logic_vector (8 downto 0);  -- BCD polynomial
        m           : out std_logic_vector(2 downto 0)    -- msb of element
   );
end msb;

architecture structural of msb is

begin

    m <=    "111" when (poly_bcd(8) = '1') else   -- 8
            "110" when (poly_bcd(7) = '1') else   -- 7
            "101" when (poly_bcd(6) = '1') else   -- 6
            "100" when (poly_bcd(5) = '1') else   -- 5
            "011" when (poly_bcd(4) = '1') else   -- 4
            "010" when (poly_bcd(3) = '1') else   -- 3
            "001" when (poly_bcd(2) = '1') else   -- 2
            "XXX";                                -- under 2

end structural;
