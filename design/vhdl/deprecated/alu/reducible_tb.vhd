-- reducible_tb.vhd
--
-- Brian Weber
-- 2018-01-16
--

library std;
library ieee;
use ieee.std_logic_1164.all;

entity reducible_tb is
end reducible_tb;

architecture test of reducible_tb is

    component reducible is
        port(
            poly_bcd        : in std_logic_vector(15 downto 0);
            is_reducible    : out std_logic
        );
    end component;

    -- input
    signal poly_bcd         : std_logic_vector(15 downto 0);

    -- output
    signal is_reducible     : std_logic;

    -- testbench clocks
    constant nums   : integer := 320;
    signal clk      : std_ulogic := '1';


begin

    r16 : reducible port map(
        poly_bcd => poly_bcd, 
        is_reducible => is_reducible
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

        -- hold reset state for 100 ns.
        wait for 40 ns;

        -- x^3 + x^2 + x^0
        poly_bcd <= "0000000000001101";
        wait for 40 ns;

        -- x^4 + x^2 + x^1
        poly_bcd <= "0000000000010110";
        wait for 40 ns;

        -- x^4 + x^3 + x^2 + x^1
        poly_bcd <= "0000000000011110";
        wait for 40 ns;

        -- x^2 + x^0
        poly_bcd <= "0000000000000101";
        wait for 40 ns;

        -- x^2
        poly_bcd <= "0000000000000100";
        wait for 40 ns;

        -- x^0
        poly_bcd <= "0000000000000001";

        wait for 80 ns;

        -- stop simulation
        assert false report "simulation ended" severity failure;

    end process;

end test;
