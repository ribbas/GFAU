library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity div16 is
    port(
        i       : in std_logic_vector(15 downto 0); -- first element
        j       : in std_logic_vector(15 downto 0); -- second element
        n       : in std_logic_vector(3 downto 0);  -- size of element
        mask    : in std_logic_vector(15 downto 0); -- mask register
        quot    : out std_logic_vector(15 downto 0) -- quotient of elements
    );
end div16;

architecture structural of div16 is

    -- CLA adder component
    component claadder16
        port(
            a       : in std_logic_vector (15 downto 0);
            b       : in std_logic_vector (15 downto 0);
            s       : out std_logic_vector (15 downto 0)
        );
    end component;

    -- masked two's complement component
    component maskedtwoscmp
        port(
            num         : in std_logic_vector(15 downto 0);
            mask        : in std_logic_vector(15 downto 0);
            maskedtc    : out std_logic_vector(15 downto 0)
        );
    end component;

    signal neg_j    : std_logic_vector(15 downto 0) := (others => '0');
    signal neg_one16: std_logic_vector(15 downto 0) := "1111111111111111";
    signal sumij    : std_logic_vector(15 downto 0) := (others => '0');
    signal sumij1   : std_logic_vector(15 downto 0) := (others => '0');

begin

    mtc1    :   maskedtwoscmp port map(
                    j,              -- j
                    mask,           -- fixed mask
                    neg_j           -- masked two's complement of j
                );

    cla1    :   claadder16 port map(
                    i,              -- first element
                    neg_j,          -- masked two's complement of j
                    sumij           -- sum of i and j
                );

    cla2    :   claadder16 port map(
                    sumij,          -- sum of i and j
                    neg_one16,      -- negative 16-bit 1
                    sumij1          -- sum of i and j and 1
                );

    process (neg_j, sumij, sumij1)
    begin

        -- if OF(i + two's-comp(j)) == 1
        if (sumij(to_integer(unsigned(n))) = '1') then
            quot <= sumij;  -- quot = i + two's-cmp(j)
        else
            quot <= sumij1; -- quot = i + two's-cmp(j) + two's-cmp(1)
        end if;

        --quot(to_integer(unsigned(n))) <= '0'; -- set (n + 1)st bit of quot to 0

    end process;

end structural;
