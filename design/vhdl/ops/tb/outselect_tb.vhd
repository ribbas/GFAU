-- outselect_tb.vhd
--
-- Sabbir Ahmed, Jeffrey Osazuwa
-- 2018-01-16
--

library ieee;
use ieee.std_logic_1164.all;

entity outselect_tb is
end outselect_tb;

architecture behavioral of outselect_tb is

    constant n : positive := 8;

    -- component declaration for the unit under test (uut)
    component outselect
        generic(
            n       : positive
        );
        port(
            opcode  : in std_logic_vector(5 downto 0);
            out_as  : in std_logic_vector(n downto 0);
            out_m   : in std_logic_vector(n downto 0);
            out_d   : in std_logic_vector(n downto 0);
            out_l   : in std_logic_vector(n downto 0);
            i_null  : in std_logic;
            j_null  : in std_logic;
            out_sel : out std_logic_vector(n downto 0);
            mem_t   : out std_logic;
            convert : out std_logic;
            err_z   : out std_logic
        );
    end component;

    -- inputs
    signal opcode : std_logic_vector(5 downto 0) := (others => '0');
    signal out_as : std_logic_vector(n downto 0) := (others => '0');
    signal out_m : std_logic_vector(n downto 0) := (others => '0');
    signal out_d : std_logic_vector(n downto 0) := (others => '0');
    signal out_l : std_logic_vector(n downto 0) := (others => '0');
    signal i_null : std_logic;
    signal j_null : std_logic;

    -- outputs
    signal out_sel : std_logic_vector(n downto 0);
    signal convert : std_logic;
    signal mem_t : std_logic;
    signal err_z : std_logic;

    -- testbench clocks
    constant nums : integer := 320;
    signal clk : std_ulogic := '1';

begin

    -- instantiate the unit under test (uut)
    uut: outselect
    generic map(
        n => n
    )
    port map(
        opcode => opcode,
        out_as => out_as,
        out_m => out_m,
        out_d => out_d,
        out_l => out_l,
        i_null => i_null,
        j_null => j_null,
        out_sel => out_sel,
        mem_t => mem_t,
        convert => convert,
        err_z => err_z
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
    stim_proc : process
    begin

        -- hold reset state for 20 ns.
        wait for 40 ns;

        -- addsub
        opcode <= "001010";
        out_as <= "1111111111111110";
        out_m <= "0111111111111111";
        out_d <= "0011111111111111";
        out_l <= "0001111111111111";
        i_null <= '1';
        j_null <= '1';

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