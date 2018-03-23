-- div_tb.vhd
--
-- Sabbir Ahmed
-- 2018-01-16
--

library ieee;
use ieee.std_logic_1164.all;

entity div_tb is
end div_tb;

architecture behavioral of div_tb is

    constant n : positive := 8;
    constant clgn : positive := 3;

    -- component declaration for the unit under test (uut)
    component div
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
    end component;

    -- inputs
    signal i, j : std_logic_vector(n downto 0) := (others => '0');
    signal size    : std_logic_vector (clgn downto 0) := (others => '0');

    -- outputs
    signal quot : std_logic_vector(n downto 0);

    -- testbench clocks
    constant nums   : integer := 320;
    signal clk      : std_ulogic := '1';

begin

    -- instantiate the unit under test (uut)
    uut: div
    generic map(
        n => n,
        clgn => clgn
    )
    port map(
        i => i,
        j => j,
        size => size,
        quot => quot
    );

    -- clock process
    clk_proc: process
    begin

        for i in 1 to nums loop
            clk <= not clk;
            wait for 20 ns;
            -- clock period = 50 MHz
        end loop;

    end process;

    -- stimulus process
    stim_proc: process
    begin

        size <= "0011";

        -- hold reset state for 20 ns.
        wait for 40 ns;

        -- (2 / 3) = (2 - 3) mod 7 = 6
        i <= "000000010";
        j <= "000000101";

        -- hold reset state for 40 ns.
        wait for 40 ns;

        -- (6 / 5) = (6 - 5) mod 7 = 1
        i <= "000000110";
        j <= "000000011";

        -- hold reset state for 40 ns.
        wait for 40 ns;

        -- (0 / 6) = (0 - 6) mod 7 = 1
        i <= "000000000";
        j <= "000000010";

        -- hold reset state for 40 ns.
        wait for 40 ns;

        -- (6 / 1) = (6 - 1) mod 7 = 5
        i <= "000000110";
        j <= "000000111";

        -- hold reset state for 40 ns.
        wait for 40 ns;

        -- (11 / 12) = (11 - 12) mod 15 = 14
        size <= "0100";
        i <= "000001011";
        j <= "000000100";

        wait for 40 ns;

        size <= "1111";
        i <= "011111110";
        j <= "000000011";

        wait for 40 ns;

        -- stop simulation
        assert false report "simulation ended" severity failure;

    end process;

end;
