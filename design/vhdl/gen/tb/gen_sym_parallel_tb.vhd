-- gen_sym_parallel_tb.vhd
--
-- Sabbir Ahmed
-- 2018-01-16
--
--
--

library ieee;
use ieee.std_logic_1164.all;

entity gen_sym_parallel_tb is
end gen_sym_parallel_tb;

architecture behavioral of gen_sym_parallel_tb is

    -- component declaration for the unit under test (uut)     
    component gen_sym_parallel
        port(
            clk     : in std_logic;
            rst     : in std_logic;
            nth_sym : in std_logic_vector(15 downto 0);
            cur_sym : in std_logic_vector(15 downto 0);
            msb     : in std_logic_vector(3 downto 0);  -- size of element
            sym1    : out std_logic_vector(15 downto 0);
            sym2    : out std_logic_vector(15 downto 0)
        );
    end component;

    -- inputs
    signal msb : std_logic_vector(3 downto 0);
    --signal prev_term : std_logic_vector(15 downto 0);
    signal nth_sym : std_logic_vector(15 downto 0);
    signal cur_sym : std_logic_vector(15 downto 0);

    -- outputs
    signal sym1 : std_logic_vector(15 downto 0);
    signal sym2 : std_logic_vector(15 downto 0);

    -- testbench clocks
    constant nums : integer := 640;
    signal clk : std_logic := '1';
    signal rst : std_logic := '1';

begin

    -- instantiate the unit under test (uut)
    uut: gen_sym_parallel port map(
        clk => clk,
        rst => rst,
        msb => msb,
        nth_sym => nth_sym,
        cur_sym => sym2,
        sym1 => sym1,
        sym2 => sym2
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

        msb <= "0011";
        nth_sym <= "0000000000011001";

        -- hold reset state for 40 ns.
        wait for 20 ns;

        rst <= '0';
        --cur_sym <= "0000000000011001";

        wait for 450 ns;

        -- stop simulation
        assert false report "simulation ended" severity failure;

    end process;

end;
