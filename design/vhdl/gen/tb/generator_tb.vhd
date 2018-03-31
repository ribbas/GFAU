-- generator_tb.vhd
--
-- Sabbir Ahmed
-- 2018-01-16
--

library ieee;
    use ieee.std_logic_1164.all;
library work;
    use work.demo.all;

entity generator_tb is
end generator_tb;

architecture test of generator_tb is

    constant n : positive := DEGREE;
    constant clgn : positive := CEILLGN;
    constant clgn1 : positive := CEILLGN1;

    -- component declaration for the unit under test (uut)
    component generator
        port(
            clk         : in std_logic;
            en          : in std_logic;
            rst         : in std_logic;

            -- polynomial data
            poly_bcd    : in std_logic_vector(n downto 0);
            mask        : in std_logic_vector(n downto 0);
            size        : in std_logic_vector(clgn downto 0);
            msb         : in std_logic_vector(clgn1 downto 0);

            -- memory signals
            wr_en       : out std_logic;
            rdy         : out std_logic;
            addr        : out std_logic_vector(n downto 0);
            sym         : out std_logic_vector(n downto 0)
        );
    end component;

    -- inputs
    signal poly_bcd : std_logic_vector(n downto 0);
    signal mask : std_logic_vector(n downto 0);
    signal msb : std_logic_vector(clgn1 downto 0);
    signal size : std_logic_vector(clgn downto 0);

    -- outputs
    signal rdy : std_logic;
    signal wr_en : std_logic;
    signal addr : std_logic_vector(n downto 0);
    signal sym : std_logic_vector(n downto 0);

    -- testbench clocks
    constant nums : integer := 640;
    signal clk : std_logic := '1';
    signal rst : std_logic := '1';
    signal en : std_logic := '1';

begin

    -- instantiate the unit under test (uut)
    uut: generator port map(
        clk => clk,
        rst => rst,
        en => en,
        poly_bcd => poly_bcd,
        mask => mask,
        msb => msb,
        size => size,
        wr_en => wr_en,
        rdy => rdy,
        addr => addr,
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

        mask <= "000000111";
        msb <= "010";
        size <= "0011";
        poly_bcd <= "000001101";

        -- hold reset state for 40 ns.
        wait for 30 ns;

        rst <= '0';

        wait for 1000 ns;

        -- stop simulation
        assert false report "simulation ended" severity failure;

    end process;

end;
