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
            -- TEMPORARY - JUST FOR TB
            size_reg    : out std_logic_vector(3 downto 0);
            msb_reg     : out std_logic_vector(3 downto 0);
            mask_reg    : out std_logic_vector(15 downto 0)
        );
    end component;

    --inputs
    signal opcode : std_logic_vector(5 downto 0) := (others => '0');
    signal poly_bcd : std_logic_vector(15 downto 0);
    signal i : std_logic_vector(15 downto 0);
    signal j : std_logic_vector(15 downto 0);

    signal size_reg : std_logic_vector(3 downto 0);
    signal msb_reg : std_logic_vector(3 downto 0);
    signal mask_reg : std_logic_vector(15 downto 0);

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
        size_reg => size_reg,
        msb_reg => msb_reg,
        mask_reg => mask_reg
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
        -- hold reset state for 100 ns.
        wait for 100 ns;

        poly_bcd <= "0000000000011001";

        wait for 500 ns;

        -- stop simulation
        assert false report "simulation ended" severity failure;

    end process;

end;
