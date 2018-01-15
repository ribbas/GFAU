library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity operators is
    port(
        opcode  : in std_logic_vector(5 downto 0);  -- opcode
        i       : in std_logic_vector(15 downto 0); -- first element
        j       : in std_logic_vector(15 downto 0); -- second element
        n       : in std_logic_vector(3 downto 0);  -- size of polynomial
        mask    : in std_logic_vector(15 downto 0);  -- mask
        result  : out std_logic_vector(15 downto 0) -- selected output
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

    ---------------- output multiplexers ----------------

    -- output select
    component outselect
        port( 
            opcode      : in std_logic_vector(5 downto 0);
            addsubop    : in std_logic_vector(15 downto 0);
            mulop       : in std_logic_vector(15 downto 0);
            divop       : in std_logic_vector(15 downto 0);
            logop       : in std_logic_vector(15 downto 0);
            sel_out     : out std_logic_vector(15 downto 0);
            memselect   : out std_logic;
            convert     : out std_logic
        );
    end component;

    signal neg_j : std_logic_vector(15 downto 0);

    signal bitxor : std_logic_vector(15 downto 0);
    signal prod : std_logic_vector(15 downto 0);
    signal quot : std_logic_vector(15 downto 0);

    signal sel_out : std_logic_vector(15 downto 0);
    signal memselect : std_logic;
    signal convert : std_logic;

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

    -- output selector
    outselect_uut: outselect port map(
        opcode => opcode,
        addsubop => bitxor,
        mulop => prod,
        divop => quot,
        logop => i,
        sel_out => sel_out,
        memselect => memselect,
        convert => convert
    );

    result <= sel_out and mask;

    -- output converter





end structural;
