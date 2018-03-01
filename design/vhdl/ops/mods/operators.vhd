-- operators.vhd
--
-- Sabbir Ahmed
-- 2018-01-16
--
-- Controller for the Galois operators.
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity operators is
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
        --convert : out std_logic; -- convert flag
        mem_t   : out std_logic; -- memory type
        err_z   : out std_logic -- zero exception
    );
end operators;

architecture structural of operators is

    -- two's complement
    component maskedtwoscmp
        port(
            num         : in std_logic_vector(15 downto 0);
            mask        : in std_logic_vector(15 downto 0);
            maskedtc    : out std_logic_vector(15 downto 0)
        );
    end component;

    ---------------- Galois operators ----------------

    -- addition / subtraction
    component addsub16
        port(
            i       : in std_logic_vector (15 downto 0);
            j       : in std_logic_vector (15 downto 0);
            i_null  : in std_logic;
            j_null  : in std_logic;
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
            quot    : out std_logic_vector (15 downto 0)
        );
    end component;

    ------------------ memory ----------------

    ---- IS61LP6432A chips wrapper
    --component memory is
    --    port(
    --        clk         : in std_logic;
    --        mem_t       : in std_logic;
    --        mem_rd      : in std_logic;
    --        mem_wr      : in std_logic;
    --        addr_in     : in std_logic_vector(15 downto 0);
    --        addr_out    : in std_logic_vector(15 downto 0);
    --        data_in     : in std_logic_vector(15 downto 0);
    --        data_out    : out std_logic_vector(15 downto 0)
    --    );
    --end component;

    ---------------- output multiplexers ----------------

    component outselect
        port(
            opcode  : in std_logic_vector(5 downto 0);
            out_as  : in std_logic_vector(15 downto 0);
            out_m   : in std_logic_vector(15 downto 0);
            out_d   : in std_logic_vector(15 downto 0);
            out_l   : in std_logic_vector(15 downto 0);
            i_null  : in std_logic;
            j_null  : in std_logic;
            out_sel : out std_logic_vector(15 downto 0);
            mem_t   : out std_logic;
            convert : out std_logic;
            err_z   : out std_logic
        );
    end component;

    ---- output select
    --component outconvert
    --    port(
    --        convert : in std_logic;
    --        mask    : in std_logic_vector(15 downto 0);
    --        out_sel : in std_logic_vector(15 downto 0);
    --        mem_out : in std_logic_vector(15 downto 0);
    --        result  : out std_logic_vector(15 downto 0)
    --    );
    --end component;

    signal neg_j : std_logic_vector(15 downto 0);

    signal bitxor : std_logic_vector(15 downto 0);
    signal prod : std_logic_vector(15 downto 0);
    signal quot : std_logic_vector(15 downto 0);

    --signal out_sel : std_logic_vector(15 downto 0);
    --signal mem_out : std_logic_vector(15 downto 0);
    --signal mem_t : std_logic;
    --signal convert : std_logic;

begin

    maskedtwoscmp_unit: maskedtwoscmp port map(
        num => j,
        mask => mask,
        maskedtc => neg_j
    );

    ---------------- Galois operator units ----------------

    -- addition / subtraction
    addsub_unit: addsub16 port map(
        i => i,
        j => j,
        i_null => i_null,
        j_null => j_null,
        bitxor => bitxor
    );

    -- multiplication
    mul_unit: mul16 port map(
        i => i,
        j => j,
        n => n,
        prod => prod
    );

    -- division
    div_unit: div16 port map(
        i => i,
        j => neg_j,
        n => n,
        quot => quot
    );

    ---- output selector
    --outselect_unit: outselect port map(
    --    opcode => opcode,
    --    out_as => bitxor,
    --    out_m => prod,
    --    out_d => quot,
    --    out_l => i,
    --    i_null => i_null,
    --    j_null => j_null,
    --    out_sel => out_sel,
    --    mem_t => mem_t,
    --    convert => convert,
    --    err_z => err_z
    --);

    ---- memory wrapper
    --mem : memory port map(
    --    clk => clk,
    --    mem_t => mem_t,
    --    mem_rd => convert,
    --    mem_wr => '0',
    --    addr_in => "XXXXXXXXXXXXXXXX",
    --    addr_out => out_sel,
    --    data_in => "XXXXXXXXXXXXXXXX",
    --    data_out => mem_out
    --);

    ---- output converter
    --outconvert_unit : outconvert port map(
    --    convert => convert,
    --    mask => mask,
    --    out_sel => out_sel,
    --    mem_out => mem_out,
    --    result => result
    --);

end structural;
