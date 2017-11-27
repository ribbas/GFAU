library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mul16 is
    port(
        i       : in std_logic_vector (15 downto 0);
        j       : in std_logic_vector (15 downto 0);
        prod    : out std_logic_vector (15 downto 0)
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
 
    signal  c1: std_logic;
    signal uno: std_logic_vector(15 downto 0) := "0000000000000001";
    signal sumij, sumij1: std_logic_vector(15 downto 0);

begin

    cla1    :   claadder16 port map(
                    i,                      -- first element
                    j,                      -- second element
                    '0',                    -- default zero
                    sumij,                  -- sum of i and j
                    c1                      -- not sure yet
                );

    cla2    :   claadder16 port map(
                    sumij,              -- sum of i and j
                    uno,                -- 16-bit 1
                    '0',                -- default zero
                    sumij1,             -- sum of i and j and 1
                    c1                  -- not sure yet
                );

    process (sumij, sumij1)
    begin
        if (sumij(3) = '0' and sumij1(3) = '0') then  -- hardcoded MSB
            prod <= sumij;
        else
            prod <= sumij1;
        end if;
    end process;

end structural;
