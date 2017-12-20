library ieee;
use ieee.std_logic_1164.all;

entity mul16_tb is
end mul16_tb;

architecture behavioral of mul16_tb is

    -- component declaration for the unit under test (uut)     
    component mul16
        port(
            clk     : in std_logic;
            rst     : in std_logic;
            i       : in std_logic_vector (15 downto 0);
            j       : in std_logic_vector (15 downto 0);
            n       : in std_logic_vector (3 downto 0);
            prod    : out std_logic_vector (15 downto 0)
        );
    end component;

    -- inputs
    signal i        : std_logic_vector(15 downto 0);
    signal j        : std_logic_vector(15 downto 0);
    signal n        : std_logic_vector (3 downto 0);

    -- outputs
    signal prod     : std_logic_vector(15 downto 0);

    -- testbench clocks
    constant nums   : integer := 640;
    signal clk      : std_logic := '1';
    signal rst      : std_logic := '1';

begin

    -- instantiate the unit under test (uut)
    uut: mul16 port map(
        clk => clk,
        rst => rst,
        i => i,
        j => j,
        n => n,
        prod => prod
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

        n <= "0011";

        -- hold reset state for 20 ns.
        wait for 10 ns;

        rst <= '0';
        -- hold reset state for 20 ns.
        --wait for 160 ns;

        -- (2 * 3) = (2 + 3) mod 7 = 5
        i <= "0000000000000010";
        j <= "0000000000000011";

        -- hold reset state for 160 ns.
        wait for 160 ns;

        -- (6 * 5) = (6 + 5) mod 7 = 4
        i <= "0000000000000110";
        j <= "0000000000000101";

        -- hold reset state for 160 ns.
        wait for 160 ns;

        -- (0 * 6) = (0 + 6) mod 7 = 6
        i <= "0000000000000000";
        j <= "0000000000000110";

        -- hold reset state for 160 ns.
        wait for 160 ns;

        -- (6 * 1) = (6 + 1) mod 7 = 0
        i <= "0000000000000110";
        j <= "0000000000000001";

        -- hold reset state for 160 ns.
        wait for 160 ns;

        -- (11 * 12) = (11 + 12) mod 15 = 8
        n <= "0100";
        i <= "0000000000001011";
        j <= "0000000000001100";

        wait for 160 ns;

        n <= "1111";
        i <= "0111111111111110";
        j <= "0111111111111110";

        wait for 200 ns;

        -- stop simulation
        assert false report "simulation ended" severity failure;

    end process;

end;
