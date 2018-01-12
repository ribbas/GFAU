library ieee;
use ieee.std_logic_1164.all;

entity isbounded_tb is
end isbounded_tb;

architecture behavioral of isbounded_tb is

    -- component declaration for the unit under test (uut)     
    component isbounded
        port(
            operand     : in  std_logic_vector(15 downto 0);
            mask        : in  std_logic_vector(15 downto 0);
            is_out_bd   : out std_logic
        );
    end component;

    -- inputs
    signal operand      : std_logic_vector(15 downto 0) := (others => '0');
    signal mask         : std_logic_vector(15 downto 0) := (others => '0');

    -- outputs
    signal is_out_bd : std_logic;

    -- testbench clocks
    constant nums       : integer := 320;
    signal clk          : std_ulogic := '1';

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
    uut: isbounded port map(
        operand => operand,
        mask => mask,
        is_out_bd => is_out_bd
    );

    -- stimulus process
    stim_proc: process
    begin

        -- 3-bit mask
        mask <= "0000000000000111";

        -- 5
        operand <= "0000000000000101";
        wait for 40 ns;

        -- 3
        operand <= "0000000000000011";
        wait for 40 ns;

        -- 7
        operand <= "0000000000000111";
        wait for 40 ns;

        -- 0
        operand <= "0000000000000000";
        wait for 40 ns;

        -- 65534
        operand <= "1111111111111110";

        wait for 40 ns;

        -- 65535
        operand <= "1111111111111111";

        wait for 40 ns;

        -- 4-bit mask
        mask <= "0000000000001111";

        -- 7
        operand <= "0000000000000111";

        wait for 40 ns;

        -- 65534
        operand <= "1111111111111110";

        wait for 40 ns;

        -- stop simulation
        assert false report "simulation ended" severity failure;

    end process;

end;
