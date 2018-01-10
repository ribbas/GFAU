library ieee;
use ieee.std_logic_1164.all;

entity generator_tb is
end generator_tb;

architecture test of generator_tb is

    -- component declaration for the unit under test (uut)     
    component generator
        port(
            clk         : in std_logic;
            en          : in std_logic;
            rst         : in std_logic;

            -- register
            poly_bcd    : in std_logic_vector(15 downto 0);
            mask        : in std_logic_vector(15 downto 0);
            msb         : in std_logic_vector(3 downto 0);
            size        : in std_logic_vector(3 downto 0);

            -- memory signals
            write_en    : out std_logic;
            addr        : out std_logic_vector(15 downto 0);
            term1        : out std_logic_vector(15 downto 0);
            term2        : out std_logic_vector(15 downto 0)
        );
    end component;

    -- inputs
    signal poly_bcd : std_logic_vector(15 downto 0);
    signal mask : std_logic_vector(15 downto 0);
    signal msb : std_logic_vector(3 downto 0);
    signal size : std_logic_vector(3 downto 0);

    -- outputs
    signal write_en : std_logic;
    signal addr : std_logic_vector(15 downto 0);
    signal term1 : std_logic_vector(15 downto 0);
    signal term2 : std_logic_vector(15 downto 0);

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
        write_en => write_en,
        addr => addr,
        term1 => term1,
        term2 => term2
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

        mask <= "0000000000001111";
        msb <= "0011";
        size <= "0100";
        poly_bcd <= "0000000000011001";

        -- hold reset state for 40 ns.
        wait for 60 ns;

        rst <= '0';

        wait for 680 ns;

        -- stop simulation
        assert false report "simulation ended" severity failure;

    end process;

end;