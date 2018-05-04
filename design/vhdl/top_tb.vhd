-- top_tb.vhd
--
-- Sabbir Ahmed
-- 2018-01-16
--

library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;
library work;
    use work.glob.all;
    use work.demo_tb.all;

entity top_tb is
end top_tb;

architecture behavior of top_tb is

    constant n : positive := DEGREE;
    constant clgn : positive := CEILLGN;
    constant clgn1 : positive := CEILLGN1;

    component top
        generic(
            n       : positive := DEGREE;
            clgn    : positive := CEILLGN;  -- ceil(log2(n))
            clgn1   : positive := CEILLGN1   -- ceil(log2(n - 1))
        );
        port(
            -- master clock
            CLK     : in std_logic;

            -- master reset
            RST     : in std_logic;

            -- control unit enable
            ENCU    : in std_logic;

            -- user inputs
            POLYBCD : in std_logic_vector(n downto 1);
            OPCODE  : in std_logic_vector(5 downto 0);
            OPAND1  : in std_logic_vector(n downto 0);
            OPAND2  : in std_logic_vector(n downto 0);

            -- user output
            RESULT  : out std_logic_vector(n downto 0);

            -- IO interrupts
            RDYGEN  : out std_logic;
            RDYOUT  : out std_logic;
            ERRB    : out std_logic;
            ERRZ    : out std_logic;

            -- memory control signals
            nCE     : out std_logic;
            nWE     : out std_logic;
            nOE     : out std_logic;
            nBLE    : out std_logic;
            nBHE    : out std_logic;

            -- memory address and data signals
            A       : out std_logic_vector((n + 1) downto 0);
            IO      : inout std_logic_vector(n downto 0);

            -------------- TEMPORARY - JUST FOR TB ------------

            ---- universal registers
            t_size      : out std_logic_vector(clgn downto 0);
            t_msb       : out std_logic_vector(clgn1 downto 0);
            t_mask      : out std_logic_vector(n downto 0);

            ---- generated terms
            --t_addr      : out std_logic_vector(n downto 0);
            --t_sym       : out std_logic_vector(n downto 0)
            t_1         : out std_logic;
            t_n1      : out std_logic_vector(n downto 0);
            t_n2      : out std_logic_vector(n downto 0)
        );
    end component;

    --inputs
    signal CLK     : std_ulogic := '1';
    signal RST     : std_logic;
    signal ENCU    : std_logic := '0';
    signal POLYBCD : std_logic_vector(n - 1 downto 0);
    signal OPCODE  : std_logic_vector(5 downto 0);
    signal OPAND1  : std_logic_vector(n downto 0);
    signal OPAND2  : std_logic_vector(n downto 0);

    -- memory control signals
    signal nCE    : std_logic;
    signal nWE    : std_logic;
    signal nOE    : std_logic;
    signal nBLE   : std_logic;
    signal nBHE   : std_logic;

    -- outputs
    signal RESULT  : std_logic_vector(n downto 0);
    signal RDYGEN  : std_logic;
    signal RDYOUT  : std_logic;
    signal ERRB    : std_logic;
    signal ERRZ    : std_logic;
    signal A       : std_logic_vector((n + 1) downto 0);
    signal IO      : std_logic_vector(n downto 0);

    -------------- TEMPORARY - JUST FOR TB ------------

    ---- universal registers
    signal t_size : std_logic_vector(clgn downto 0);
    signal t_msb : std_logic_vector(clgn1 downto 0);
    signal t_mask : std_logic_vector(n downto 0);

    signal t_1 : std_logic;
    signal t_n1 : std_logic_vector(n downto 0);
    signal t_n2 : std_logic_vector(n downto 0);

    ---- memory signals
    --signal t_addr : std_logic_vector(n downto 0);
    --signal t_sym : std_logic_vector(n downto 0);

begin

    -- instantiate the unit under test (uut)
    uut: top port map (
        CLK => CLK,
        RST => RST,
        ENCU => ENCU,
        POLYBCD => POLYBCD,
        OPCODE => OPCODE,
        OPAND1 => OPAND1,
        OPAND2 => OPAND2,
        RESULT => RESULT,
        RDYGEN => RDYGEN,
        RDYOUT => RDYOUT,
        ERRB => ERRB,
        ERRZ => ERRZ,
        nCE => nCE,
        nWE => nWE,
        nOE => nOE,
        nBLE => nBLE,
        nBHE => nBHE,
        A => A,
        IO => IO,

        -- TEMPORARY SIGNALS
        --RST => RST,
        t_size => t_size,
        t_msb => t_msb,
        t_mask => t_mask,
        t_1 => t_1,
        t_n1 => t_n1,
        t_n2 => t_n2
        --t_addr => t_addr,
        --t_sym => t_sym
    );

    -- clock process
    clk_proc: process
    begin

        for i in 1 to TNUMS loop
            CLK <= not CLK;
            wait for (CLK_PER / 2);
        end loop;

    end process;

    -- stimulus process
    stim_proc: process
    begin

        POLYBCD <= "10001110";  -- x^8 + x^4 + x^3 + x^2 + 1
        OPAND1 <= "111111111";
        OPAND2 <= "000000011";
			
        wait for (CLK_PER * 1);
        ENCU <= '1';

        wait for (CLK_PER * 2);
        OPCODE <= "000XXX";  -- add, elem, elem, elem
			
        wait for (CLK_PER * 10);
        --ENCU <= '0';
        --OPCODE <= "000XXX";  -- generator
        POLYBCD <= "00000110";  -- x^3+x^2+x^0
        wait for (CLK_PER * 2000);

        -- stop simulation
        assert false report "simulation ended" severity failure;

        wait;

    end process;

end;
