library ieee;
use ieee.std_logic_1164.all;

entity gen_sym_tb is
end gen_sym_tb;

architecture behavioral of gen_sym_tb is

    -- component declaration for the unit under test (uut)     
    component gen_sym
        port(
            clk         : in std_logic;
            rst         : in std_logic;
            msb         : in std_logic_vector(3 downto 0);  -- size of element
            nth_term    : in std_logic_vector(15 downto 0);
            cur_term    : out std_logic_vector(15 downto 0)
        );
    end component;

    -- inputs
    signal msb : std_logic_vector(3 downto 0);
    --signal prev_term : std_logic_vector(15 downto 0);
    signal nth_term : std_logic_vector(15 downto 0);

    -- outputs
    signal cur_term : std_logic_vector(15 downto 0);

    -- testbench clocks
    constant nums : integer := 640;
    signal clk : std_logic := '1';
    signal rst : std_logic := '1';

begin

    -- instantiate the unit under test (uut)
    uut: gen_sym port map(
        clk => clk,
        rst => rst,
        msb => msb,
        nth_term => nth_term,
        cur_term => cur_term
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
        nth_term <= "0000000000011001";

        -- hold reset state for 40 ns.
        wait for 20 ns;

        rst <= '0';

        wait for 450 ns;

        -- stop simulation
        assert false report "simulation ended" severity failure;

    end process;

end;
