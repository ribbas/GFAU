library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity msb is
    port(
        poly_bcd    : in std_logic_vector (15 downto 0);  -- BCD polynomial
        m           : out std_logic_vector(3 downto 0)    -- msb of element
   );
end msb;

architecture structural of msb is

begin

    m <=    "1110" when (poly_bcd(15) = '1') else  -- 15
            "1101" when (poly_bcd(14) = '1') else  -- 14
            "1100" when (poly_bcd(13) = '1') else  -- 13
            "1011" when (poly_bcd(12) = '1') else  -- 12
            "1010" when (poly_bcd(11) = '1') else  -- 11
            "1001" when (poly_bcd(10) = '1') else  -- 10
            "1000" when (poly_bcd(9) = '1') else   -- 9
            "0111" when (poly_bcd(8) = '1') else   -- 8
            "0110" when (poly_bcd(7) = '1') else   -- 7
            "0101" when (poly_bcd(6) = '1') else   -- 6
            "0100" when (poly_bcd(5) = '1') else   -- 5
            "0011" when (poly_bcd(4) = '1') else   -- 4
            "0010" when (poly_bcd(3) = '1') else   -- 3
            "0001" when (poly_bcd(2) = '1') else   -- 2
            "XXXX";                                -- under 2

end structural;
