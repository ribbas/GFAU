-- control_unit_tb.vhd
--
-- Sabbir Ahmed
-- 2018-01-16
--

library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;
library work;
    use work.demo.all;
    use work.demo_tb.all;

entity control_unit_tb is
end control_unit_tb;

architecture behavior of control_unit_tb is

    constant n : positive := DEGREE;

    -- component declaration for the unit under test (uut)
    component control_unit
        port(
            clk         : in std_logic;
            opcode      : in std_logic_vector(5 downto 1);   -- op code
            opand1      : in std_logic_vector(n downto 0);   -- operand 1
            opand2      : in std_logic_vector(n downto 0);   -- operand 2

            -- registers
            mask        : in  std_logic_vector(n downto 0);

            -- generation signals
            en_gen      : out std_logic;  -- polynomial generator enable
            rst_gen     : out std_logic;  -- polynomial generator reset

            -- operation signals
            i           : out std_logic_vector(n downto 0);  -- i
            j           : out std_logic_vector(n downto 0);  -- j

            -- memory types and methods
            mem_t       : out std_logic; -- memory type

            -- memory wrapper control signals
            id_cu       : out std_logic;
            mem_rdy     : in std_logic;

            -- memory address and data signals
            addr_cu     : out std_logic_vector(n downto 0);
            dout_cu     : in std_logic_vector(n downto 0);

            -- exceptions and flags
            err_b       : out std_logic;  -- set membership exception
            opand1_null : out std_logic;  -- operand 1 zero flag
            opand2_null : out std_logic  -- operand 2 zero flag
        );
    end component;

    -- inputs
    signal opcode : std_logic_vector(5 downto 1);   -- op code
    signal opand1 : std_logic_vector(n downto 0);   -- operand 1
    signal opand2 : std_logic_vector(n downto 0);   -- operand 2
    signal mask : std_logic_vector(n downto 0);   -- mask

    -- outputs
    signal rst_gen : std_logic;
    signal en_gen : std_logic;  -- poly generation
    signal i : std_logic_vector(n downto 0);  -- address in memory
    signal j : std_logic_vector(n downto 0);  -- address in memory
    signal err_b : std_logic;
    signal opand1_null : std_logic;
    signal opand2_null : std_logic;

    -- memory signals
    signal mem_rdy : std_logic := '1';  -- read signal to memory
    signal mem_t : std_logic;  -- which memory - 0 for elem, 1 for poly
    signal id_cu : std_logic;  -- read signal to memory
    signal addr_cu : std_logic_vector(n downto 0);  -- address in memory
    signal dout_cu : std_logic_vector(n downto 0) := "000000000";  -- data from memory

    -- clocks
    signal clk : std_ulogic := '1';

begin

    -- instantiate the unit under test (uut)
    uut: control_unit port map(
        clk => clk,
        opcode => opcode,
        opand1 => opand1,
        opand2 => opand2,
        mask => mask,
        en_gen => en_gen,
        rst_gen => rst_gen,
        i => i,
        j => j,
        mem_t => mem_t,
        id_cu => id_cu,
        mem_rdy => mem_rdy,
        addr_cu => addr_cu,
        dout_cu => dout_cu,
        err_b => err_b,
        opand1_null => opand1_null,
        opand2_null => opand2_null
    );

    -- clock process
    clk_proc: process
    begin

        for i in 1 to TNUMS loop
            clk <= not clk;
            wait for (CLK_PER / 2);
        end loop;

    end process;

    -- data process
    data_proc: process
    begin

        for i in 1 to TNUMS loop
            dout_cu <= std_logic_vector(unsigned(dout_cu) + 1);
            wait for (CLK_PER * 2);
        end loop;

    end process;

    mem_proc: process
    begin

        for i in 1 to TNUMS loop
            mem_rdy <= not mem_rdy;
            wait for (CLK_PER / 2);
        end loop;

    end process;

    -- stimulus process
    test : process
    begin

        mask <= "000000111";
        opand1 <= "000000101";
        opand2 <= "000000011";

        opcode <= "00100";  -- add/sub, operands in element
        wait for (CLK_PER * 4);

        opand1 <= "000000111";  -- 2^n-1
        opand2 <= "111111111";  -- zero in element
        opcode <= "01100";  -- division, operands in element
        wait for (CLK_PER * 4);

        opcode <= "000XX";  -- generator
        wait for (CLK_PER * 2);

        -- stop simulation
        assert false report "simulation ended" severity failure;

        wait;

    end process;

end;
