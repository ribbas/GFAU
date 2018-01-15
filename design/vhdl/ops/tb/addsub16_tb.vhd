
-- addsub16_tb.vhd

-- Sabbir Ahmed
-- 2018-01-14


library ieee;
use ieee.std_logic_1164.all;

entity addsub16_tb is
end addsub16_tb;

architecture behavioral of addsub16_tb is

    -- component declaration for the unit under test (uut)     
    component addsub16
        port(
            i       : in std_logic_vector (15 downto 0);
            j       : in std_logic_vector (15 downto 0);
            bitxor  : out std_logic_vector (15 downto 0)
        );
    end component;

    -- inputs
    signal i, j     : std_logic_vector(15 downto 0) := (others => '0');

    -- outputs
    signal bitxor   : std_logic_vector(15 downto 0);

    -- testbench clocks
    constant nums   : integer := 320;
    signal clk      : std_ulogic := '1';

begin

    -- instantiate the unit under test (uut)
    uut: addsub16 port map(
        i => i,
        j => j,
        bitxor => bitxor
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

        -- hold reset state for 20 ns.
        wait for 40 ns;

        -- (2 ^ 3) = 1
        i <= "0000000000000010";
        j <= "0000000000000011";

        -- hold reset state for 40 ns.
        wait for 40 ns;

        -- (6 ^ 5) = 3
        i <= "0000000000000110";
        j <= "0000000000000101";

        -- hold reset state for 40 ns.
        wait for 40 ns;

        -- (0 ^ 6) = 6
        i <= "0000000000000000";
        j <= "0000000000000110";

        -- hold reset state for 40 ns.
        wait for 40 ns;

        -- (6 ^ 1) = 7
        i <= "0000000000000110";
        j <= "0000000000000001";

        -- hold reset state for 40 ns.
        wait for 40 ns;

        -- (11 ^ 12) = 7
        i <= "0000000000001011";
        j <= "0000000000001100";

        wait for 40 ns;

        -- stop simulation
        assert false report "simulation ended" severity failure;

    end process;

end;
