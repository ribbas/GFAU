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
    generic(
        n           : positive := 8
    );
    port(
        poly_bcd    : in std_logic_vector(n downto 0);  -- BCD polynomial
        mask        : out std_logic_vector(n downto 0) := (others => '0')
   );
end varmask;

architecture structural of varmask is

    constant DCAREVEC : std_logic_vector(n downto 0) := (others => '-');

begin

    mask <= "011111111" when (poly_bcd(8) = '1') else   -- 8
            "001111111" when (poly_bcd(7) = '1') else   -- 7
            "000111111" when (poly_bcd(6) = '1') else   -- 6
            "000011111" when (poly_bcd(5) = '1') else   -- 5
            "000001111" when (poly_bcd(4) = '1') else   -- 4
            "000000111" when (poly_bcd(3) = '1') else   -- 3
            "000000011" when (poly_bcd(2) = '1') else   -- 2
            DCAREVEC;                                   -- under 2

end structural;
