-- gen_sym_tb.vhd
--
-- Sabbir Ahmed
-- 2018-01-16
--

library ieee;
    use ieee.std_logic_1164.all;
library work;
    use work.demo.all;

entity gen_sym_tb is
end gen_sym_tb;

architecture behavioral of gen_sym_tb is

    constant n : positive := DEGREE;
    constant clgn1 : positive := CEILLGN1;

    -- component declaration for the unit under test (uut)
    component gen_sym
        port(
            clk     : in std_logic;
            rst     : in std_logic;
            en      : in std_logic;
            nth_sym : in std_logic_vector(n downto 0);
            msb     : in std_logic_vector(clgn1 downto 0);  -- msb of element
            sym     : out std_logic_vector(n downto 0)
        );
    end component;

    -- inputs
    signal rst : std_logic := '1';
    signal en : std_logic := '1';
    signal msb : std_logic_vector(clgn1 downto 0);
    signal nth_sym : std_logic_vector(n downto 0);

    -- outputs
    signal sym : std_logic_vector(n downto 0);

    -- testbench clocks
    constant nums : integer := 640;
    signal clk : std_logic := '1';

begin

    -- instantiate the unit under test (uut)
    uut: gen_sym port map(
        clk => clk,
        rst => rst,
        en => en,
        nth_sym => nth_sym,
        msb => msb,
        sym => sym
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

        msb <= "010";
        nth_sym <= "000000101";

        -- hold reset state for 40 ns.
        wait for 20 ns;

        rst <= '0';
        en <= '1';

        wait for 450 ns;

        -- stop simulation
        assert false report "simulation ended" severity failure;

    end process;

end;