-- generator.vhd
--
-- Sabbir Ahmed
-- 2018-01-16
--
-- Controller for the automatic and generated symbols.
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity generator is
    port(
        clk         : in std_logic;
        en          : in std_logic;
        rst         : in std_logic;

        -- polynomial data
        poly_bcd    : in std_logic_vector(8 downto 0);
        mask        : in std_logic_vector(8 downto 0);
        msb         : in std_logic_vector(3 downto 0);
        size        : in std_logic_vector(3 downto 0);

        -- memory signals
        wr_en       : out std_logic;
        rdy         : out std_logic;
        addr        : out std_logic_vector(8 downto 0);
        sym         : out std_logic_vector(8 downto 0)
    );
end generator;

architecture fsm of generator is

    component claadder16
        port(
            a   : in std_logic_vector(8 downto 0);
            b   : in std_logic_vector(8 downto 0);
            s   : out std_logic_vector(8 downto 0)
        );
    end component;

    component auto_sym
        port(
            clk : in std_logic;
            rst : in std_logic;
            en  : in std_logic;
            sym : out std_logic_vector(8 downto 0)
        );
    end component;

    component gen_sym
        port(
            clk     : in std_logic;
            rst     : in std_logic;
            en  : in std_logic;
            msb     : in std_logic_vector(3 downto 0);  -- n of element
            nth_sym : in std_logic_vector(8 downto 0);
            sym     : out std_logic_vector(8 downto 0)
        );
    end component;

    signal sum : std_logic_vector(8 downto 0);

    signal rst_auto : std_logic := '1';
    signal en_auto : std_logic := '1';
    signal temp_auto : std_logic_vector(8 downto 0);

    signal rst_gen : std_logic := '1';
    signal en_gen : std_logic := '1';
    signal temp_gen : std_logic_vector(8 downto 0);

    signal nth_sym : std_logic_vector(8 downto 0);
    signal counter : std_logic_vector(8 downto 0);

    type state_type is (auto_sym_state, gen_sym_state);  -- define the states
    signal state : state_type;

begin

    auto : auto_sym port map(
        clk => clk,
        rst => rst_auto,
        en => en_auto,
        sym => temp_auto
    );

    gen : gen_sym port map(
        clk => clk,
        rst => rst_gen,
        en => en_gen,
        msb => msb,
        nth_sym => nth_sym,
        sym => temp_gen
    );

    --cla : claadder16 port map(
    --    a => counter,
    --    b => "0000000000000001",
    --    s => sum
    --);

    process (clk, en, rst, poly_bcd, mask)

        constant DCAREVEC : std_logic_vector(8 downto 0) := (others => '-');
        constant ZEROVEC : std_logic_vector(8 downto 0) := (others => '0');
        constant ONEVEC : std_logic_vector(8 downto 0) := (0 => '1', others => '0');
        constant HIVEC : std_logic_vector(8 downto 0) := (others => '1');

    begin

        nth_sym <= poly_bcd and mask;
        wr_en <= en;

        if (en = '1') then

            if (rst = '1') then

                rdy <= '0';
                counter <= ZEROVEC;
                addr <= ZEROVEC;
                sym <= ZEROVEC;
                state <= auto_sym_state;

            elsif rising_edge(clk) then  -- if there is a rising edge

                case state is

                    when auto_sym_state =>

                        rst_auto <= '0';
                        counter <= std_logic_vector(unsigned(counter) + 1);
                        rdy <= '0';

                        if (rst_gen = '1' and temp_auto(to_integer(unsigned(msb))) = '1') then

                            rst_gen <= '0';
                            en_gen <= '0';
                            en_gen <= '1';

                        end if;

                        if (rst_gen = '1' and temp_auto(to_integer(unsigned(size))) = '0') then

                            sym <= temp_auto and mask;
                            state <= auto_sym_state;

                        else  -- all automatic symbols generated

                            sym <= nth_sym and mask;
                            state <= gen_sym_state;
                            en_auto <= '0';
                            en_gen <= '1';

                        end if;

                        addr <= counter;

                    when gen_sym_state =>

                        counter <= std_logic_vector(unsigned(counter) + 1);

                        if (((temp_gen and mask) xnor ONEVEC) = HIVEC) then

                            sym <= DCAREVEC;
                            addr <= DCAREVEC;
                            rdy <= '1';

                        else

                            sym <= temp_gen and mask;
                            addr <= counter;
                            rdy <= '0';

                        end if;

                        state <= gen_sym_state;

                    when others =>

                        rdy <= '0';
                        --addr <= DCAREVEC;
                        --sym <= DCAREVEC;
                        state <= auto_sym_state;

                end case;

            end if;  -- rst

        else

            rdy <= '0';
            counter <= ZEROVEC;
            addr <= DCAREVEC;
            sym <= DCAREVEC;

        end if;  -- en

    end process;

end fsm;
