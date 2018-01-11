library ieee;
use ieee.std_logic_1164.all;
 
entity top_tb is
end top_tb;
 
architecture behavior of top_tb is 
 
    component top
        port(
            clk         : in std_logic;
            poly_bcd    : in std_logic_vector(15 downto 0);
            i           : in std_logic_vector(15 downto 0);
            j           : in std_logic_vector(15 downto 0);
            opcode      : in std_logic_vector(5 downto 0);

            ------------ TEMPORARY - JUST FOR TB ------------
            t_rst_gen    : in std_logic;

            -- universal registers
            t_n         : out std_logic_vector(3 downto 0);
            t_m         : out std_logic_vector(3 downto 0);
            t_mask      : out std_logic_vector(15 downto 0);

            -- operation outputs
            t_bitxor    : out std_logic_vector(15 downto 0);
            t_prod      : out std_logic_vector(15 downto 0);
            t_quot      : out std_logic_vector(15 downto 0);

            -- generated terms
            t_addr      : out std_logic_vector(15 downto 0);
            t_sym       : out std_logic_vector(15 downto 0)
        );
    end component;

    --inputs
    signal opcode : std_logic_vector(5 downto 0) := (others => '0');
    signal poly_bcd : std_logic_vector(15 downto 0);
    signal i : std_logic_vector(15 downto 0);
    signal j : std_logic_vector(15 downto 0);

    ------------ TEMPORARY - JUST FOR TB ------------
    signal t_rst_gen : std_logic;

    -- universal registers
    signal t_n : std_logic_vector(3 downto 0);
    signal t_m : std_logic_vector(3 downto 0);
    signal t_mask : std_logic_vector(15 downto 0);

    -- operation outputs
    signal t_bitxor : std_logic_vector(15 downto 0);
    signal t_prod : std_logic_vector(15 downto 0);
    signal t_quot : std_logic_vector(15 downto 0);

    signal t_addr : std_logic_vector(15 downto 0);
    signal t_sym : std_logic_vector(15 downto 0);

    -- testbench clocks
    constant nums : integer := 320;
    signal clk : std_ulogic := '1';
 
begin
 
    -- instantiate the unit under test (uut)
    uut: top port map (
        clk => clk,
        poly_bcd => poly_bcd,
        i => i,
        j => j,
        opcode => opcode,
        t_rst_gen => t_rst_gen,
        t_n => t_n,
        t_m => t_m,
        t_mask => t_mask,
        t_bitxor => t_bitxor,
        t_prod => t_prod,
        t_quot => t_quot,
        t_addr => t_addr,
        t_sym => t_sym
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

        poly_bcd <= "0000000000011001";
        t_rst_gen <= '1';

        i <= "0000000000001011";
        j <= "0000000000001000";

        wait for 60 ns;

        t_rst_gen <= '0';

        wait for 680 ns;

        -- stop simulation
        assert false report "simulation ended" severity failure;

    end process;

end;
