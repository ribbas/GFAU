-- control_unit_tb.vhd
--
-- Sabbir Ahmed
-- 2018-01-16
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity control_unit_tb is
end control_unit_tb;

architecture behavior of control_unit_tb is

    -- component declaration for the unit under test (uut)
    component control_unit
        port(
            clk         : in std_logic;
            opcode      : in std_logic_vector(5 downto 0);   -- op code
            opand1      : in std_logic_vector(15 downto 0);   -- operand 1
            opand2      : in std_logic_vector(15 downto 0);   -- operand 2

            -- registers
            mask        : in  std_logic_vector(15 downto 0);

            -- generation signals
            en_gen      : out std_logic;  -- term generator enable
            rst_gen     : out std_logic;  -- term generator reset

            -- operation signals
            i           : out std_logic_vector(15 downto 0);  -- i
            j           : out std_logic_vector(15 downto 0);  -- j

            -- memory signals
            mem_data    : in std_logic_vector(15 downto 0);  -- memory data
            mem_addr    : out std_logic_vector(15 downto 0);  -- memory addr
            mem_t       : inout std_logic;  -- which memory
            mem_rd      : out std_logic;  -- read signal to memory

            -- exceptions
            err_b       : out std_logic;  -- out of bound exception
            err_z       : out std_logic  -- zero exception
        );
    end component;

    signal rst_gen : std_logic;

    -- inputs
    signal opcode : std_logic_vector(5 downto 0);   -- op code
    signal opand1 : std_logic_vector(15 downto 0);   -- operand 1
    signal opand2 : std_logic_vector(15 downto 0);   -- operand 2
    signal mask : std_logic_vector(15 downto 0);   -- mask

    -- outputs
    signal err_b : std_logic;
    signal err_z : std_logic;
    signal en_gen : std_logic;  -- poly generation
    signal i : std_logic_vector(15 downto 0);  -- address in memory
    signal j : std_logic_vector(15 downto 0);  -- address in memory
    signal mem_t : std_logic;  -- which memory - 0 for elem, 1 for poly
    signal mem_rd : std_logic;  -- read signal to memory
    signal mem_addr : std_logic_vector(15 downto 0);  -- address in memory
    signal mem_data : std_logic_vector(15 downto 0) := "0000000000000000";  -- data from memory

    -- testbench clocks
    constant t_nums : integer := 320;
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
        mem_rd => mem_rd,
        mem_addr => mem_addr,
        mem_data => mem_data,
        err_b => err_b,
        err_z => err_z
    );

    -- clock process
    clk_proc: process
    begin

        for i in 1 to t_nums loop
            clk <= not clk;
            mem_data <= std_logic_vector(unsigned(mem_data) + 1);
            wait for 20 ns;
            -- clock period = 50 MHz
        end loop;

    end process;

    -- stimulus process
    test : process
    begin

        mask <= "0000000000001111";
        opand1 <= "0000000000001001";
        --opand2 <= "0000000000001100";
        opand2 <= "1111111111111111";  -- zero in element

        opcode <= "00100X";  -- add/sub, operands in element

        wait for 100 ns;

        opcode <= "00111X"; -- add/sub, m1, m2 exponent  

        wait for 100 ns;

        opcode <= "00101X"; -- add/sub, m1, m2 exponent  

        wait for 100 ns;

        -- stop simulation
        assert false report "simulation ended" severity failure;

        wait;

    end process;

end;
