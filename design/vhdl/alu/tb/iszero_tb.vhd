
-- iszero_tb.vhd

-- Sabbir Ahmed
-- 2018-01-14


library ieee;
use ieee.std_logic_1164.all;

entity iszero_tb is
end iszero_tb;

architecture behavioral of iszero_tb is

    -- component declaration for the unit under test (uut)     
    component iszero
        port(
            en              : in std_logic;
            operand         : in std_logic_vector(15 downto 0);
            mem_t           : in std_logic;
            is_zero_flag    : out std_logic
        );
    end component;

    -- inputs
    signal operand : std_logic_vector(15 downto 0);
    signal mem_t : std_logic;
    signal en : std_logic;

    -- outputs
    signal is_zero_flag : std_logic;

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
    uut: iszero port map(
        en => en,
        operand => operand,
        mem_t => mem_t,
        is_zero_flag => is_zero_flag
    );

    -- stimulus process
    stim_proc: process
    begin

        mem_t <= '0';  -- mem1
        en <= '1';  -- enable

        -- null in mem1
        operand <= "1111111111111111";
        wait for 40 ns;

        -- null in mem2, 0 in mem1
        operand <= "0000000000000000";
        wait for 40 ns;

        mem_t <= '1';  -- mem2

        -- null in mem1
        operand <= "1111111111111111";
        wait for 40 ns;

        -- null in mem2, 0 in mem1
        operand <= "0000000000000000";
        wait for 40 ns;

        -- stop simulation
        assert false report "simulation ended" severity failure;

    end process;

end;
