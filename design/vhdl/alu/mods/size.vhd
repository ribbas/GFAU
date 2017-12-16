library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity size is
    port(
        poly_bcd    : in std_logic_vector (15 downto 0);  -- BCD polynomial
        n           : out std_logic_vector(3 downto 0)    -- size of element
   );
end size;

architecture structural of size is

begin

    n <=    "1111" when (poly_bcd(15) = '1') else  -- 15
            "1110" when (poly_bcd(14) = '1') else  -- 14
            "1101" when (poly_bcd(13) = '1') else  -- 13
            "1100" when (poly_bcd(12) = '1') else  -- 12
            "1011" when (poly_bcd(11) = '1') else  -- 11
            "1010" when (poly_bcd(10) = '1') else  -- 10
            "1001" when (poly_bcd(9) = '1') else   -- 9
            "1000" when (poly_bcd(8) = '1') else   -- 8
            "0111" when (poly_bcd(7) = '1') else   -- 7
            "0110" when (poly_bcd(6) = '1') else   -- 6
            "0101" when (poly_bcd(5) = '1') else   -- 5
            "0100" when (poly_bcd(4) = '1') else   -- 4
            "0011" when (poly_bcd(3) = '1') else   -- 3
            "0010" when (poly_bcd(2) = '1') else   -- 2
            "XXXX";                                -- under 2

end structural;
