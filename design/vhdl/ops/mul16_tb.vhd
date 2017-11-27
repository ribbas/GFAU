library ieee;
use ieee.std_logic_1164.all;

entity mul16_tb is
end mul16_tb;

architecture behavioral of mul16_tb is

    -- component declaration for the unit under test (uut)     
    component mul16
        port(
            i       : in std_logic_vector (15 downto 0);
            j       : in std_logic_vector (15 downto 0);
            prod    : out std_logic_vector (15 downto 0)
        );
    end component;

    --inputs
    signal i : std_logic_vector(15 downto 0) := (others => '0');
    signal j : std_logic_vector(15 downto 0) := (others => '0');

    --outputs
    signal prod : std_logic_vector(15 downto 0);

begin

    -- instantiate the unit under test (uut)
    uut: mul16 port map(
        i => i,
        j => j,
        prod => prod
    );

    -- stimulus process
    stim_proc: process
    begin
        -- hold reset state for 100 ns.
        wait for 10 ns;

        i <= "0000000000000010";
        j <= "0000000000000011";

        -- hold reset state for 100 ns.
        wait for 10 ns;

        i <= "0000000000000110";
        j <= "0000000000000110";

        wait;

    end process;

end;
