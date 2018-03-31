-- operators_tb.vhd
--
-- Sabbir Ahmed
-- 2018-01-16
--

library ieee;
    use ieee.std_logic_1164.all;
library work;
    use work.demo.all;
    use work.demo_tb.all;

entity operators_tb is
end operators_tb;

architecture behavioral of operators_tb is

    constant n : positive := DEGREE;
    constant clgn : positive := CEILLGN;

    -- component declaration for the unit under test (uut)
    component operators
        port(
            -- clock
            clk         : in std_logic;

            -- opcode
            opcode      : in std_logic_vector(5 downto 0);

            -- operands
            i           : in std_logic_vector(n downto 0);
            j           : in std_logic_vector(n downto 0);

            -- operand null flags
            i_null      : in std_logic;
            j_null      : in std_logic;

            -- registers
            size        : in std_logic_vector(clgn downto 0);  -- size
            mask        : in std_logic_vector(n downto 0);  -- mask

            -- memory types and methods
            mem_t       : out std_logic; -- memory type

            -- memory wrapper control signals
            id_con      : out std_logic;
            mem_rdy     : in std_logic;

            -- memory address and data signals
            addr_con    : out std_logic_vector((n + 1) downto 0);
            dout_con    : inout std_logic_vector(n downto 0);

            result      : out std_logic_vector(n downto 0); -- selected output
            err_z       : out std_logic -- zero exception
        );
    end component;

    -- inputs
    signal opcode : std_logic_vector(5 downto 0) := (others => '0');
    signal i : std_logic_vector(n downto 0) := (others => '0');
    signal j : std_logic_vector(n downto 0) := (others => '0');
    signal i_null : std_logic;
    signal j_null : std_logic;
    signal size : std_logic_vector(clgn downto 0) := (others => '0');
    signal mask : std_logic_vector(n downto 0) := (others => '0');

    -- outputs
    signal out_sel : std_logic_vector(n downto 0);
    signal addr_con : std_logic_vector((n + 1) downto 0);
    signal dout_con : std_logic_vector(n downto 0);
    signal id_con : std_logic;
    signal mem_t : std_logic;
    signal mem_rdy : std_logic;
    signal err_z : std_logic;

    -- testbench clocks
    signal clk : std_ulogic := '1';

begin

    -- instantiate the unit under test (uut)
    uut: operators port map(
        clk => clk,
        opcode => opcode,
        i => i,
        j => j,
        i_null => i_null,
        j_null => j_null,
        size => size,
        mask => mask,
        out_sel => out_sel,
        mem_t=> mem_t,
        err_z => err_z
    );

    -- clock process
    clk_proc: process
    begin

        for i in 1 to TNUMS loop
            clk <= not clk;
            wait for (CLK_PER / 2);
            -- clock period = 50 MHz
        end loop;

    end process;

    -- stimulus process
    stim_proc: process
    begin

        i <= "000001001";
        j <= "000000000";
        i_null <= '0';
        j_null <= '1';
        size <= "0100";
        mask <= "000001111";

        -- hold reset state for 40 ns.
        wait for 40 ns;

        -- add/sub
        opcode <= "001011";

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