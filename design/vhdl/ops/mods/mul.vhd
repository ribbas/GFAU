-- mul.vhd
--
-- Sabbir Ahmed, Jeffrey Osazuwa
-- 2018-01-16
--
-- Computes the Galois multiplication of two symbols.
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mul is
    generic(
        n       : positive := 8;
        clgn    : positive := 3
    );
    port(
        i       : in std_logic_vector(n downto 0); -- first element
        j       : in std_logic_vector(n downto 0); -- second element
        size    : in std_logic_vector(clgn downto 0);  -- size of element
        prod    : out std_logic_vector(n downto 0) -- product of elements
    );
end mul;

architecture structural of mul is

    signal sumij : std_logic_vector(n downto 0);
    signal sumij1 : std_logic_vector(n downto 0);

begin

    sumij <= std_logic_vector(unsigned(i) + unsigned(j));
    sumij1 <= std_logic_vector(unsigned(sumij) + 1);

    process (size, sumij, sumij1)
    begin

        -- if (OF(i + j) or OF(i + j + 1) == 0)
        if ((sumij(to_integer(unsigned(size))) or
            sumij1(to_integer(unsigned(size)))) = '0') then

            -- prod = i + j
            prod <= sumij;

        else

            -- prod = i + j + 1
            prod <= sumij1;

        end if;

    end process;

end structural;
