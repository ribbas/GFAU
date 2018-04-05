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
library work;
    use work.demo.all;

entity generator is
    generic(
        n           : positive := DEGREE;
        clgn        : positive := CEILLGN;
        clgn1       : positive := CEILLGN1
    );
    port(
        clk         : in std_logic;
        en          : in std_logic;
        rst         : in std_logic;

        -- polynomial data
        poly_bcd    : in std_logic_vector(n downto 0);
        mask        : in std_logic_vector(n downto 0);
        size        : in std_logic_vector(clgn downto 0);
        msb         : in std_logic_vector(clgn1 downto 0);

        -- memory wrapper control signals
        id_gen      : out std_logic;
        mem_rdy     : in std_logic;

        -- memory signals
        gen_rdy     : out std_logic;
        addr_gen    : out std_logic_vector(n downto 0);
        sym         : out std_logic_vector(n downto 0)
    );
end generator;

architecture fsm of generator is

    component auto_sym
        port(
            clk     : in std_logic;
            rst     : in std_logic;
            en      : in std_logic;
            sym     : out std_logic_vector(n downto 0)
        );
    end component;

    component gen_sym
        port(
            clk     : in std_logic;
            rst     : in std_logic;
            en      : in std_logic;
            nth_sym : in std_logic_vector(n downto 0);
            msb     : in std_logic_vector(clgn1 downto 0);  -- msb of element
            sym     : out std_logic_vector(n downto 0)
        );
    end component;

    signal rst_auto : std_logic := '1';
    signal en_auto : std_logic := '1';
    signal temp_auto : std_logic_vector(n downto 0);

    signal rst_gen : std_logic := '1';
    signal en_gen : std_logic := '1';
    signal temp_gen : std_logic_vector(n downto 0);
    signal nth_sym : std_logic_vector(n downto 0);

    signal counter : std_logic_vector(n downto 0);

    signal state : gen_state_type;

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

    process (clk, en, rst, poly_bcd, mask, size, msb, mem_rdy)
    begin

        nth_sym <= poly_bcd and mask;
        id_gen <= en;

        if (en = '1') then

            if (rst = '1') then

                gen_rdy <= '0';
                counter <= ZEROVEC;
                addr_gen <= ZEROVEC;
                sym <= ZEROVEC;
                state <= auto_sym_state;

            elsif rising_edge(clk) then  -- if there is a rising edge

                case state is

                    when auto_sym_state =>

                        if (mem_rdy = '1') then

                            counter <= std_logic_vector(unsigned(counter) + 1);
                            rst_auto <= '0';
                            gen_rdy <= '0';

                            if (rst_gen = '1' and
                                temp_auto(to_integer(unsigned(msb))) = '1') then

                                rst_gen <= '0';
                                en_gen <= '1';

                            end if;

                            if (rst_gen = '1' and
                                temp_auto(to_integer(unsigned(size))) = '0') then

                                sym <= temp_auto and mask;
                                state <= auto_sym_state;

                            else  -- all automatic symbols generated

                                sym <= nth_sym and mask;
                                en_auto <= '0';
                                en_gen <= '1';
                                state <= gen_sym_state;

                            end if;

                            addr_gen <= counter;

                        else

                            state <= auto_sym_state;

                        end if;

                    when gen_sym_state =>

                        report "DONE";

                        if (mem_rdy = '1') then  -- if memory is ready

                            counter <= std_logic_vector(unsigned(counter) + 1);
                            addr_gen <= counter;

                            if (((temp_gen and mask) xnor ONEVEC) = HIVEC) then

                                sym <= DCAREVEC;
                                gen_rdy <= '1';

                            else

                                sym <= temp_gen and mask;
                                gen_rdy <= '0';

                            end if;

                        end if;  -- else latch data and address values

                        state <= gen_sym_state;

                    when others =>

                        gen_rdy <= '0';
                        state <= auto_sym_state;

                end case;

            end if;  -- rst

        else

            gen_rdy <= '0';
            counter <= ZEROVEC;
            addr_gen <= DCAREVEC;
            sym <= DCAREVEC;

        end if;  -- en

    end process;

end fsm;
