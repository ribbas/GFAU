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
        RST     : in std_logic;
        POLYBCD : in std_logic_vector(15 downto 0);
        OPCODE  : in std_logic_vector(5 downto 0);
        OPAND1  : in std_logic_vector(15 downto 0);
        OPAND2  : in std_logic_vector(15 downto 0);
        RESULT  : out std_logic_vector(15 downto 0);
        RDYGEN  : out std_logic;
        ERRB    : out std_logic;
        ERRZ    : out std_logic

        -------------- TEMPORARY - JUST FOR TB ------------

        ---- universal registers
        --t_n         : out std_logic_vector(3 downto 0);
        --t_m         : out std_logic_vector(3 downto 0);
        --t_mask      : out std_logic_vector(15 downto 0);

        ---- generated terms
        --t_addr      : out std_logic_vector(15 downto 0);
        --t_sym       : out std_logic_vector(15 downto 0)
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
            opcode      : in std_logic_vector(5 downto 0);   -- op code
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
            mem_data    : in std_logic_vector(15 downto 0);  -- data
            mem_addr    : out std_logic_vector(15 downto 0);  -- address
            mem_t       : inout std_logic;  -- which memory
            mem_rd      : out std_logic;  -- read signal to memory

            -- exceptions
            err_b       : out std_logic;  -- out of bound exception
            opand1_null : out std_logic;  -- zero exception
            opand2_null : out std_logic  -- zero exception
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
            clk     : in std_logic;
            opcode  : in std_logic_vector(5 downto 0);  -- opcode
            i       : in std_logic_vector(15 downto 0); -- first opand
            j       : in std_logic_vector(15 downto 0); -- second opand
            i_null  : in std_logic;  -- opand 1 null flag
            j_null  : in std_logic;  -- opand 2 null flag
            n       : in std_logic_vector(3 downto 0);  -- size of polynomial
            mask    : in std_logic_vector(15 downto 0);  -- mask
            out_sel : out std_logic_vector(15 downto 0); -- selected output
            convert : out std_logic; -- convert flag
            mem_t   : out std_logic; -- memory type
            err_z   : out std_logic -- zero exception
        );
    end component;

    ---------------- memory ----------------

    -- IS61LP6432A chips wrapper
    component memory is
        port(
            clk         : in std_logic;
            mem_t       : in std_logic;
            mem_rd      : in std_logic;
            mem_wr      : in std_logic;
            addr_in     : in std_logic_vector(15 downto 0);
            addr_out    : in std_logic_vector(15 downto 0);
            data_in     : in std_logic_vector(15 downto 0);
            data_out    : out std_logic_vector(15 downto 0)
        );
    end component;

    -- constants
    signal mask : std_logic_vector(15 downto 0);  -- mask
    signal m : std_logic_vector(3 downto 0);  -- msb
    signal n : std_logic_vector(3 downto 0);  -- size

    -- generator data signals
    --signal addr : std_logic_vector(15 downto 0);
    --signal sym1 : std_logic_vector(15 downto 0);
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
    signal mem_addr_in : std_logic_vector(15 downto 0);  -- memory address
    signal mem_addr_out : std_logic_vector(15 downto 0);  -- memory address
    signal mem_data_in : std_logic_vector(15 downto 0);  -- memory data in
    signal mem_data_out : std_logic_vector(15 downto 0);  -- memory data out

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
        rst => RST,
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
        mem_addr => mem_addr_out,
        mem_data => mem_data_out,
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
        addr => mem_addr_in,
        sym1 => mem_data_in,
        sym2 => sym2
    );


    ---------------- memories ----------------

    -- memory wrapper
    mem : memory port map(
        clk => CLK,
        mem_t => mem_t,
        mem_rd => mem_rd,
        mem_wr => mem_wr,
        addr_in => mem_addr_in,
        addr_out => mem_addr_out,
        data_in => mem_data_in,
        data_out => mem_data_out
    );


    ---------------- Galois operators ----------------

    operators_unit: operators port map(
        clk => CLK,
        opcode => OPCODE,
        i => i,
        j => j,
        n => n,
        mask => mask,
        result => RESULT
    );


    ---------------- TEMPORARY OUTPUTS ----------------
    --t_m <= m;
    --t_n <= n;
    --t_mask <= mask;
    --t_addr <= mem_addr;
    --t_sym <= mem_data_in;

end behavioral;
