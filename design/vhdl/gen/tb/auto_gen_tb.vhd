library ieee;
use ieee.std_logic_1164.all;

entity auto_gen_tb is
end auto_gen_tb;

architecture behavioral of auto_gen_tb is

    -- component declaration for the unit under test (uut)     
    component auto_gen
        port(
            clk     : in std_logic;
            rst     : in std_logic;
            data    : out std_logic_vector(15 downto 0)
        );
    end component;

    -- outputs
    signal data : std_logic_vector(15 downto 0);

    -- testbench clocks
    constant nums   : integer := 640;
    signal clk      : std_logic := '1';
    signal rst      : std_logic := '1';

begin

    -- instantiate the unit under test (uut)
    uut: auto_gen port map(
        clk => clk,
        rst => rst,
        data => data
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

        -- hold reset state for 40 ns.
        wait for 40 ns;

        rst <= '0';

        wait for 700 ns;

        -- stop simulation
        assert false report "simulation ended" severity failure;

    end process;

end;
