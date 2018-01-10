
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top is
    port(
        clk         : in std_logic;
        poly_bcd    : in std_logic_vector(15 downto 0);
        i           : in std_logic_vector(15 downto 0);
        j           : in std_logic_vector(15 downto 0);
        opcode      : in std_logic_vector(5 downto 0);

        -- TEMPORARY - JUST FOR TB
        size_reg    : out std_logic_vector(3 downto 0);
        msb_reg     : out std_logic_vector(3 downto 0);
        mask_reg    : out std_logic_vector(15 downto 0)
    );
end top;

architecture behavioral of top is

    ---------------- universal registers and constants ----------------

    -- size index
    component size
        port(
            poly_bcd    : in std_logic_vector(15 downto 0);
            n           : out std_logic_vector(3 downto 0)
        );
    end component;

    -- most significant bit index
    component msb is
        port(
            poly_bcd    : in std_logic_vector (15 downto 0);  -- BCD polynomial
            m           : out std_logic_vector(3 downto 0)    -- msb of element
       );
    end component;

    -- mask
    component varmask
        port(
            poly_bcd    : in  std_logic_vector(15 downto 0);
            mask        : out std_logic_vector(15 downto 0)
        );
    end component;

    ---------------- symbol generator ----------------

    -- generator controller
    component generator
        port(
            clk         : in std_logic;
            en          : in std_logic;
            rst         : in std_logic;

            -- polynomial data
            poly_bcd    : in std_logic_vector(15 downto 0);
            mask        : in std_logic_vector(15 downto 0);
            m           : in std_logic_vector(3 downto 0);
            n           : in std_logic_vector(3 downto 0);

            -- memory signals
            write_en    : out std_logic;
            addr        : out std_logic_vector(15 downto 0);
            sym1        : out std_logic_vector(15 downto 0);
            sym2        : out std_logic_vector(15 downto 0)
        );
    end component;

    ---------------- Galois operators ----------------

    -- addition / subtraction
    component addsub16
        port(
            i       : in std_logic_vector (15 downto 0);
            j       : in std_logic_vector (15 downto 0);
            bitxor  : out std_logic_vector (15 downto 0)
        );
    end component;

    -- multiplication
    component mul16
        port(
            i       : in std_logic_vector(15 downto 0);
            j       : in std_logic_vector(15 downto 0);
            n       : in std_logic_vector(3 downto 0);
            prod    : out std_logic_vector(15 downto 0)
        );
    end component;

    -- division
    component div16
        port(
            i       : in std_logic_vector (15 downto 0);
            j       : in std_logic_vector (15 downto 0);
            n       : in std_logic_vector (3 downto 0);
            mask    : in std_logic_vector (15 downto 0);
            quot    : out std_logic_vector (15 downto 0)
        );
    end component;

    ---------------- memory ----------------

    -- IS61LP6432A
    component IS61LP6432A is
        port(
            A       : in std_logic_vector(15 downto 0);
            clk     : in std_logic;
            nADSP   : in std_logic;
            nADSC   : in std_logic;
            nADV    : in std_logic;
            nBW     : in std_logic_vector(3 downto 0);
            nBWE    : in std_logic;
            nGW     : in std_logic;
            nCE     : in std_logic;
            nCE2    : in std_logic;
            CE2     : in std_logic;
            nOE     : in std_logic;
            DQ      : inout std_logic_vector(31 downto 0);
            MODE    : in std_logic;
            ZZ      : in std_logic
        );
    end component;

    signal en_gen : std_logic;  -- generator enable
    signal write_en : std_logic;  -- write enable

    signal rst_gen : std_logic;  -- generator enable

    -- generator data signals
    signal addr : std_logic_vector(15 downto 0);
    signal sym1 : std_logic_vector(15 downto 0);
    signal sym2 : std_logic_vector(15 downto 0);

    -- operation outputs
    signal bitxor : std_logic_vector(15 downto 0);
    signal prod : std_logic_vector(15 downto 0);
    signal quot : std_logic_vector(15 downto 0);

    -- constants
    signal mask : std_logic_vector(15 downto 0);  -- mask
    signal m : std_logic_vector(3 downto 0);  -- msb
    signal n : std_logic_vector(3 downto 0);  -- size

    signal A : std_logic_vector(15 downto 0);
    signal nADSP : std_logic;
    signal nADSC : std_logic;
    signal nADV : std_logic;
    signal nBW : std_logic_vector(3 downto 0);
    signal nBWE : std_logic;
    signal nGW : std_logic;
    signal nCE : std_logic;
    signal nCE2 : std_logic;
    signal CE2 : std_logic;
    signal nOE : std_logic;
    signal DQ : std_logic_vector(31 downto 0);
    signal MODE : std_logic;
    signal ZZ : std_logic;

begin

    ---------------- universal registers and constants ----------------

    -- size
    size_uut: size port map(
        poly_bcd => poly_bcd,
        n => size_reg
    );

    -- most significant bit
    msb_uut: msb port map(
        poly_bcd => poly_bcd,
        m => msb_reg
    );

    -- mask
    varmask_uut: varmask port map(
        poly_bcd => poly_bcd,
        mask => mask_reg
    );


    ---------------- symbol generator ----------------

    -- generator controller
    generator_uut: generator port map(
        clk => clk,
        rst => rst_gen,
        en => en_gen,
        poly_bcd => poly_bcd,
        mask => mask,
        m => m,
        n => n,
        write_en => write_en,
        addr => addr,
        sym1 => sym1,
        sym2 => sym2
    );


    ---------------- memories ----------------

    -- element memory
    mem1 : IS61LP6432A port map(
        A => A,
        clk => clk,
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
        DQ  => DQ,
        MODE => MODE,
        ZZ  => ZZ
    );

    -- polynomial memory
    mem2 : IS61LP6432A port map(
        A => A,
        clk => clk,
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
        DQ  => DQ,
        MODE => MODE,
        ZZ  => ZZ
    );


    ---------------- Galois operators ----------------

    -- addition / subtraction
    addsub_uut: addsub16 port map(
        i => i,
        j => j,
        bitxor => bitxor
    );

    -- multiplication
    mul_uut: mul16 port map(
        i => i,
        j => j,
        n => n,
        prod => prod
    );

    -- division
    div_uut: div16 port map(
        i => i,
        j => j,
        n => n,
        mask => mask,
        quot => quot
    );

end behavioral;
