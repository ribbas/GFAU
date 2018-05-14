-- generator.vhd
--
-- Sabbir Ahmed
-- 2018-01-16
--
-- Controller for the automatic and generated elements.
--

library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;
    use ieee.std_logic_misc.all;
library work;
    use work.glob.all;

entity generator is
    generic(
        n           : positive := DEGREE;
        clgn1       : positive := CEILLGN1
    );
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
        id_gen      : out std_logic := '0';
        mem_rdy     : in std_logic;

        -- memory signals
        gen_rdy     : out std_logic := '0';
        addr_gen    : out std_logic_vector((n + 1) downto 0) := '-' & DCAREVEC;
        elem        : out std_logic_vector(n downto 0) := DCAREVEC
    );
end generator;

architecture fsm of generator is

    signal counter : std_logic_vector(n downto 0);
    signal temp_elem : std_logic_vector(n downto 0);
    signal temp_elem_f : std_logic_vector(n downto 0);
    signal nth_elem : std_logic_vector(n downto 0);
    signal wr_rdy : std_logic := '0';

    type flip_state is (e2p, p2e);
    signal flippy_flop : flip_state;

begin

    process (clk) begin

        if rising_edge(clk) then

            if (rst = '1') then

                -- generator control signals
                gen_rdy <= '0';
                id_gen <= '1';

                -- start element register at 2 for second element
                temp_elem <= ONEVEC;

                -- start flip element register at 1 for second element
                temp_elem_f <= ONEVEC;

                -- start counter at 1
                counter <= ZEROVEC;
                -- first address
                addr_gen <= '-' & DCAREVEC;
                -- first element
                elem <= DCAREVEC;

                -- save this for later :)
                poly_bcd_reg <= poly_bcd(n downto 1);

                -- elem^n
                nth_elem <= (poly_bcd((n - 1) downto 0) & '1') and mask;

            end if;

            if (en = '1' and rst = '0') then

                case flippy_flop is

                    when e2p =>

                        if (mem_rdy = '1') then

                            id_gen <= '1';

                            -- when the generator is done
                            if (counter = mask) then

                                -- generator control signals
                                gen_rdy <= '0';

                                -- finish writing
                                wr_rdy <= '0';

                                -- addr and data of NULL
                                addr_gen <= '1' & HIVEC;
                                elem <= ZEROVEC;

                            else


                                -- if elem^(n+(m-1))[msb] = 1
                                if (temp_elem(to_integer(unsigned(msb))) = '1') then

                                    -- (elem^(n+(m-1)) << 1) xor elem^n
                                    temp_elem <= (temp_elem(n - 1 downto 0) & '0')
                                     xor nth_elem;

                                else
                                    -- (elem^(n+(m-1)) << 1)
                                    temp_elem <= (temp_elem(n - 1 downto 0) & '0');

                                end if;

                                -- generator control signals
                                gen_rdy <= '0';
                                id_gen <= '1';

                                -- address is counter, element is the temp element
                                -- register
                                addr_gen <= '0' & counter;
                                elem <= temp_elem and mask;
                                temp_elem_f <= temp_elem and mask;

                            end if;

                            flippy_flop <= p2e;

                        end if;

                    when p2e =>

                        if (mem_rdy = '1') then

                            if (wr_rdy = '1') then

                                -- addr and data of NULL
                                addr_gen <= '1' & HIVEC;
                                elem <= ZEROVEC;

                                -- generator control signals
                                gen_rdy <= '1';
                                id_gen <= '0';

                            else

                                -- when the generator is done
                                if (counter = mask) then

                                    -- generator control signals
                                    gen_rdy <= '0';
                                    id_gen <= '1';

                                    -- finish writing
                                    wr_rdy <= '1';

                                    -- addr and data of NULL
                                    addr_gen <= '0' & ZEROVEC;
                                    elem <= HIVEC;

                                else

                                    addr_gen <= '1' & (temp_elem_f and mask);
                                    elem <= counter;

                                    -- increment counter
                                    counter <= std_logic_vector(unsigned(counter) + 1);

                                    flippy_flop <= e2p;

                                end if;

                            end if;

                        end if;  -- memory ready

                    end case;

            end if;

        end if;  -- clk

    end process;

end fsm;
