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
            prod    : out std_logic_vector (15 downto 0);
            rdy     : out std_logic
        );
    end component;

    -- inputs
    signal i, j     : std_logic_vector(15 downto 0) := (others => '0');
    signal n        : integer range 0 to 15;

    -- outputs
    signal prod     : std_logic_vector(15 downto 0);
    signal rdy      : std_logic;

    -- testbench clocks
    constant nums   : integer := 320;
    signal clk      : std_ulogic := '1';

begin

    -- instantiate the unit under test (uut)
    uut: mul16 port map(
        i => i,
        j => j,
        n => n,
        prod => prod,
        rdy => rdy
    );

    -- architecture statement part
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

        n <= 3;
        report "n" & integer'image(n);

        -- hold reset state for 20 ns.
        wait for 20 ns;

        -- (2 * 3) = (2 + 3) mod 7 = 5
        i <= "0000000000000010";
        j <= "0000000000000011";

        -- hold reset state for 20 ns.
        wait for 20 ns;

        -- (6 * 6) = (6 + 5) mod 7 = 4
        i <= "0000000000000110";
        j <= "0000000000000101";

        -- hold reset state for 20 ns.
        wait for 20 ns;

        -- (0 * 6) = (0 + 6) mod 7 = 6
        i <= "0000000000000000";
        j <= "0000000000000110";

        -- hold reset state for 20 ns.
        wait for 20 ns;

        -- (1 * 6) = (1 + 6) mod 7 = 0
        i <= "0000000000000110";
        j <= "0000000000000001";

        -- hold reset state for 20 ns.
        wait for 20 ns;

        -- (11 * 12) = (11 + 12) mod 15 = 8
        n <= 4;
        i <= "0000000000001011";
        j <= "0000000000001100";

        wait for 20 ns;

        -- stop simulation
        assert false report "simulation ended" severity failure;

    end process;

end;
