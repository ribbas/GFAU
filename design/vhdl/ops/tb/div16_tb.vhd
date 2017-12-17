library ieee;
use ieee.std_logic_1164.all;

entity div16_tb is
end div16_tb;

architecture behavioral of div16_tb is

    -- component declaration for the unit under test (uut)     
    component div16
        port(
            i       : in std_logic_vector (15 downto 0);
            j       : in std_logic_vector (15 downto 0);
            n       : in std_logic_vector (3 downto 0);
            mask    : in std_logic_vector (15 downto 0);
            quot    : out std_logic_vector (15 downto 0)
        );
    end component;

    -- inputs
    signal i, j : std_logic_vector(15 downto 0) := (others => '0');
    signal n    : std_logic_vector (3 downto 0) := (others => '0');
    signal mask : std_logic_vector(15 downto 0) := (others => '0');

    -- outputs
    signal quot : std_logic_vector(15 downto 0);

    -- testbench clocks
    constant nums   : integer := 320;
    signal clk      : std_ulogic := '1';

begin

    -- instantiate the unit under test (uut)
    uut: div16 port map(
        i => i,
        j => j,
        n => n,
        mask => mask,
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

        mask <= "0000000000000111";
        n <= "0011";
        --report "n" & integer'image(n);

        -- hold reset state for 20 ns.
        wait for 40 ns;

        -- (2 / 3) = (2 - 3) mod 7 = 6
        i <= "0000000000000010";
        j <= "0000000000000011";

        -- hold reset state for 40 ns.
        wait for 40 ns;

        -- (6 / 5) = (6 - 5) mod 7 = 1
        i <= "0000000000000110";
        j <= "0000000000000101";

        -- hold reset state for 40 ns.
        wait for 40 ns;

        -- (0 / 6) = (0 - 6) mod 7 = 1
        i <= "0000000000000000";
        j <= "0000000000000110";

        -- hold reset state for 40 ns.
        wait for 40 ns;

        -- (6 / 1) = (6 - 1) mod 7 = 5
        i <= "0000000000000110";
        j <= "0000000000000001";

        -- hold reset state for 40 ns.
        wait for 40 ns;

        -- (11 / 12) = (11 - 12) mod 15 = 14
        mask <= "0000000000001111";
        n <= "0100";
        i <= "0000000000001011";
        j <= "0000000000001100";

        wait for 40 ns;

        -- stop simulation
        assert false report "simulation ended" severity failure;

    end process;

end;