
-- mul16.vhd

-- Sabbir Ahmed
-- 2018-01-14


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mul16 is
    port(
        i       : in std_logic_vector(15 downto 0); -- first element
        j       : in std_logic_vector(15 downto 0); -- second element
        n       : in std_logic_vector(3 downto 0);  -- size of element
        prod    : out std_logic_vector(15 downto 0) -- product of elements
    );
end mul16;

architecture structural of mul16 is

    -- CLA adder component
    component claadder16
        port(
            a   : in std_logic_vector(15 downto 0);
            b   : in std_logic_vector(15 downto 0);
            s   : out std_logic_vector(15 downto 0)
        );
    end component;
 
    signal sumij : std_logic_vector(15 downto 0);
    signal sumij1 : std_logic_vector(15 downto 0);

begin

    -- sum(i, j)
    cla1 : claadder16 port map(
        i,                  -- first element
        j,                  -- second element
        sumij               -- sum of i and j
    );

    -- sum(i, j, 1)
    cla2 : claadder16 port map(
        sumij,              -- sum of i and j
        "0000000000000001", -- 16-bit 1
        sumij1              -- sum of i and j and 1
    );

    process (sumij, sumij1)
    begin

        -- if (OF(i + j) or OF(i + j + 1) == 0)
        if ((sumij(to_integer(unsigned(n))) or 
            sumij1(to_integer(unsigned(n)))) = '0') then
            prod <= sumij;          -- prod = i + j
        else
            prod <= sumij1;         -- prod = i + j + 1
        end if;

    end process;

end structural;
