-- indices_tb.vhd
--
-- Sabbir Ahmed
-- 2018-01-16
--

library ieee;
    use ieee.std_logic_1164.all;
library work;
    use work.demo.all;

entity indices_tb is
end indices_tb;

architecture behavioral of indices_tb is

    constant n : positive := DEGREE;
    constant clgn : positive := CEILLGN;
    constant clgn1 : positive := CEILLGN1;

    -- component declaration for the unit under test (uut)
    component indices
        port(
            poly_bcd    : in  std_logic_vector(n downto 0);
            size        : out std_logic_vector(clgn downto 0);
            msb         : out std_logic_vector(clgn1 downto 0)
        );
    end component;

    -- inputs
    signal poly_bcd : std_logic_vector(n downto 0) := (others => '0');

    -- outputs
    signal size : std_logic_vector(clgn downto 0);
    signal msb : std_logic_vector(clgn1 downto 0);

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
    uut: indices port map(
        poly_bcd => poly_bcd,
        size => size,
        msb => msb
    );

    -- stimulus process
    stim_proc: process
    begin

        -- hold reset state for 100 ns.
        wait for 20 ns;

        -- x^2
        poly_bcd <= "000000101";
        wait for 20 ns;

        -- x^8
        poly_bcd <= "100000101";
        wait for 20 ns;

        -- x^7
        poly_bcd <= "011111111";

        wait for 80 ns;

        -- stop simulation
        assert false report "simulation ended" severity failure;

    end process;

end;
