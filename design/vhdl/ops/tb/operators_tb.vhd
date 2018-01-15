library ieee;
use ieee.std_logic_1164.all;

entity operators_tb is
end operators_tb;

architecture behavioral of operators_tb is

    -- component declaration for the unit under test (uut)     
    component operators
        port( 
            opcode      : in std_logic_vector(5 downto 0);  -- opcode
            i           : in std_logic_vector(15 downto 0); -- first element
            j           : in std_logic_vector(15 downto 0); -- second element
            n           : in std_logic_vector(3 downto 0);  -- size
            mask        : in std_logic_vector(15 downto 0);  -- mask
            result  : out std_logic_vector(15 downto 0) -- selected output
        );
    end component;

    -- inputs
    signal opcode : std_logic_vector(5 downto 0) := (others => '0');
    signal i : std_logic_vector(15 downto 0) := (others => '0');
    signal j : std_logic_vector(15 downto 0) := (others => '0');
    signal n : std_logic_vector(3 downto 0) := (others => '0');
    signal mask : std_logic_vector(15 downto 0) := (others => '0');

    -- outputs
    signal result : std_logic_vector(15 downto 0);

    -- testbench clocks
    constant nums : integer := 320;
    signal clk : std_ulogic := '1';

begin

    -- instantiate the unit under test (uut)
    uut: operators port map(
        opcode => opcode,
        i => i,
        j => j,
        n => n,
        mask => mask,
        result => result
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

        i <= "0000000000001001";
        j <= "0000000000001100";
        n <= "0100";
        mask <= "0000000000001111";

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