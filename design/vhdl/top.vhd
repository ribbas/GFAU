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
    use work.glob.all;

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

        -- control unit enable
        ENCU    : in std_logic;

        -- user inputs
        POLYBCD : in std_logic_vector(n downto 0);
        opcode  : in std_logic_vector(5 downto 0);
        OPAND1  : in std_logic_vector(n downto 0);
        OPAND2  : in std_logic_vector(n downto 0);

        -- user output
        result  : out std_logic_vector(n downto 0);

        -- IO interrupts
        rdy_gen  : out std_logic;
        rdy_out : out std_logic;
        errb    : out std_logic;
        errz    : out std_logic;

        -- memory control signals
        nCE     : out std_logic;
        nWE     : out std_logic;
        nOE     : out std_logic := '0';
        nBLE    : out std_logic := '0';
        nBHE    : out std_logic := '0';

        -- memory address and data signals
        A       : out std_logic_vector((n + 1) downto 0);
        IO      : inout std_logic_vector(n downto 0)

        ;
        -------------- TEMPORARY - JUST FOR TB ------------

        ---- universal registers
        t_size      : out std_logic_vector(clgn downto 0);
        t_msb       : out std_logic_vector(clgn1 downto 0);
        t_mask      : out std_logic_vector(n downto 0);

        t_1         : out std_logic;
        t_n1      : out std_logic_vector(n downto 0);
        t_n2      : out std_logic_vector(n downto 0)

    );
end top;

