
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top is
    port(
        CLK         : in std_logic;
        POLYBCD     : in std_logic_vector(15 downto 0);
        i           : in std_logic_vector(15 downto 0);
        j           : in std_logic_vector(15 downto 0);
        opcode      : in std_logic_vector(5 downto 0);

        -- operation outputs
        FINALOUTPUT : out std_logic_vector(15 downto 0); -- selected output

        ------------ TEMPORARY - JUST FOR TB ------------
        t_rst_gen   : in std_logic;

        -- universal registers
        t_n         : out std_logic_vector(3 downto 0);
        t_m         : out std_logic_vector(3 downto 0);
        t_mask      : out std_logic_vector(15 downto 0);

        -- generated terms
        t_addr      : out std_logic_vector(15 downto 0);
        t_sym       : out std_logic_vector(15 downto 0)
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
            rdy         : out std_logic;
            addr        : out std_logic_vector(15 downto 0);
            sym1        : out std_logic_vector(15 downto 0);
            sym2        : out std_logic_vector(15 downto 0)
        );
    end component;

    ---------------- Galois operators ----------------

    component operators
        port( 
            opcode      : in std_logic_vector(5 downto 0);  -- opcode
            i           : in std_logic_vector(15 downto 0); -- first element
            j           : in std_logic_vector(15 downto 0); -- second element
            n           : in std_logic_vector(3 downto 0);  -- size
            mask        : in std_logic_vector(15 downto 0);  -- mask
            FINALOUTPUT : out std_logic_vector(15 downto 0) -- selected output
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

    signal en_gen : std_logic := '1';  -- generator enable
    signal rdy_gen : std_logic := '1';  -- generator enable
    signal write_en : std_logic;  -- write enable

    signal rst_gen : std_logic;  -- generator enable

    -- generator data signals
    signal addr : std_logic_vector(15 downto 0);
    signal sym1 : std_logic_vector(15 downto 0);
    signal sym2 : std_logic_vector(15 downto 0);

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
    size_unit: size port map(
        poly_bcd => POLYBCD,
        n => n
    );

    -- most significant bit
    msb_unit: msb port map(
        poly_bcd => POLYBCD,
        m => m
    );

    -- mask
    varmask_unit: varmask port map(
        poly_bcd => POLYBCD,
        mask => mask
    );

    ---------------- symbol generator ----------------

    -- generator controller
    generator_unit: generator port map(
        clk => clk,
        rst => t_rst_gen,
        en => en_gen,
        poly_bcd => POLYBCD,
        mask => mask,
        m => m,
        n => n,
        write_en => write_en,
        rdy => rdy_gen,
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

    operators_unit: operators port map(
        opcode => opcode,
        i => i,
        j => j,
        n => n,
        mask => mask,
        FINALOUTPUT => FINALOUTPUT
    );

    ---------------- TEMPORARY OUTPUTS ----------------
    t_m <= m;
    t_n <= n;
    t_mask <= mask;
    t_addr <= addr;
    t_sym <= sym1;

end behavioral;
