-- msb_tb.vhd
--
-- Sabbir Ahmed
-- 2018-01-16
--

library ieee;
use ieee.std_logic_1164.all;

entity msb_tb is
end msb_tb;

architecture behavioral of msb_tb is

    -- component declaration for the unit under test (uut)     
    component msb
        port(
            poly_bcd    : in  std_logic_vector(15 downto 0);
            m           : out std_logic_vector(3 downto 0)
        );
    end component;

    -- inputs
    signal poly_bcd : std_logic_vector(15 downto 0) := (others => '0');

    -- outputs
    signal m        : std_logic_vector(3 downto 0);

    -- testbench clocks
    constant nums   : integer := 320;
    signal clk      : std_ulogic := '1';

begin

    -- clock process
    clk_proc: process
    begin

        for i in 1 to nums loop
            clk <= not clk;
            wait for 20 ns;
            -- clock period = 50 MHz
        end loop;

    end process;


    -- instantiate the unit under test (uut)
    uut: msb port map(
        poly_bcd => poly_bcd,
        m => m
    );

    -- stimulus process
    stim_proc: process
    begin

        -- hold reset state for 100 ns.
        wait for 40 ns;

        -- x^2
        poly_bcd <= "0000000000000101";
        wait for 40 ns;

        -- x^11
        poly_bcd <= "0000100000000101";
        wait for 40 ns;

        -- x^15
        poly_bcd <= "1111111111111111";

        wait for 80 ns;

        -- stop simulation
        assert false report "simulation ended" severity failure;

    end process;

end;
