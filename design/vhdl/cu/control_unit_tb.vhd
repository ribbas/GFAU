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
            op          : in std_logic_vector(5 downto 0);
            m1          : in std_logic_vector(15 downto 0);
            m2          : in std_logic_vector(15 downto 0);
            m           : inout std_logic_vector(15 downto 0);
            gen_term    : out std_logic;
            enable      : out std_logic;
            sel         : out std_logic;
            m1_out      : out std_logic_vector(15 downto 0);
            m2_out      : out std_logic_vector(15 downto 0);
            A           : out std_logic_vector(15 downto 0);
            nADSP       : out std_logic;
            nADSC       : out std_logic;
            nADV        : out std_logic;
            nBW         : out std_logic_vector(3 downto 0);
            nBWE        : out std_logic;
            nGW         : out std_logic;
            nCE         : out std_logic;
            nCE2        : out std_logic;
            CE2         : out std_logic;
            nOE         : out std_logic;
            DQ          : inout std_logic_vector(31 downto 0);
            MODE        : out std_logic;
            ZZ          : out std_logic
        );
    end component;

    -- inputs
    signal clk  : std_logic := '0';
    signal op   : std_logic_vector(5 downto 0) := (others => '0');
    signal m1   : std_logic_vector(15 downto 0) := (others => '0');
    signal m2   : std_logic_vector(15 downto 0) := (others => '0');

    -- bidirs
    signal m    : std_logic_vector(15 downto 0);
    signal DQ   : std_logic_vector(31 downto 0);

    -- outputs
    signal gen_term : std_logic;
    signal enable   : std_logic;
    signal sel      : std_logic;
    signal m1_out   : std_logic_vector(15 downto 0);
    signal m2_out   : std_logic_vector(15 downto 0);
    signal A        : std_logic_vector(15 downto 0);
    signal nADSP    : std_logic;
    signal nADSC    : std_logic;
    signal nADV     : std_logic;
    signal nBW      : std_logic_vector(3 downto 0);
    signal nBWE     : std_logic;
    signal nGW      : std_logic;
    signal nCE      : std_logic;
    signal nCE2     : std_logic;
    signal CE2      : std_logic;
    signal nOE      : std_logic;
    signal MODE     : std_logic;
    signal ZZ       : std_logic;

    -- clock period definitions
    --constant clk_period : time := 10 ns;

begin

    -- instantiate the unit under test (uut)
    uut: control_unit port map(
        clk => clk,
        op => op,
        m1 => m1,
        m2 => m2,
        m => m,
        gen_term => gen_term,
        enable => enable,
        sel => sel,
        m1_out => m1_out,
        m2_out => m2_out,
        A => A,
        nADSP => nADSP,
        nADSC => nADSC,
        nADV => nADV,
        nBW => nBW,
        nBWE => nBWE,
        nGW => nGW,
        nCE => nCE,
        nCE2 => nCE2,
        CE2 => CE2,
        nOE => nOE,
        DQ => DQ,
        MODE => MODE,
        ZZ => ZZ
    );

    -- clock process definitions
    clock : process
    begin

        clk <= '0';
        wait for 50 ns;
        clk <= '1';
        wait for 50 ns;
    end process;

    -- stimulus process
    test : process
    begin

        --op <= "000000"; -- generate terms
        --wait for 400 ns; 

        op <= "001010"; -- add/sub, m1, m2 exponent  
        m1 <= "1010101010101010";
        m2 <= "0101010101010101";
        wait for 400 ns;

        op <= "010000";
        m1 <= "1111111111111111";
        m2 <= "0000000000000000";
        wait for 400 ns;

        wait;

    end process;

end;
