-- memory.vhd
--
-- Sabbir Ahmed
-- 2018-01-16
--
-- Wrapper for the IS61LP6432A memory chips.
--
--

--------------- TODO: DETERMINE THE CORRECT SIGNALS FOR READ/WRITE

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity memory is
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
end memory;

architecture behavioral of memory is

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

    -- memory 1 signals
    signal A_1       : std_logic_vector(15 downto 0);
    signal nADSP_1   : std_logic;
    signal nADSC_1   : std_logic;
    signal nADV_1    : std_logic;
    signal nBW_1     : std_logic_vector(3 downto 0);
    signal nBWE_1    : std_logic;
    signal nGW_1     : std_logic;
    signal nCE_1     : std_logic;
    signal nCE2_1    : std_logic;
    signal CE2_1     : std_logic;
    signal nOE_1     : std_logic;
    signal DQ_1      : std_logic_vector(31 downto 0);
    signal MODE_1    : std_logic;
    signal ZZ_1      : std_logic;

    -- memory 2 signals
    signal A_2       : std_logic_vector(15 downto 0);
    signal nADSP_2   : std_logic;
    signal nADSC_2   : std_logic;
    signal nADV_2    : std_logic;
    signal nBW_2     : std_logic_vector(3 downto 0);
    signal nBWE_2    : std_logic;
    signal nGW_2     : std_logic;
    signal nCE_2     : std_logic;
    signal nCE2_2    : std_logic;
    signal CE2_2     : std_logic;
    signal nOE_2     : std_logic;
    signal DQ_2      : std_logic_vector(31 downto 0);
    signal MODE_2    : std_logic;
    signal ZZ_2      : std_logic;

begin

    -- read:
    --  nCE     = 0
    --  nCE2    = 0
    --  CE2     = 1
    --  ZZ      = 0
    --  nADSP   = 0
    --  nOE     = 0

    -- write:
    --  nCE     = 0
    --  nCE2    = 0
    --  CE2     = 1
    --  ZZ      = 0
    --  nADSP   = 1
    --  nADSC   = 0
    --  nWRITE  = 0


    -- element memory (mem1), addr = polynomial, data = element
    mem1 : IS61LP6432A port map(
        A => A_1,
        clk => clk,
        nADSP => nADSP_1,
        nADSC => nADSC_1,
        nADV => nADV_1,
        nBW => nBW_1,
        nBWE => nBWE_1,
        nGW => nGW_1,
        nCE => nCE_1,
        nCE2 => nCE2_1,
        CE2 => CE2_1,
        nOE => nOE_1,
        DQ  => DQ_1,
        MODE => MODE_1,
        ZZ  => ZZ_1
    );

    -- polynomial memory (mem2), addr = element, data = polynomial
    mem2 : IS61LP6432A port map(
        A => A_2,
        clk => clk,
        nADSP => nADSP_2,
        nADSC => nADSC_2,
        nADV => nADV_2,
        nBW => nBW_2,
        nBWE => nBWE_2,
        nGW => nGW_2,
        nCE => nCE_2,
        nCE2 => nCE2_2,
        CE2 => CE2_2,
        nOE => nOE_2,
        DQ  => DQ_2,
        MODE => MODE_2,
        ZZ  => ZZ_2
    );

    process (clk, mem_t, addr_in, addr_out) begin

        if (rising_edge(clk)) then

            if (mem_t = '0') then  -- mem1

                -- if memory read
                if (mem_rd = '1' and mem_wr = '0') then

                    nCE_1 <= '0';
                    nCE2_1 <= '0';
                    CE2_1 <= '1';
                    ZZ_1 <= '0';
                    nADSP_1 <= '0';
                    nOE_1 <= '0';
                    A_1 <= addr_out;
                    data_out <= DQ_1(31 downto 16);

                -- if memory write
                elsif (mem_rd = '0' and mem_wr = '1') then

                    nCE_1 <= '0';
                    nCE2_1 <= '0';
                    CE2_1 <= '1';
                    ZZ_1 <= '0';
                    nADSP_1 <= '1';
                    nADSC_1 <= '0';
                    --nWRITE_1 <= '0';
                    A_1 <= addr_in;
                    DQ_1 <= data_in & (15 downto 0 => '0');

                end if;

            else  -- mem2

                -- if memory read
                if (mem_rd = '1' and mem_wr = '0') then

                    nCE_2 <= '0';
                    nCE2_2 <= '0';
                    CE2_2 <= '1';
                    ZZ_2 <= '0';
                    nADSP_2 <= '0';
                    nOE_2 <= '0';
                    A_2 <= addr_in;
                    data_out <= DQ_2(31 downto 16);

                -- if memory write
                elsif (mem_rd = '0' and mem_wr = '1') then

                    nCE_2 <= '0';
                    nCE2_2 <= '0';
                    CE2_2 <= '1';
                    ZZ_2 <= '0';
                    nADSP_2 <= '1';
                    nADSC_2 <= '0';
                    --nWRITE_2 <= '0';
                    A_2 <= addr_out;
                    DQ_2 <= data_in & (15 downto 0 => '0');

                end if;

            end if;

        end if;

    end process;

end behavioral;
