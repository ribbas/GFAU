library ieee;
use ieee.std_logic_1164.all;

entity twoscmp_tb is
end twoscmp_tb;

architecture behavioral of twoscmp_tb is

    -- component declaration for the unit under test (uut)     
    component twoscmp
        port(
            num     : in  std_logic_vector(15 downto 0);
            n       : in std_logic_vector(15 downto 0);
            tcnum   : out  std_logic_vector(15 downto 0)
        );
    end component;

    -- inputs
    signal num      : std_logic_vector(15 downto 0) := (others => '0');
    signal n        : std_logic_vector(15 downto 0);

    -- outputs
    signal tcnum    : std_logic_vector(15 downto 0);

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
    uut: twoscmp port map(
        num => num,
        n => n,
        tcnum => tcnum
    );

    -- stimulus process
    stim_proc: process
    begin

        n <= 3;

        -- hold reset state for 100 ns.
        wait for 40 ns;

        -- 3
        num <= "0000000000000101";
        wait for 40 ns;

        -- 65535
        num <= "1111111111111111";
        wait for 40 ns;

        -- 65535
        num <= "0000000000000001";
        wait for 40 ns;

        -- 65535
        num <= "0000000000000011";
        wait for 40 ns;

        -- 0
        num <= "0000000000000000";


        wait for 80 ns;

        -- stop simulation
        assert false report "simulation ended" severity failure;

    end process;

end;
