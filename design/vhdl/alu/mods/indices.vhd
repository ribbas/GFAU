-- indices.vhd
--
-- Sabbir Ahmed
-- 2018-01-16
--
-- Generates the index of the size.
--

library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;
library work;
    use work.demo.all;

entity indices is
    generic(
        n           : positive := DEGREE;
        clgn        : positive := CEILLGN;  -- ceil(log2(n))
        clgn1       : positive := CEILLGN1   -- ceil(log2(n - 1))
    );
    port(
        poly_bcd    : in std_logic_vector(n downto 0);  -- BCD polynomial
        size        : out std_logic_vector(clgn downto 0); -- size
        msb         : out std_logic_vector(clgn1 downto 0)    -- msb
    );
end indices;

architecture structural of indices is

    signal prio_enc : std_logic_vector(clgn downto 0) := (others => '-');

begin

    prio_enc <= "1000" when (poly_bcd(8) = '1') else   -- 8
                "0111" when (poly_bcd(7) = '1') else   -- 7
                "0110" when (poly_bcd(6) = '1') else   -- 6
                "0101" when (poly_bcd(5) = '1') else   -- 5
                "0100" when (poly_bcd(4) = '1') else   -- 4
                "0011" when (poly_bcd(3) = '1') else   -- 3
                "0010" when (poly_bcd(2) = '1') else   -- 2
                DCAREVEC(clgn downto 0);               -- under 2

    size <= prio_enc;
    msb <= std_logic_vector(unsigned(prio_enc(clgn1 downto 0)) - 1);

end structural;