architecture behavioral of top is

    component IO_Handler_Top is
        port(
        --====================================================================
            --***External Signals***--
        --====================================================================

            --signals from/to external devices
            data        :   inout   std_logic_vector(31 downto 0); --external data bus
            Start       :   in      std_logic;
            t_clk       :   in      std_logic; --external device clock < 200MHz
            g_rst       :   in      std_logic; --global reset. 1 cycle of both clks
            ready_sig   :   out     std_logic; --gfau is ready for input
            err         :   out     std_logic; --error signal

            --interrupt signals to/from external device
            INT         :   out     std_logic; --generate an interrupt
            INTA        :   in      std_logic; --interrupt acknowledge

            --signals to/from gfau
            clk         :   in      std_logic; --internal 50MHz clock
            op_done     :   in      std_logic; --normal operation completed
            opcode_out  :   out     std_logic_vector(5 downto 0); --for internal use
            rst         :   out     std_logic; --propogation of g_rst
            gen_rdy     :   in      std_logic; --field generation complete
            gfau_data   :   in      std_logic_vector(15 downto 0); --gfau result
            out_data    :   out     std_logic_vector(31 downto 0);
            input_size  :   in      std_logic_vector(3 downto 0);
            --error signals
            z_err       :   in      std_logic;
            oob_err     :   in      std_logic
        );
    end component;


    ---------------- universal registers and constants ----------------

    -- order and most significant bit index
    component indices
        port(
            poly_bcd    : in  std_logic_vector(n downto 2);
            size        : out std_logic_vector(clgn downto 0);
            msb         : out std_logic_vector(clgn1 downto 0)
        );
    end component;

    -- mask
    component varmask
        port(
            poly_bcd    : in  std_logic_vector(n downto 2);
            mask        : out std_logic_vector(n downto 0)
        );
    end component;

    component control_unit
        port(
            clk         : in std_logic;
            opcode      : in std_logic_vector(5 downto 1);   -- op code
            opand1      : in std_logic_vector(n downto 0);   -- operand 1
            opand2      : in std_logic_vector(n downto 0);   -- operand 2

            start       : in std_logic;  -- control unit enable
            rst         : in std_logic;

            -- registers
            mask        : in  std_logic_vector(n downto 0);

            -- generation signals
            en_gen      : out std_logic;  -- polynomial generator enable
            rst_gen     : out std_logic;  -- polynomial generator reset

            -- operation signals
            en_ops      : out std_logic;  -- operators enable
            rst_ops     : out std_logic;
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

    ---------------- element generator ----------------

    -- generator controller
    component generator
        port(
            clk         : in std_logic;
            en          : in std_logic;
            rst         : in std_logic;

            -- polynomial data
            poly_bcd    : in std_logic_vector(n downto 0);
            mask        : in std_logic_vector(n downto 0);
            msb         : in std_logic_vector(clgn1 downto 0);
			poly_bcd_reg : out std_logic_vector(n downto 1);
            -- memory wrapper control signals
            id_gen      : out std_logic;
            mem_rdy     : in std_logic;
            mem_t       : out std_logic;

            -- memory signals
            gen_rdy     : out std_logic;
            addr_gen    : out std_logic_vector(n downto 0);
            elem        : out std_logic_vector(n downto 0)
        );
    end component;

    ---------------- Galois operators ----------------

    component operators
        port(
            -- clock
            clk         : in std_logic;

            -- control signals
            en          : in std_logic;
            rst         : in std_logic;

            -- opcode
            op          : in std_logic_vector(2 downto 0);
            out_t       : in std_logic;

            -- operands
            i           : in std_logic_vector(n downto 0);
            j           : in std_logic_vector(n downto 0);

            -- operand null flags
            i_null      : in std_logic;
            j_null      : in std_logic;

            -- registers
            size        : in std_logic_vector(clgn downto 0);  -- size
            mask        : in std_logic_vector(n downto 0);  -- mask

            -- memory types and methods
            mem_t       : out std_logic; -- memory type

            -- memory wrapper control signals
            id_con      : out std_logic;
            mem_rdy     : in std_logic;

            -- memory address and data signals
            addr_con    : out std_logic_vector(n downto 0);
            dout_con    : inout std_logic_vector(n downto 0);

            result      : out std_logic_vector(n downto 0); -- selected output
            err_z       : out std_logic; -- zero exception
            rdy_out     : out std_logic -- result ready interrupt
        );
    end component;

    ---------------- memory ----------------

    -- CY7C1020DV33 chips wrapper
    component memory is
        port(
            -- clock
            clk         : in std_logic;

            -- memory types and methods
            mem_t_cu    : in std_logic;
            mem_t_con   : in std_logic;
            mem_t_gen   : in std_logic;
            mem_rdy     : out std_logic;  -- ready

            -- module signals
            id_cu       : in std_logic;
            addr_cu     : in std_logic_vector(n downto 0);
            dout_cu     : out std_logic_vector(n downto 0);
            id_con      : in std_logic;
            addr_con    : in std_logic_vector(n downto 0);
            dout_con    : out std_logic_vector(n downto 0);
            id_gen      : in std_logic;
            addr_gen    : in std_logic_vector(n downto 0);
            din_gen     : in std_logic_vector(n downto 0);

            -- memory control signals
            nCE         : out std_logic;
            nWE         : out std_logic;
            nOE         : out std_logic;

            -- memory address and data signals
            A           : out std_logic_vector((n + 1) downto 0);
            DQ          : inout std_logic_vector(n downto 0)
        );
    end component;

    -- global registers
    signal mask : std_logic_vector(n downto 0);  -- mask
    signal size : std_logic_vector(clgn downto 0);  -- size
    signal msb : std_logic_vector(clgn1 downto 0);  -- msb
    signal poly_bcd_reg : std_logic_vector(n downto 1);

    -- generator control signals
    signal id_gen : std_logic;
    signal en_gen : std_logic;  -- enable
    signal rst_gen : std_logic;  -- reset

    -- internal operation signals
    signal en_ops : std_logic;
    signal rst_ops: std_logic;
    signal id_cu : std_logic;
    signal id_con : std_logic;
    signal i : std_logic_vector(n downto 0);
    signal j : std_logic_vector(n downto 0);
    signal i_null : std_logic;
    signal j_null : std_logic;

    -- memory control signals
    signal mem_t_cu : std_logic;  -- memory type of control unit
    signal mem_t_con : std_logic;  -- memory type of operators
    signal mem_t_gen : std_logic;  -- memory type of generator
    signal mem_rdy : std_logic;  -- memory type

    -- memory address and data signals
    signal addr_gen : std_logic_vector(n downto 0);
    signal elem : std_logic_vector(n downto 0);
    signal addr_cu : std_logic_vector(n downto 0);
    signal dout_cu : std_logic_vector(n downto 0);
    signal addr_con : std_logic_vector(n downto 0);
    signal dout_con : std_logic_vector(n downto 0);

begin

    --io_unit: IO_Handler_Top port map (
    --    data => DATA,
    --    Start => START,
    --    t_clk => T_CLK,
    --    g_rst => RST,
    --    ready_sig => RDY,
    --    err => ERR,
    --    INT => INT,
    --    INTA => INTA,
    --    clk => CLK,

    --    op_done => rdy_out,
    --    opcode_out => opcode,
    --    rst => open,
    --    gen_rdy => rdy_gen,
    --    gfau_data => result,
    --    out_data => out_data,
    --    input_size => input_data,
    --    z_err => errz,
    --    oob_err => errb
    --);

    ---------------- universal registers and constants ----------------

    -- most significant bit
    indices_unit: indices port map(
        poly_bcd => poly_bcd_reg(n downto 2),
        size => size,
        msb => msb
    );

    -- mask
    varmask_unit: varmask port map(
        poly_bcd => poly_bcd_reg(n downto 2),
        mask => mask
    );

    -- control unit
    cu: control_unit port map(
        clk => CLK,
        opcode => opcode(5 downto 1),
        opand1 => OPAND1,
        opand2 => OPAND2,
        start => ENCU,
        rst => RST,
        mask => mask,
        en_ops => en_ops,
        en_gen => en_gen,
        rst_gen => rst_gen,
        rst_ops => rst_ops,
        i => i,
        j => j,
        mem_t => mem_t_cu,
        id_cu => id_cu,
        mem_rdy => mem_rdy,
        addr_cu => addr_cu,
        dout_cu => dout_cu,
        err_b => errb,
        opand1_null => i_null,
        opand2_null => j_null
    );

    ---------------- element generator ----------------

    -- generator controller
    generator_unit: generator port map(
        clk => CLK,
        rst => rst_gen,
        en => en_gen,
        poly_bcd => POLYBCD,
        poly_bcd_reg => poly_bcd_reg,
        mask => mask,
        msb => msb,
        id_gen => id_gen,
        mem_rdy => mem_rdy,
        mem_t => mem_t_gen,
        gen_rdy => rdy_gen,
        addr_gen => addr_gen,
        elem => elem
    );


    ---------------- Galois operators ----------------

    -- operators
    operators_unit: operators port map(
        clk => CLK,
        op => opcode(5 downto 3),
        out_t => opcode(0),
        en => en_ops,
        rst => rst_ops,
        i => i,
        j => j,
        i_null => i_null,
        j_null => j_null,
        size => size,
        mask => mask,
        mem_t => mem_t_con,
        id_con => id_con,
        mem_rdy => mem_rdy,
        addr_con => addr_con,
        dout_con => dout_con,
        result => result,
        err_z => errz,
        rdy_out => rdy_out
    );


    ---------------- memory ----------------

    -- memory wrapper
    mem : memory port map(
        clk => CLK,
        mem_t_cu => mem_t_cu,
        mem_t_con => mem_t_con,
        mem_t_gen => mem_t_gen,
        mem_rdy => mem_rdy,
        id_cu => id_cu,
        addr_cu => addr_cu,
        dout_cu => dout_cu,
        id_con => id_con,
        addr_con => addr_con,
        dout_con => dout_con,
        id_gen => id_gen,
        addr_gen => addr_gen,
        din_gen => elem,
        nCE => nCE,
        nWE => nWE,
        nOE => nOE,
        A => A,
        DQ => IO
    );


    -------------------- TEMPORARY OUTPUTS ----------------
    --t_size <= size;
    --t_msb <= msb;
    --t_mask <= '0' & poly_bcd_reg;
    --t_1 <= rst_ops;
    --t_n1 <= i;
    --t_n2 <= j;

    ----process (clk) begin
    ----for i in 5 downto 0 loop
    ----    report "TOP("&integer'image(i)&")=" & std_logic'image(opcode(i));
    ----end loop;
    ----end process;


end behavioral;
