-- div.vhd
--
-- Sabbir Ahmed
-- 2018-01-16
--
-- Computes the Galois division of two symbols.
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity div is
    generic(
        n       : positive := 8;
        clgn    : positive := 3
    );
    port(
        i       : in std_logic_vector(n downto 0); -- first element
        j       : in std_logic_vector(n downto 0); -- second element
        size    : in std_logic_vector(clgn downto 0);  -- size of element
        quot    : out std_logic_vector(n downto 0) -- quotient of elements
    );
end div;

architecture structural of div is

    signal sumij : std_logic_vector(n downto 0);
    signal sumij1 : std_logic_vector(n downto 0);
    constant HIVEC : std_logic_vector(n downto 0) := (others => '1');

begin

    sumij <= std_logic_vector(unsigned(i) + unsigned(j));
    sumij1 <= std_logic_vector(unsigned(sumij) + unsigned(HIVEC));

    process (size, sumij, sumij1)
    begin

        -- if OF(i + two's-comp(j)) == 1
        if (sumij(to_integer(unsigned(size))) = '1') then

            -- quot = i + two's-cmp(j)
            quot <= sumij;

        else

            -- quot = i + two's-cmp(j) + two's-cmp(1)
            quot <= sumij1;

        end if;

    end process;

end structural;
