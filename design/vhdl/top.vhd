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
library UNISIM;
    use UNISIM.VComponents.all;
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
        GRST    : in std_logic;

        DATA    : inout std_logic_vector(31 downto 0); --external data bus
        START   : in std_logic;
        TCLK    : in std_logic; --external device clock < 200MHz
        RDY     : out std_logic; --gfau is ready for input
        ERR     : out std_logic; --error signal

        --interrupt signals to/from external device
        INT     : out std_logic; --generate an interrupt
        INTA    : in std_logic; --interrupt acknowledge

        -- memory control signals
        nCE     : out std_logic;
        nWE     : out std_logic;
        nOE     : out std_logic;
        nBLE    : out std_logic;
        nBHE    : out std_logic;

        state_out   :   out std_logic_vector(7 downto 0);
        result_out  :   out std_logic_vector(7 downto 0);
                
        op_done_o   :   out std_logic;
        wr_rd_o     :   out std_logic;

        -- memory address and data signals
        A       : out std_logic_vector(14 downto 0);
        IO      : inout std_logic_vector(n downto 0)
    );
end top;

architecture behavioral of top is

    -- IO controller

    component IO_Handler_Top is
        port(

            --signals from/to external devices
            data        :   inout   std_logic_vector(31 downto 0); --external data bus
            Start       :   in      std_logic;
            t_clk_in    :   in      std_logic; --external device clock < 200MHz
            g_rst       :   in      std_logic; --global reset. 1 cycle of both clks
            ready_sig   :   out     std_logic; --gfau is ready for input
            err         :   out     std_logic; --error signal

            --interrupt signals to/from external device
            INT         :   out     std_logic; --generate an interrupt
            INTA        :   in      std_logic; --interrupt acknowledge

            mode_out    :   out     std_logic_vector(1 downto 0);

            --signals to/from gfau
            clk         :   in      std_logic; --internal 50MHz clock
            op_done     :   in      std_logic; --normal operation completed
            opcode_out  :   out     std_logic_vector(5 downto 0); --for internal use
            rst         :   out     std_logic; --propogation of g_rst
            gen_rdy     :   in      std_logic; --field generation complete
            gfau_data   :   in      std_logic_vector(15 downto 0); --gfau result
            out_data    :   out     std_logic_vector(31 downto 0);
            cu_start    :   out     std_logic;

            op_done_o   :   out     std_logic;
            
            oob_err     :   in      std_logic;
            z_err       :   in      std_logic;
            
            --error/debug signals
            state_out   :   out     std_logic_vector(7 downto 0);
            in_data_exto:   out     std_logic_vector(31 downto 0);
            out_dataexto:   out     std_logic_vector(15 downto 0);
            wr_rd_o     :   out     std_logic;
            count_out   :   out     std_logic_vector(1 downto 0);
            num_clks_o  :   out     std_logic_vector(1 downto 0);
            dbg_sel   :   out     std_logic_vector(2 downto 0)
        );
    end component;

    ---------------- universal registers and constants ----------------

    -- order and most significant bit index
    component indices
        port(
            poly_bcd    : in std_logic_vector(n downto 1);  -- BCD polynomial
            size        : out std_logic_vector(clgn downto 0);  -- size
            msb         : out std_logic_vector(clgn1 downto 0)  -- msb
        );
    end component;

    -- mask
    component varmask
        port(
            poly_bcd    : in std_logic_vector(n downto 1);  -- BCD polynomial
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
            rst         : in std_logic; -- global reset

            -- generation signals
            en_gen      : out std_logic;  -- polynomial generator enable
            rst_gen     : out std_logic;  -- polynomial generator reset
            gen_rdy     : in std_logic;  -- generation done

            -- operation signals
            ops_rdy     : out std_logic;  -- operators enable
            rst_ops     : out std_logic;
            i           : out std_logic_vector(n downto 0) := DCAREVEC;  -- i
            j           : out std_logic_vector(n downto 0) := DCAREVEC;  -- j

            -- memory wrapper control signals
            id_cu       : out std_logic := '0';
            nOE         : out std_logic := '1';
            nCE         : out std_logic := '1';

            -- memory address and data signals
            addr_cu     : out std_logic_vector((n + 1) downto 0);  -- address in memory
            dout_cu     : in std_logic_vector(n downto 0)  -- data from memory
        );
    end component;

    ---------------- element generator ----------------

    -- generator controller
    component generator
        port(
            clk         : in std_logic;
            start       : in std_logic;
            rst         : in std_logic;
            id_gen      : out std_logic;
            gen_rdy     : out std_logic := '0';

            -- polynomial data
            poly_bcd    : in std_logic_vector(n downto 0);
            mask        : in std_logic_vector(n downto 0);
            msb         : in std_logic_vector(clgn1 downto 0);
            poly_bcd_reg : out std_logic_vector(n downto 1);


            -- memory signals
            addr_gen    : out std_logic_vector((n + 1) downto 0);
            data_gen    : out std_logic_vector(n downto 0);
            nWE         : out std_logic;
            nCE         : out std_logic
        );
    end component;

    ---------------- Galois operators ----------------

    component operators
        port(
            -- clock
            clk         : in std_logic;

            -- control signals
            ops_rdy     : in std_logic;
            rst         : in std_logic;

            -- opcode
            opcode      : in std_logic_vector(5 downto 0);

            -- operands
            i           : in std_logic_vector(n downto 0);
            j           : in std_logic_vector(n downto 0);

            -- registers
            size        : in std_logic_vector(clgn downto 0);  -- size
            mask        : in std_logic_vector(n downto 0);  -- mask

            -- memory types and methods
            mem_t       : out std_logic; -- memory type

            -- memory wrapper control signals
            id_con      : out std_logic;
            nOE         : out std_logic;
            nCE         : out std_logic;

            -- memory address and data signals
            addr_con    : out std_logic_vector((n + 1) downto 0);
            dout_con    : in  std_logic_vector(n downto 0);

            result      : out std_logic_vector(n downto 0); -- selected output
            err_z       : out std_logic; -- zero exception
            rdy_out     : out std_logic; -- result ready interrupt
            out_sel_o   : out std_logic_vector(n downto 0)
        );
    end component;
    
    component io_port
    port(
        op      :   in      std_logic_vector(n downto 0);  --out to pad
        oe      :   in      std_logic;                     --enable pad output
        ip      :   out     std_logic_vector(n downto 0);  --in from pad
        pad     :   inout   std_logic_vector(n downto 0) --external io pad
    );
    end component;

    ---------------- memory ----------------

    -- CY7C1020DV33 chips wrapper
    --component memory is
    --    port(
    --        -- clock
    --        clk         : in std_logic;

            -- memory types and methods
            --mem_t_con   : in std_logic;
            --mem_t_gen   : in std_logic;
            --mem_rdy     : out std_logic;  -- ready

            -- module signals
            --id_cu       : in std_logic;
            --addr_cu     : in std_logic_vector((n + 1) downto 0);
            --dout_cu     : out std_logic_vector(n downto 0);
            --id_con      : in std_logic;
            --addr_con    : in std_logic_vector(n downto 0);
            --dout_con    : out std_logic_vector(n downto 0);
            --id_gen      : in std_logic;
            --addr_gen    : in std_logic_vector((n + 1) downto 0);
            --din_gen     : in std_logic_vector(n downto 0);

            -- memory control signals
            --nCE         : out std_logic;
            --nWE         : out std_logic;
            --nOE         : out std_logic;
            --nBLE        : out std_logic;
            --nBHE        : out std_logic;

            -- memory address and data signals
            --A           : out std_logic_vector((n + 1) downto 0);
            --DQ          : inout std_logic_vector(n downto 0)
        --);
    --end component;
    
    --mux to select which signals to output for debugging
    component debug_mux
    port(
        in1     :   in  std_logic_vector(7 downto 0);
        in2     :   in  std_logic_vector(7 downto 0);
        in3     :   in  std_logic_vector(7 downto 0);
        in4     :   in  std_logic_vector(7 downto 0);
        in5     :   in  std_logic_vector(7 downto 0);
        in6     :   in  std_logic_vector(7 downto 0);
        in7     :   in  std_logic_vector(7 downto 0);
        in8     :   in  std_logic_vector(7 downto 0);
        sel     :   in  std_logic_vector(2 downto 0);
        op      :   out std_logic_vector(7 downto 0)
    );
    end component;

    component addr_mux
    port(
        addr_cu     :   in  std_logic_vector(n + 1 downto 0);
        addr_con    :   in  std_logic_vector(n + 1 downto 0);
        addr_gen    :   in  std_logic_vector(n + 1 downto 0);
        id_cu       :   in  std_logic;
        id_con      :   in  std_logic;
        id_gen      :   in  std_logic;
        A           :   out std_logic_vector(n + 1 downto 0)
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
    signal ops_rdy : std_logic;
    signal rst_ops: std_logic;

    -- control unit enable
    signal init_cu : std_logic;
    signal id_cu : std_logic;
    signal id_con : std_logic;
    signal i : std_logic_vector(n downto 0);
    signal j : std_logic_vector(n downto 0);
    signal i_null : std_logic;
    signal j_null : std_logic;

    -- memory control signals
    signal nCE_gen  :   std_logic;
    signal nCE_cu   :   std_logic;
    signal nCE_con  :   std_logic;
    signal nOE_cu   :   std_logic;
    signal nOE_con  :   std_logic;
    signal mem_t_cu : std_logic;  -- memory type of control unit
    signal mem_t_con : std_logic;  -- memory type of operators
    signal mem_t_gen : std_logic;  -- memory type of generator
    --signal mem_rdy : std_logic;  -- memory type

    -- memory address and data signals
    signal addr_gen : std_logic_vector((n + 1) downto 0);
    signal elem : std_logic_vector(n downto 0);
    signal addr_cu : std_logic_vector((n + 1) downto 0);
    signal dout_cu : std_logic_vector(n downto 0);
    signal addr_con : std_logic_vector((n + 1) downto 0);
    signal dout_con : std_logic_vector(n downto 0);
    signal memDout  : std_logic_vector(n downto 0);
    signal memDin   : std_logic_vector(n downto 0);

    -- user inputs
    signal poly_bcd : std_logic_vector(n downto 1);
    signal opcode  : std_logic_vector(5 downto 0);
    signal opand1  : std_logic_vector(n downto 0);
    signal opand2  : std_logic_vector(n downto 0);
    signal out_data : std_logic_vector(31 downto 0);
    signal rst : std_logic;

    -- user output
    signal result  : std_logic_vector(n downto 0);

    -- IO interrupts
    signal rdy_gen  : std_logic;
    signal rdy_out : std_logic;
    signal errb    : std_logic;
    signal errz    : std_logic;
    
    --debug mux select
    signal debug_sel    :   std_logic_vector(2 downto 0);
    signal out_data_ext_o   :   std_logic_vector(15 downto 0);
    signal in_data_ext_o    :   std_logic_vector(31 downto 0);
    signal state_out_s  :   std_logic_vector(7 downto 0);
    signal count_out    :   std_logic_vector(1 downto 0);
    signal num_clks_o   :   std_logic_vector(1 downto 0);
    
    signal IO_s         :   std_logic_vector(n downto 0);
    signal A_s          :   std_logic_vector((n + 1) downto 0);
    signal nWE_s        :   std_logic;
    
begin
    
    nBHE <= '0';
    nBLE <= '0';
    nOE <= nOE_cu and nOE_con;
    nCE <= nCE_cu and nCE_con and nCE_gen;

    A <= A_s;
    IO <= IO_s;
    nWE <= nWE_s;
    state_out <= state_out_s;

    io_unit: IO_Handler_Top port map(
        data => DATA,
        Start => START,
        t_clk_in => TCLK,
        g_rst => GRST,
        ready_sig => RDY,
        err => ERR,
        INT => INT,
        INTA => INTA,
        clk => CLK,

        op_done => rdy_out,
        opcode_out => opcode,
        rst => rst,
        gen_rdy => rdy_gen,
        gfau_data(15 downto (n + 1)) => (others => '0'),
        gfau_data(n downto 0) => result,
        out_data => out_data,
        cu_start => init_cu,
        z_err => errz,
        state_out => state_out_s,
        op_done_o => op_done_o,
        in_data_exto => in_data_ext_o,
        out_dataexto => out_data_ext_o,
        wr_rd_o => wr_rd_o,
        dbg_sel => debug_sel,
        count_out => count_out,
        num_clks_o => num_clks_o,
        oob_err => errb
    );

    ---------------- universal registers and constants ----------------

    -- most significant bit
    indices_unit: indices port map(
        poly_bcd => poly_bcd_reg,
        size => size,
        msb => msb
    );

    -- mask
    varmask_unit: varmask port map(
        poly_bcd => poly_bcd_reg,
        mask => mask
    );

    -- control unit
    cu: control_unit port map(
        clk => CLK,
        opcode => opcode(5 downto 1),
        opand1 => out_data(n downto 0),
        opand2 => out_data((16 + n) downto 16),
        start => init_cu,
        rst => rst,
        ops_rdy => ops_rdy,
        gen_rdy => rdy_gen,
        en_gen => en_gen,
        rst_gen => rst_gen,
        i => i,
        j => j,
        id_cu => id_cu,
        --mem_rdy => mem_rdy,
        addr_cu => addr_cu,
        nCE     => nCE_cu,
        nOE     => nOE_cu,
        dout_cu => memDin
    );

    ---------------- element generator ----------------

    -- generator controller
    generator_unit: generator port map(
        clk => CLK,
        rst => rst_gen,
        start => en_gen,
        poly_bcd => out_data(n downto 0),
        poly_bcd_reg => poly_bcd_reg,
        mask => mask,
        msb => msb,
        gen_rdy => rdy_gen,
        addr_gen => addr_gen,
        id_gen => id_gen,
        nWE => nWE_s,
        nCE => nCE_gen,
        data_gen => memDout
    );


    ---------------- Galois operators ----------------

    -- operators
    operators_unit: operators port map(
        clk => CLK,
        opcode => opcode,
        ops_rdy => ops_rdy,
        rst => rst_ops,
        i => i,
        j => j,
        size => size,
        mask => mask,
        mem_t => mem_t_con,
        id_con => id_con,
        nCE => nCE_con,
        nOE => nOE_con,
        addr_con => addr_con,
        dout_con => memDin,
        result => result,
        err_z => errz,
        out_sel_o => open,--result_out,--result_out,
        rdy_out => rdy_out
    );


    ---------------- memory ----------------

    -- memory wrapper
    --mem : memory port map(
    --    clk => CLK,
    --    mem_t_con => mem_t_con,
    --    mem_rdy => mem_rdy,
    --    id_cu => id_cu,
    --   addr_cu => addr_cu,
    --  dout_cu => dout_cu,
    --    id_con => id_con,
    --    addr_con => addr_con,
    --   dout_con => dout_con,
    --  id_gen => id_gen,
    --  addr_gen => addr_gen,
    --  din_gen => elem,
    --    nCE => nCE,
    --    nWE => nWE_s,
    --    nOE => nOE,
    --    nBLE => nBLE,
    --    nBHE => nBHE,
    --    A => A_s((n + 1) downto 0),
    --    DQ => IO_s
    --);
    
    mem_io : io_port port map(
        op  =>  memDout,
        oe  =>  not nCE_gen,
        ip  =>  memDin,
        pad =>  IO_s
    );
        
    
    dbg : debug_mux port map(
        in1 => data(7 downto 0),
        in2 => result(7 downto 0),
        in3 => out_data_ext_o(7 downto 0),
        in4 => in_data_ext_o(7 downto 0),
        in5 => i(7 downto 0),
        in6 => j(7 downto 0),
        in7 => state_out_s,
        --in8(3 downto 0) => count_out & num_clks_o,
        --in8(6 downto 4) => IO_s(0) & A_s(0) & nWE_s,
        --in8(7) => '0',
        in8 => (others => '0'),
        sel => debug_sel,
        op  => result_out
    );
    
    amux : addr_mux port map(
        addr_cu => addr_cu,
        addr_con => addr_con,
        addr_gen => addr_gen,
        id_cu => id_cu,
        id_con => id_con,
        id_gen => id_gen,
        A => A_s
    );

end behavioral;