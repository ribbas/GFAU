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

            -- operation outputs
            FINALOUTPUT : out std_logic_vector(15 downto 0); -- selected output

            ------------ TEMPORARY - JUST FOR TB ------------
            t_rst_gen   : in std_logic;

            -- universal registers
            t_n         : out std_logic_vector(3 downto 0);
            t_m         : out std_logic_vector(3 downto 0);
            t_mask      : out std_logic_vector(15 downto 0);

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
    signal FINALOUTPUT : std_logic_vector(15 downto 0);

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
        FINALOUTPUT => FINALOUTPUT,
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

        i <= "0000000000001001";
        j <= "0000000000001100";

        wait for 60 ns;

        t_rst_gen <= '0';

        -- hold reset state for 40 ns.
        wait for 40 ns;

        -- add/sub
        opcode <= "001010";

        -- hold reset state for 40 ns.
        wait for 40 ns;

        -- mul
        opcode <= "010010";

        -- hold reset state for 40 ns.
        wait for 40 ns;

        -- div
        opcode <= "011010";

        -- hold reset state for 40 ns.
        wait for 40 ns;

        -- log
        opcode <= "100010";

        -- hold reset state for 40 ns.
        wait for 40 ns;

        -- convert
        opcode <= "000111";

        wait for 40 ns;

        -- stop simulation
        assert false report "simulation ended" severity failure;

    end process;

end;
