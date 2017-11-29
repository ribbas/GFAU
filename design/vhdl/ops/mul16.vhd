library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mul16 is
    port(
        i       : in std_logic_vector (15 downto 0);    -- first element
        j       : in std_logic_vector (15 downto 0);    -- second element
        n       : in integer range 0 to 15;             -- size of element
        prod    : out std_logic_vector (15 downto 0)    -- product of elements
    );
end mul16;

architecture structural of mul16 is

    component claadder16
        port(
            a       : in std_logic_vector (15 downto 0);
            b       : in std_logic_vector (15 downto 0);
            cin     : in std_logic;
            s       : out std_logic_vector (15 downto 0);
            cout    : out std_logic
        );
    end component;
 
    signal  c1, c2  : std_logic;
    signal  one16   : std_logic_vector(15 downto 0) := "0000000000000001";
    signal  sumij,
            sumij1  : std_logic_vector(15 downto 0);

begin

    cla1    :   claadder16 port map(
                    i,              -- first element
                    j,              -- second element
                    '0',            -- default zero
                    sumij,          -- sum of i and j
                    c1              -- not sure yet
                );

    cla2    :   claadder16 port map(
                    sumij,          -- sum of i and j
                    one16,          -- 16-bit 1
                    '0',            -- default zero
                    sumij1,         -- sum of i and j and 1
                    c2              -- not sure yet
                );

    process (sumij, sumij1)
    begin

        -- if (MSB(i + j) or MSB(i + j + 1) == 0)
        if ((sumij(n) or sumij1(n)) = '0') then
            prod <= sumij;  -- prod = i + j
        else
            prod <= sumij1;  -- prod = i + j + 1
        end if;

        prod(n) <= '0';  -- set (n + 1)st bit of prod to 0

    end process;

end structural;
