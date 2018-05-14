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
library work;
    use work.glob.all;

entity varmask is
    generic(
        n           : positive := DEGREE
    );
    port(
        poly_bcd    : in std_logic_vector(n downto 1);  -- BCD polynomial
        mask        : out std_logic_vector(n downto 0) := (others => '0')
    );
end varmask;

architecture behavioral of varmask is
begin

    mask <= "11111111" when (poly_bcd(7) = '1') else   -- 8
            "01111111" when (poly_bcd(6) = '1') else   -- 7
            "00111111" when (poly_bcd(5) = '1') else   -- 6
            "00011111" when (poly_bcd(4) = '1') else   -- 5
            "00001111" when (poly_bcd(3) = '1') else   -- 4
            "00000111" when (poly_bcd(2) = '1') else   -- 3
            "00000011" when (poly_bcd(1) = '1') else   -- 2
            DCAREVEC;                                  -- under 2

end behavioral;
