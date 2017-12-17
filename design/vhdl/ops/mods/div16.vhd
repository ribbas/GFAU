library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity div16 is
    port(
        i       : in std_logic_vector (15 downto 0);  -- first element
        j       : in std_logic_vector (15 downto 0);  -- second element
        n       : in std_logic_vector(3 downto 0);    -- size of element
        mask    : in std_logic_vector(15 downto 0);   -- mask register
        quot    : out std_logic_vector (15 downto 0)  -- quotient of elements
    );
end div16;

architecture structural of div16 is

    -- CLA adder component
    component claadder16
        port(
            a       : in std_logic_vector (15 downto 0);
            b       : in std_logic_vector (15 downto 0);
            cin     : in std_logic;
            s       : out std_logic_vector (15 downto 0);
            cout    : out std_logic
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

    signal c1, c2   : std_logic;
    signal neg_j    : std_logic_vector(15 downto 0) := (others => '0');
    signal one16    : std_logic_vector(15 downto 0) := "0000000000000001";
    signal neg_one16: std_logic_vector(15 downto 0) := (others => '0');
    signal sumij    : std_logic_vector(15 downto 0) := (others => '0');
    signal sumij1   : std_logic_vector(15 downto 0) := (others => '0');

begin

    mtc1    :   maskedtwoscmp port map(
                    j,              -- j
                    mask,           -- fixed mask
                    neg_j           -- masked two's complement of j
                );

    mtc2    :   maskedtwoscmp port map(
                    one16,          -- 16-bit 1
                    mask,           -- fixed mask
                    neg_one16       -- masked two's complement of 16-bit 1
                );

    cla1    :   claadder16 port map(
                    i,              -- first element
                    neg_j,          -- masked two's complement of j
                    '0',            -- default zero
                    sumij,          -- sum of i and j
                    c1              -- not sure yet
                );

    cla2    :   claadder16 port map(
                    sumij,          -- sum of i and j
                    neg_one16,      -- negative 16-bit 1
                    '0',            -- default zero
                    sumij1,         -- sum of i and j and 1
                    c2              -- not sure yet
                );


    process (neg_j, sumij, sumij1)
    begin

        -- if OF(i + two's-comp(j)) == 1
        if (sumij(to_integer(unsigned(n))) = '1') then
            quot <= sumij;  -- quot = i + two's-cmp(j)
        else
            quot <= sumij1; -- quot = i + two's-cmp(j) + 1
        end if;

        quot(to_integer(unsigned(n))) <= '0'; -- set (n + 1)st bit of quot to 0

    end process;

end structural;
