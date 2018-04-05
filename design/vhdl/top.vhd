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
library work;
    use work.demo.all;

entity top is
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

        -- user inputs
        POLYBCD : in std_logic_vector(n - 1 downto 0);
        OPCODE  : in std_logic_vector(5 downto 0);
        OPAND1  : in std_logic_vector(n downto 0);
        OPAND2  : in std_logic_vector(n downto 0);

        -- user output
        RESULT  : out std_logic_vector(n downto 0);

        -- IO interrupts
        RDYGEN  : out std_logic;
        ERRB    : out std_logic;
        ERRZ    : out std_logic;

        -- memory control signals
        _CE     : out std_logic;
        _WE     : out std_logic;
        _OE     : out std_logic := '0';
        _BLE    : out std_logic := '0';
        _BHE    : out std_logic := '0';

        -- memory address and data signals
        A       : out std_logic_vector((n + 1) downto 0);
        _IO     : inout std_logic_vector(n downto 0)

        -------------- TEMPORARY - JUST FOR TB ------------

        ---- universal registers
        --t_n         : out std_logic_vector(3 downto 0);
        --t_m         : out std_logic_vector(3 downto 0);
        --t_mask      : out std_logic_vector(n downto 0);

        ---- generated terms
        --t_addr      : out std_logic_vector(n downto 0);
        --t_sym       : out std_logic_vector(n downto 0)
    );
end top;

architecture behavioral of top is

    ---------------- universal registers and constants ----------------

    -- size and most significant bit index
    component indices
        port(
            poly_bcd    : in  std_logic_vector(n -1 downto 0);
            size        : out std_logic_vector(clgn downto 0);
            msb         : out std_logic_vector(clgn1 downto 0)
        );
    end component;

    -- mask
    component varmask
        port(
            poly_bcd    : in  std_logic_vector(n -1 downto 0);
            mask        : out std_logic_vector(n downto 0)
        );
    end component;

    component control_unit
        port(
            clk         : in std_logic;
            opcode      : in std_logic_vector(5 downto 0);   -- op code
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

            -- memory signals
            mem_data    : in std_logic_vector(n downto 0);  -- data
            mem_addr    : out std_logic_vector(n downto 0);  -- address
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
            poly_bcd    : in std_logic_vector(n -1 downto 0);
            mask        : in std_logic_vector(n downto 0);
            msb           : in std_logic_vector(3 downto 0);
            n           : in std_logic_vector(3 downto 0);

            -- memory signals
            write_en    : out std_logic;
            rdy         : out std_logic;
            addr        : out std_logic_vector(n downto 0);
            sym1        : out std_logic_vector(n downto 0);
            sym2        : out std_logic_vector(n downto 0)
        );
    end component;

    ---------------- Galois operators ----------------

    component operators
        port(
            clk         : in std_logic;
            opcode      : in std_logic_vector(5 downto 0);
            i           : in std_logic_vector(n downto 0);
            j           : in std_logic_vector(n downto 0);
            i_null      : in std_logic;
            j_null      : in std_logic;
            size        : in std_logic_vector(clgn downto 0);  -- size
            mask        : in std_logic_vector(n downto 0);  -- mask
            mem_t       : out std_logic; -- memory type
            id_con      : out std_logic;
            mem_rdy     : in std_logic;
            addr_con    : out std_logic_vector(n downto 0);
            dout_con    : inout std_logic_vector(n downto 0);
            result      : out std_logic_vector(n downto 0); -- selected output
            err_z       : out std_logic -- zero exception
        );
    end component;

    ---------------- memory ----------------

    -- CY7C1020DV33 chips wrapper
    component memory is
        port(
            clk         : in std_logic;
            mem_t       : in std_logic;
            mem_rdy     : out std_logic;
            id_cu       : in std_logic;
            addr_cu     : in std_logic_vector(n downto 0);
            dout_cu     : out std_logic_vector(n downto 0);
            id_con      : in std_logic;
            addr_con    : in std_logic_vector(n downto 0);
            dout_con    : out std_logic_vector(n downto 0);
            id_gen      : in std_logic;
            addr_gen    : in std_logic_vector(n downto 0);
            din_gen     : in std_logic_vector(n downto 0);
            nCE         : out std_logic;
            nWE         : out std_logic;
            A           : out std_logic_vector((n + 1) downto 0);
            DQ          : inout std_logic_vector(n downto 0)
        );
    end component;

    -- constants
    signal mask : std_logic_vector(n downto 0);  -- mask
    signal msb : std_logic_vector(3 downto 0);  -- msb
    signal n : std_logic_vector(3 downto 0);  -- size

    -- generator data signals
    --signal addr : std_logic_vector(n downto 0);
    --signal sym1 : std_logic_vector(n downto 0);
    signal sym2 : std_logic_vector(n downto 0);

    -- generator control signals
    signal en_gen : std_logic := '1';  -- enable
    signal rst_gen : std_logic;  -- reset

    -- internal operation signals
    signal i : std_logic_vector(n downto 0);
    signal j : std_logic_vector(n downto 0);

    -- memory control signals
    signal mem_t : std_logic;  -- memory type
    signal mem_addr_in : std_logic_vector(n downto 0);  -- memory address
    signal mem_addr_out : std_logic_vector(n downto 0);  -- memory address
    signal mem_data_in : std_logic_vector(n downto 0);  -- memory data in
    signal mem_data_out : std_logic_vector(n downto 0);  -- memory data out

begin

    ---------------- universal registers and constants ----------------

    -- most significant bit
    indices_unit: indices port map(
        poly_bcd => POLYBCD,
        size => size,
        msb => msb
    );

    -- mask
    varmask_unit: varmask port map(
        poly_bcd => POLYBCD,
        mask => mask
    );

    cu: control_unit port map(
        clk => CLK,
        opcode => OPCODE,
        opand1 => OPAND1,
        opand2 => OPAND2,
        mask => mask,
        en_gen => en_gen,
        rst_gen => rst_gen,
        i => i,
        j => j,
        mem_t => mem_t,
        id_cu => id_cu,
        addr_cu => addr_cu,
        dout_cu => dout_cu,
        err_b => ERRB,
        opand1_null => opand1_null,
        opand2_null => opand2_null
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
        msb => msb,
        n => n,
        write_en => mem_wr,
        addr => mem_addr_in,
        sym1 => mem_data_in,
        sym2 => sym2
    );


    ---------------- memory ----------------

    -- memory wrapper
    mem : memory port map(
        clk => CLK,
        mem_t => mem_t,
        mem_rdy => mem_rdy,
        id_cu => id_cu,
        addr_cu => addr_cu,
        dout_cu => dout_cu,
        id_gen => id_gen,
        addr_gen => addr_gen,
        din_gen => din_gen,
        id_con => id_con,
        addr_con => addr_con,
        dout_con => dout_con,
        nCE => _CE,
        nWE => _WE,
        A => A,
        DQ => _IO
    );


    ---------------- Galois operators ----------------

    operators_unit: operators port map(
        clk => CLK,
        opcode => OPCODE,
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
        result => RESULT,
        err_z => ERRZ
    );


    ---------------- TEMPORARY OUTPUTS ----------------
    --t_m <= msb;
    --t_n <= n;
    --t_mask <= mask;
    --t_addr <= mem_addr;
    --t_sym <= mem_data_in;

end behavioral;
