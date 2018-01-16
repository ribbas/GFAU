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

    -- component declaration for the unit under test (uut)     
    component outselect
        port( 
            opcode      : in std_logic_vector(5 downto 0);
            addsubop    : in std_logic_vector(15 downto 0);
            mulop       : in std_logic_vector(15 downto 0);
            divop       : in std_logic_vector(15 downto 0);
            logop       : in std_logic_vector(15 downto 0);
            sel_out     : out std_logic_vector(15 downto 0);
            mem_t       : out std_logic;
            convert     : out std_logic
        );
    end component;

    -- inputs
    signal opcode : std_logic_vector(5 downto 0) := (others => '0');
    signal addsubop : std_logic_vector(15 downto 0) := (others => '0');
    signal mulop : std_logic_vector(15 downto 0) := (others => '0');
    signal divop : std_logic_vector(15 downto 0) := (others => '0');
    signal logop : std_logic_vector(15 downto 0) := (others => '0');

    -- outputs
    signal sel_out : std_logic_vector(15 downto 0);
    signal convert : std_logic;

    -- testbench clocks
    constant nums : integer := 320;
    signal clk : std_ulogic := '1';

begin

    -- instantiate the unit under test (uut)
    uut: outselect port map(
        opcode => opcode,
        addsubop => addsubop,
        mulop => mulop,
        divop => divop,
        logop => logop,
        sel_out => sel_out,
        convert => convert
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

        -- hold reset state for 20 ns.
        wait for 40 ns;

        -- addsub
        opcode <= "001010";
        addsubop <= "1111111111111111";
        mulop <= "0111111111111111";
        divop <= "0011111111111111";
        logop <= "0001111111111111";

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