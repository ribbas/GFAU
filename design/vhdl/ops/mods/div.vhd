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
        n       : positive := 8,
        ceillgn : positive := 3
    );
    port(
        i       : in std_logic_vector(n downto 0); -- first element
        j       : in std_logic_vector(n downto 0); -- second element
        size    : in std_logic_vector(ceillgn downto 0);  -- size of element
        quot    : out std_logic_vector(n downto 0) -- quotient of elements
    );
end div;

architecture structural of div is

    -- CLA adder component
    component claadder16
        port(
            a   : in std_logic_vector (n downto 0);
            b   : in std_logic_vector (n downto 0);
            s   : out std_logic_vector (n downto 0)
        );
    end component;

    signal sumij : std_logic_vector(n downto 0);
    signal sumij1 : std_logic_vector(n downto 0);

begin

    -- sum(i, neg_j)
    cla1 : claadder16 port map(
        i,                  -- first element
        j,                  -- masked two's complement of j
        sumij               -- sum of i and j
    );

    -- sum(i, neg_j, 1)
    cla2 : claadder16 port map(
        sumij,              -- sum of i and j
        "1111111111111111", -- 16-bit negative 1
        sumij1              -- sum of i and j and 1
    );

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
