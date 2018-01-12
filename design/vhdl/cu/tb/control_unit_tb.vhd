-- control_unit testbench
library ieee;
use ieee.std_logic_1164.all;

entity control_unit_tb is
end control_unit_tb;

architecture behavior of control_unit_tb is

    -- component declaration for the unit under test (uut)
    component control_unit
        port(
            clk         : in std_logic;
            rst         : in std_logic;
            opcode      : in std_logic_vector(5 downto 0);   -- op code
            poly_bcd    : in std_logic_vector(15 downto 0);   -- BCD polynomial
            op1         : in std_logic_vector(15 downto 0);   -- operand 1
            op2         : in std_logic_vector(15 downto 0);   -- operand 2
            en_gen      : out std_logic;  -- polynomial generator enable
            i           : out std_logic_vector(15 downto 0);  -- i
            j           : out std_logic_vector(15 downto 0);  -- j
            mem_t       : out std_logic;  -- which memory
            mem_rd      : out std_logic;  -- read signal to memory
            mem_addr    : out std_logic_vector(15 downto 0);  -- mem address
            mem_data    : in std_logic_vector(15 downto 0)  -- mem data
        );
    end component;

    signal rst : std_logic;

    -- inputs
    signal opcode : std_logic_vector(5 downto 0);   -- op code
    signal poly_bcd : std_logic_vector(15 downto 0);   -- op code
    signal op1 : std_logic_vector(15 downto 0);   -- op code
    signal op2 : std_logic_vector(15 downto 0);   -- op code

    -- outputs
    signal en_gen : std_logic;  -- poly generation
    signal i : std_logic_vector(15 downto 0);  -- address in memory
    signal j : std_logic_vector(15 downto 0);  -- address in memory
    signal mem_t : std_logic;  -- which memory - 0 for elem, 1 for poly
    signal mem_rd : std_logic;  -- read signal to memory
    signal mem_addr : std_logic_vector(15 downto 0);  -- address in memory
    signal mem_data : std_logic_vector(15 downto 0);  -- data from memory

    -- testbench clocks
    constant nums : integer := 320;
    signal clk : std_ulogic := '1';

begin

    -- instantiate the unit under test (uut)
    uut: control_unit port map(
        clk => clk,
        rst => rst,
        opcode => opcode,
        poly_bcd => poly_bcd,
        op1 => op1,
        op2 => op2,
        en_gen => en_gen,
        i => i,
        j => j,
        mem_t => mem_t,
        mem_rd => mem_rd,
        mem_addr => mem_addr,
        mem_data => mem_data
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
    test : process
    begin

        --wait for 400 ns; 

        opcode <= "001000"; -- add/sub, m1, m2 exponent  
        poly_bcd <= "0000000000010011";
        op1 <= "0000000000001001";
        op2 <= "0000000000001100";
        mem_data <= "0000000000000001";
        wait for 60 ns;

        mem_data <= "0000000000000010";
        wait for 40 ns;

        opcode <= "010000"; -- add/sub, m1, m2 exponent  
        mem_data <= "0000000000000011";

        wait for 100 ns;

        opcode <= "000111"; -- add/sub, m1, m2 exponent  
        mem_data <= "0000000000000011";

        wait for 1000 ns;

        -- stop simulation
        assert false report "simulation ended" severity failure;

        wait;

    end process;

end;
