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
            addr_con    : out std_logic_vector(n downto 0);
            dout_con    : inout std_logic_vector(n downto 0);

            result      : out std_logic_vector(n downto 0); -- selected output
            err_z       : out std_logic -- zero exception
        );
    end component;

    -- inputs
    signal opcode : std_logic_vector(5 downto 0);
    signal i : std_logic_vector(n downto 0);
    signal j : std_logic_vector(n downto 0);
    signal i_null : std_logic;
    signal j_null : std_logic;
    signal size : std_logic_vector(clgn downto 0);
    signal mask : std_logic_vector(n downto 0);

    -- outputs
    signal addr_con : std_logic_vector(n downto 0);
    signal dout_con : std_logic_vector(n downto 0);
    signal id_con : std_logic;
    signal mem_t : std_logic;
    signal mem_rdy : std_logic;
    signal err_z : std_logic;
    signal result : std_logic_vector(n downto 0);

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
        mem_t => mem_t,
        id_con => id_con,
        mem_rdy => mem_rdy,
        addr_con => addr_con,
        dout_con => dout_con,
        result => result,
        err_z => err_z
    );

    -- clock process
    clk_proc: process
    begin

        for i in 1 to TNUMS loop
            clk <= not clk;
            wait for (CLK_PER / 2);
        end loop;

    end process;

    -- stimulus process
    stim_proc: process
    begin

        i <= "000000101";
        j <= "000000011";
        i_null <= '0';
        j_null <= '0';
        size <= "0011";
        mask <= "000000111";
        dout_con <= "000000010";

        -- generator
        opcode <= "000000";

        -- hold reset state for 10 ns
        wait for (CLK_PER * 3);

        -- add/sub, poly, elem
        opcode <= "001011";

        -- hold reset state for 10 ns
        wait for (CLK_PER * 3);

        -- mul, poly, elem
        opcode <= "010000";

        -- hold reset state for 10 ns
        wait for (CLK_PER * 3);

        -- div, poly, elem
        opcode <= "011000";

        -- hold reset state for 10 ns
        wait for (CLK_PER * 3);

        mem_rdy <= '1';

        -- log, elem, poly
        opcode <= "100010";

        wait for (CLK_PER * 3);

        -- stop simulation
        assert false report "simulation ended" severity failure;

    end process;

end;