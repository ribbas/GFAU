library ieee;
use ieee.std_logic_1164.all;

entity twoscmp_tb is
end twoscmp_tb;

architecture behavioral of twoscmp_tb is

    -- component declaration for the unit under test (uut)     
    component twoscmp
        port(
            num     : in  std_logic_vector (15 downto 0);
            n       : in integer range 0 to 15;
            tcnum   : out  std_logic_vector (15 downto 0)
        );
    end component;

    -- inputs
    signal num      : std_logic_vector(15 downto 0) := (others => '0');
    signal n        : integer range 0 to 15;

    -- outputs
    signal tcnum    : std_logic_vector(15 downto 0);

begin

    -- instantiate the unit under test (uut)
    uut: twoscmp port map(
        num => num,
        n => n,
        tcnum => tcnum
    );

    -- stimulus process
    stim_proc: process
    begin

        n <= 5;

        -- hold reset state for 100 ns.
        wait for 10 ns;

        -- 3
        num <= "0000000000000101";

        wait for 10 ns;

        -- 65535
        num <= "1111111111111111";

        wait for 10 ns;

        -- 65535
        num <= "0000000000000001";

        -- 65535
        num <= "0000000000000000";


        wait for 50 ns;

        -- stop simulation
        assert false report "simulation ended" severity failure;

    end process;

end;
