-- varmask.vhd
--
-- Sabbir Ahmed
-- 2018-01-16
--
-- Generates the mask.
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity varmask is
    port(
        poly_bcd    : in std_logic_vector (15 downto 0);  -- BCD polynomial
        mask        : out std_logic_vector (15 downto 0) := (others => '0')
   );
end varmask;

architecture structural of varmask is

begin

    mask <= "0111111111111111" when (poly_bcd(15) = '1') else  -- 15
            "0011111111111111" when (poly_bcd(14) = '1') else  -- 14
            "0001111111111111" when (poly_bcd(13) = '1') else  -- 13
            "0000111111111111" when (poly_bcd(12) = '1') else  -- 12
            "0000011111111111" when (poly_bcd(11) = '1') else  -- 11
            "0000001111111111" when (poly_bcd(10) = '1') else  -- 10
            "0000000111111111" when (poly_bcd(9) = '1') else   -- 9
            "0000000011111111" when (poly_bcd(8) = '1') else   -- 8
            "0000000001111111" when (poly_bcd(7) = '1') else   -- 7
            "0000000000111111" when (poly_bcd(6) = '1') else   -- 6
            "0000000000011111" when (poly_bcd(5) = '1') else   -- 5
            "0000000000001111" when (poly_bcd(4) = '1') else   -- 4
            "0000000000000111" when (poly_bcd(3) = '1') else   -- 3
            "0000000000000011" when (poly_bcd(2) = '1') else   -- 2
            "XXXXXXXXXXXXXXXX";                                -- under 2

end structural;
