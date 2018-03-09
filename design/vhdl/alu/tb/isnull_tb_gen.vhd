-- isnull_gen_tb.vhd
--
-- Sabbir Ahmed
-- 2018-01-16
--

library ieee;
use ieee.std_logic_1164.all;

entity isnull_gen_tb is
end isnull_gen_tb;

architecture behavioral of isnull_gen_tb is

    signal nbits : natural := 20;
    -- component declaration for the unit under test (uut)
    component isnull_gen
        generic(
            nbits : natural
        );
        port(
            opand   : in std_logic_vector(nbits - 1 downto 0);  -- opand
            mem_t   : in std_logic;
            is_null : out std_logic
        );
    end component;

    -- inputs
    signal opand : std_logic_vector(nbits - 1 downto 0);
    signal mem_t : std_logic;

    -- outputs
    signal is_null : std_logic;

    -- testbench clocks
    constant nums : integer := 320;
    signal clk : std_ulogic := '1';

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
    uut: isnull_gen
    generic map(
        nbits => 20
    )
    port map(
        opand => opand,
        mem_t => mem_t,
        is_null => is_null
    );

    -- stimulus process
    stim_proc: process
    begin

        mem_t <= '0';  -- mem1

        -- null in mem1
        opand <= "11111111111111111111";
        wait for 40 ns;

        -- null in mem2, 0 in mem1
        opand <= "00000000000000000000";
        wait for 40 ns;

        mem_t <= '1';  -- mem2

        -- null in mem1
        opand <= "11111111111111111111";
        wait for 40 ns;

        -- null in mem2, 0 in mem1
        opand <= "00000000000000000000";
        wait for 40 ns;

        opand <= "00000000000000001100";
        wait for 40 ns;

        mem_t <= '0';  -- mem2
        wait for 40 ns;

        -- stop simulation
        assert false report "simulation ended" severity failure;

    end process;

end;
