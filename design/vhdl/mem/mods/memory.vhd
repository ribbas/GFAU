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
    generic(
        n           : positive := 8
    );
    port(
        clk         : in std_logic;
        mem_t       : in std_logic;
        mem_rd      : in std_logic;
        mem_wr      : in std_logic;
        id_cu       : in std_logic;
        addr_cu     : in std_logic_vector(n downto 0);
        dout_cu     : out std_logic_vector(n downto 0);
        id_gen      : in std_logic;
        addr_gen    : in std_logic_vector(n downto 0);
        din_gen     : in std_logic_vector(n downto 0);
        id_con      : in std_logic;
        addr_con    : in std_logic_vector(n downto 0);
        dout_con    : out std_logic_vector(n downto 0)
    );
end memory;

architecture behavioral of memory is

    ---------------- memory ----------------

    -- CY7C1020DV33

    -- control signals
    signal nCE : std_logic;
    signal nOE : std_logic;
    signal nWE : std_logic;
    signal nBLE : std_logic;
    signal nBHE  : std_logic;
    signal A : std_logic_vector(n downto 0);
    signal DQ : std_logic_vector(n downto 0);

    signal nBHE : std_logic;

    constant HIIMPVEC : std_logic_vector(n downto 0) := (others => 'Z');
    constant DCAREVEC : std_logic_vector(n downto 0) := (others => '-');

begin

    -- read:
    -- nCE = 0;
    -- nOE = 0;
    -- nWE = 1;
    -- nBLE = 0;
    -- nBHE  = 0;

    -- write:
    -- nCE = 0;
    -- nOE = -;
    -- nWE = 0;
    -- nBLE = 0;
    -- nBHE  = 0;


    -- element memory (mem1), addr = polynomial, data = element

    -- polynomial memory (mem2), addr = element, data = polynomial

    process (clk, addr_cu, addr_gen, addr_con, din_gen, dout_cu, dout_con,
        id_cu, id_gen, id_con, mem_rd, mem_wr) begin

        if (rising_edge(clk)) then

            -- if memory read
            if (mem_rd = '1' and mem_wr = '0') then

                -- control unit
                if (id_cu = '1' and id_gen = '0' and id_con = '0') then

                    -- read control signals
                    nCE <= '0';
                    nOE <= '0';
                    nWE <= '1';
                    nBLE <= '0';
                    nBHE  <= '0';

                    A <= addr_cu;
                    dout_cu <= DQ;

                    dout_con <= DCAREVEC;

                -- output converter
                elsif (id_cu = '0' and id_gen = '0' and id_con = '1') then

                    -- read control signals
                    nCE <= '0';
                    nOE <= '0';
                    nWE <= '1';
                    nBLE <= '0';
                    nBHE  <= '0';

                    A <= addr_con;
                    dout_con <= DQ;

                    dout_cu <= DCAREVEC;

                else then

                    -- stand-by control signals
                    nCE <= '0';
                    nOE <= '-';
                    nWE <= '-';
                    nBLE <= '-';
                    nBHE  <= '-';

                    A <= DCAREVEC;
                    DQ <= HIIMPVEC;

                    -- data outs are don't care
                    dout_con <= DCAREVEC;
                    dout_cu <= DCAREVEC;

                end if;

            -- if memory write
            elsif (mem_rd = '0' and mem_wr = '1') then

                -- generator
                if (id_cu = '0' and id_gen = '1' and id_con = '0') then

                    -- write control signals
                    nCE <= '0';
                    nOE <= '-';
                    nWE <= '0';
                    nBLE <= '0';
                    nBHE  <= '0';

                    A <= addr_gen;
                    DQ <= din_gen;

                else then

                    -- stand-by control signals
                    nCE <= '0';
                    nOE <= '-';
                    nWE <= '-';
                    nBLE <= '-';
                    nBHE  <= '-';

                    A <= DCAREVEC;
                    DQ <= HIIMPVEC;

                    -- data outs are don't care
                    dout_con <= DCAREVEC;
                    dout_cu <= DCAREVEC;

                end if;

            else then

                -- stand-by
                nCE <= '0';
                nOE <= '0';
                nWE <= '1';
                nBLE <= '0';
                nBHE  <= '0';
                A <= DCAREVEC;
                DQ <= HIIMPVEC;

                -- data outs are don't care
                dout_con <= DCAREVEC;
                dout_cu <= DCAREVEC;

            end if;

        end if;

    end process;

end behavioral;
