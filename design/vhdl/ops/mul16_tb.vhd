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
            n       : in integer;
            prod    : out std_logic_vector (15 downto 0)
        );
    end component;

    -- inputs
    signal i, j     : std_logic_vector(15 downto 0) := (others => '0');
    signal n        : integer range 0 to 15;

    -- outputs
    signal prod     : std_logic_vector(15 downto 0);

begin

    -- instantiate the unit under test (uut)
    uut: mul16 port map(
        i => i,
        j => j,
        n => n,
        prod => prod
    );

    -- stimulus process
    stim_proc: process
    begin

        n <= 3;
        report "n" & integer'image(n);

        -- hold reset state for 100 ns.
        wait for 10 ns;

        -- (2 * 3) = (2 + 3) mod 7
        i <= "0000000000000010";
        j <= "0000000000000011";

        -- hold reset state for 100 ns.
        wait for 10 ns;

        -- (6 * 6) = (6 + 6) mod 7
        i <= "0000000000000110";
        j <= "0000000000000110";

        -- hold reset state for 100 ns.
        wait for 10 ns;

        -- (0 * 6) = (0 + 6) mod 7
        i <= "0000000000000000";
        j <= "0000000000000110";

        -- hold reset state for 100 ns.
        wait for 10 ns;

        -- (1 * 6) = (1 + 6) mod 7
        i <= "0000000000000001";
        j <= "0000000000000110";

        -- (11 * 12) = (11 + 12) mod 15
        n <= 4;
        i <= "0000000000001011";
        j <= "0000000000001100";

        wait for 50 ns;

        -- stop simulation
        assert false report "simulation ended" severity failure;

    end process;

end;
