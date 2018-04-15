-- generator.vhd
--
-- Sabbir Ahmed
-- 2018-01-16
--
-- Controller for the automatic and generated elembols.
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
        poly_bcd    : in std_logic_vector(n - 1 downto 0);
        mask        : in std_logic_vector(n downto 0);
        size        : in std_logic_vector(clgn downto 0);
        msb         : in std_logic_vector(clgn1 downto 0);

        -- memory wrapper control signals
        id_gen      : out std_logic;
        mem_rdy     : in std_logic;

        -- memory signals
        gen_rdy     : out std_logic;
        addr_gen    : out std_logic_vector(n downto 0);
        elem         : out std_logic_vector(n downto 0)
    );
end generator;

architecture fsm of generator is

    component auto_elem
        port(
            clk     : in std_logic;
            rst     : in std_logic;
            en      : in std_logic;
            elem    : out std_logic_vector(n downto 0)
        );
    end component;

    component gen_elem
        port(
            clk         : in std_logic;
            rst         : in std_logic;
            en          : in std_logic;
            nth_elem    : in std_logic_vector(n downto 0);
            msb         : in std_logic_vector(clgn1 downto 0);  -- msb of element
            elem        : out std_logic_vector(n downto 0)
        );
    end component;

    signal rst_auto : std_logic := '1';
    signal en_auto : std_logic := '1';
    signal temp_auto : std_logic_vector(n downto 0);

    signal rst_gen : std_logic := '1';
    signal en_gen : std_logic := '1';
    signal next_gen : std_logic := '0';
    signal temp_gen : std_logic_vector(n downto 0);
    signal nth_elem : std_logic_vector(n downto 0);

    signal counter : std_logic_vector(n downto 0);

    signal state : gen_state_type;

begin

    auto : auto_elem port map(
        clk => clk,
        rst => rst_auto,
        en => en_auto,
        elem => temp_auto
    );

    gen : gen_elem port map(
        clk => clk,
        rst => rst_gen,
        en => en_gen,
        msb => msb,
        nth_elem => nth_elem,
        elem => temp_gen
    );

    process (clk, en, rst, poly_bcd, mask, size, msb, mem_rdy)
    begin

        nth_elem <= (poly_bcd & '1') and mask;
        id_gen <= en;

        if (en = '1') then

            if (rst = '1') then

                gen_rdy <= '0';
                counter <= ZEROVEC;
                addr_gen <= ZEROVEC;
                elem <= ZEROVEC;
                state <= auto_elem_state;

            elsif rising_edge(clk) then  -- if there is a rising edge

                case state is

                    when auto_elem_state =>

                        if (mem_rdy = '1') then

                            counter <= std_logic_vector(unsigned(counter) + 1);
                            rst_auto <= '0';
                            gen_rdy <= '0';

                            if (rst_gen = '1' and
                                temp_auto(to_integer(unsigned(msb))) = '1'
                                ) then

                                rst_gen <= '0';
                                en_gen <= '1';

                            end if;

                            if (rst_gen = '1' and
                                temp_auto(to_integer(unsigned(size))) = '0'
                                ) then

                                elem <= temp_auto and mask;
                                state <= auto_elem_state;

                            else  -- all automatic elembols generated

                                elem <= nth_elem and mask;
                                en_auto <= '0';
                                en_gen <= '1';
                                state <= gen_elem_state;

                            end if;

                            addr_gen <= counter;

                        else

                            state <= auto_elem_state;

                        end if;

                    when gen_elem_state =>

                        if (mem_rdy = '1') then  -- if memory is ready

                            counter <= std_logic_vector(unsigned(counter) + 1);

                            -- when the generator is done
                            if (((temp_gen and mask) xnor ONEVEC) = HIVEC) then

                                elem <= HIVEC;
                                addr_gen <= ZEROVEC;
                                next_gen <= '1';

                            elsif (next_gen = '1') then

                                elem <= DCAREVEC;
                                addr_gen <= counter;
                                next_gen <= '0';
                                gen_rdy <= '1';

                            else

                                addr_gen <= counter;
                                elem <= temp_gen and mask;
                                gen_rdy <= '0';

                            end if;

                        end if;  -- else latch data and address values

                        state <= gen_elem_state;

                    when others =>

                        gen_rdy <= '0';
                        state <= auto_elem_state;

                end case;

            end if;  -- rst

        else

            gen_rdy <= '0';
            counter <= ZEROVEC;
            addr_gen <= DCAREVEC;
            elem <= DCAREVEC;

        end if;  -- en

    end process;

end fsm;
