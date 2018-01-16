-- top.vhd
--
-- Sabbir Ahmed
-- 2018-01-16
--
-- The top level module for Galois Field Arithmetic Unit.
--


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top is
    port(
        CLK     : in std_logic;
        POLYBCD : in std_logic_vector(15 downto 0);
        OPCODE  : in std_logic_vector(5 downto 0);
        OPAND1  : in std_logic_vector(15 downto 0);
        OPAND2  : in std_logic_vector(15 downto 0);
        RESULT  : out std_logic_vector(15 downto 0);
        RDYGEN  : out std_logic;
        ERRB    : out std_logic;
        ERRZ    : out std_logic;

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

    component control_unit
        port(
            clk         : in std_logic;
            rst         : in std_logic;
            opcode      : in std_logic_vector(5 downto 0);   -- op code
            poly_bcd    : in std_logic_vector(15 downto 0);   -- BCD polynomial
            opand1      : in std_logic_vector(15 downto 0);   -- operand 1
            opand2      : in std_logic_vector(15 downto 0);   -- operand 2

            -- registers
            mask        : in  std_logic_vector(15 downto 0);

            -- generation signals
            en_gen      : out std_logic;  -- polynomial generator enable
            rst_gen     : out std_logic;  -- polynomial generator reset

            -- operation signals
            i           : out std_logic_vector(15 downto 0);  -- i
            j           : out std_logic_vector(15 downto 0);  -- j

            -- memory signals
            mem_data    : in std_logic_vector(15 downto 0);  -- mem data
            mem_addr    : out std_logic_vector(15 downto 0);  -- mem address
            mem_t       : inout std_logic;  -- which memory
            mem_rd      : out std_logic;  -- read signal to memory

            -- exceptions
            err_b       : out std_logic;  -- out of bound exception
            err_z       : out std_logic  -- zero exception
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
            opcode  : in std_logic_vector(5 downto 0);  -- opcode
            i       : in std_logic_vector(15 downto 0); -- first element
            j       : in std_logic_vector(15 downto 0); -- second element
            n       : in std_logic_vector(3 downto 0);  -- size
            mask    : in std_logic_vector(15 downto 0);  -- mask
            result  : out std_logic_vector(15 downto 0) -- selected output
        );
    end component;

    ---------------- memory ----------------

    ---- IS61LP6432A
    --component IS61LP6432A is
    --    port(
    --        A       : in std_logic_vector(15 downto 0);
    --        clk     : in std_logic;
    --        nADSP   : in std_logic;
    --        nADSC   : in std_logic;
    --        nADV    : in std_logic;
    --        nBW     : in std_logic_vector(3 downto 0);
    --        nBWE    : in std_logic;
    --        nGW     : in std_logic;
    --        nCE     : in std_logic;
    --        nCE2    : in std_logic;
    --        CE2     : in std_logic;
    --        nOE     : in std_logic;
    --        DQ      : inout std_logic_vector(31 downto 0);
    --        MODE    : in std_logic;
    --        ZZ      : in std_logic
    --    );
    --end component;

    -- constants
    signal mask : std_logic_vector(15 downto 0);  -- mask
    signal m : std_logic_vector(3 downto 0);  -- msb
    signal n : std_logic_vector(3 downto 0);  -- size

    -- generator data signals
    signal addr : std_logic_vector(15 downto 0);
    signal sym1 : std_logic_vector(15 downto 0);
    signal sym2 : std_logic_vector(15 downto 0);

    -- generator control signals
    signal en_gen : std_logic := '1';  -- enable
    signal rst_gen : std_logic;  -- reset

    -- internal operation signals
    signal i : std_logic_vector(15 downto 0);
    signal j : std_logic_vector(15 downto 0);

    -- memory control signals
    signal mem_t : std_logic;  -- memory type
    signal mem_wr : std_logic;  -- write enable
    signal mem_rd : std_logic;  -- read enable
    signal mem_addr : std_logic_vector(15 downto 0);  -- memory address
    signal mem_data : std_logic_vector(15 downto 0);  -- memory data

    --signal A : std_logic_vector(15 downto 0);
    --signal nADSP : std_logic;
    --signal nADSC : std_logic;
    --signal nADV : std_logic;
    --signal nBW : std_logic_vector(3 downto 0);
    --signal nBWE : std_logic;
    --signal nGW : std_logic;
    --signal nCE : std_logic;
    --signal nCE2 : std_logic;
    --signal CE2 : std_logic;
    --signal nOE : std_logic;
    --signal DQ : std_logic_vector(31 downto 0);
    --signal MODE : std_logic;
    --signal ZZ : std_logic;

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

    cu: control_unit port map(
        clk => clk,
        rst => t_rst_gen,
        opcode => OPCODE,
        poly_bcd => POLYBCD,
        opand1 => OPAND1,
        opand2 => OPAND2,
        mask => mask,
        en_gen => en_gen,
        rst_gen => rst_gen,
        i => i,
        j => j,
        mem_t => mem_t,
        mem_rd => mem_rd,
        mem_addr => mem_addr,
        mem_data => mem_data,
        err_b => ERRB,
        err_z => ERRZ
    );

    ---------------- symbol generator ----------------

    -- generator controller
    generator_unit: generator port map(
        clk => clk,
        rst => rst_gen,
        en => en_gen,
        rdy => RDYGEN,
        poly_bcd => POLYBCD,
        mask => mask,
        m => m,
        n => n,
        write_en => mem_wr,
        addr => addr,
        sym1 => sym1,
        sym2 => sym2
    );


    ------------------ memories ----------------

    ---- element memory
    --mem1 : IS61LP6432A port map(
    --    A => A,
    --    clk => CLK,
    --    nADSP => nADSP,
    --    nADSC => nADSC,
    --    nADV => nADV,
    --    nBW => nBW,
    --    nBWE => nBWE,
    --    nGW => nGW,
    --    nCE => nCE,
    --    nCE2 => nCE2,
    --    CE2 => CE2,
    --    nOE => nOE,
    --    DQ  => DQ,
    --    MODE => MODE,
    --    ZZ  => ZZ
    --);

    ---- polynomial memory
    --mem2 : IS61LP6432A port map(
    --    A => A,
    --    clk => CLK,
    --    nADSP => nADSP,
    --    nADSC => nADSC,
    --    nADV => nADV,
    --    nBW => nBW,
    --    nBWE => nBWE,
    --    nGW => nGW,
    --    nCE => nCE,
    --    nCE2 => nCE2,
    --    CE2 => CE2,
    --    nOE => nOE,
    --    DQ  => DQ,
    --    MODE => MODE,
    --    ZZ  => ZZ
    --);


    ---------------- Galois operators ----------------

    operators_unit: operators port map(
        opcode => OPCODE,
        i => i,
        j => j,
        n => n,
        mask => mask,
        result => RESULT
    );


    ---------------- TEMPORARY OUTPUTS ----------------
    t_m <= m;
    t_n <= n;
    t_mask <= mask;
    t_addr <= addr;
    t_sym <= sym1;


end behavioral;
