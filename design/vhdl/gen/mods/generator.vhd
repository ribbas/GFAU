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
    use work.demo.all;

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
        poly_bcd    : in std_logic_vector(n - 1 downto 0);
        mask        : in std_logic_vector(n downto 0);
        msb         : in std_logic_vector(clgn1 downto 0);

        -- memory wrapper control signals
        id_gen      : out std_logic := '0';
        mem_rdy     : in std_logic;

        -- memory signals
        gen_rdy     : out std_logic := '0';
        addr_gen    : out std_logic_vector(n downto 0) := DCAREVEC;
        elem        : out std_logic_vector(n downto 0) := DCAREVEC
    );
end generator;

architecture fsm of generator is

    signal counter : std_logic_vector(n downto 0);
    signal temp_elem : std_logic_vector(n downto 0);
    signal nth_elem : std_logic_vector(n downto 0);
    signal wr_rdy : std_logic := '0';

begin

    process (clk)
    begin

        if rising_edge(clk) then

            if (en = '1') then

                -- elem^n
                nth_elem <= (poly_bcd & '1') and mask;

                if (rst = '1') then

                    -- generator control signals
                    gen_rdy <= '0';
                    id_gen <= '1';

                    -- start element register at 2 for second element
                    temp_elem <= TWOVEC;
                    -- start counter at 1
                    counter <= ONEVEC;
                    -- first address
                    addr_gen <= ZEROVEC;
                    -- first element
                    elem <= ONEVEC;

                else

                    if (wr_rdy = '1') then

                        -- addr and data of NULL
                        addr_gen <= HIVEC;
                        elem <= ZEROVEC;

                        -- generator control signals
                        gen_rdy <= '0';
                        id_gen <= '0';

                    else

                        -- when the generator is done
                        if (and_reduce((temp_elem and mask) xnor ONEVEC) = '1')
                        then

                            -- generator control signals
                            gen_rdy <= '1';
                            id_gen <= '1';

                            -- finish writing
                            wr_rdy <= '1';

                            -- addr and data of NULL
                            addr_gen <= HIVEC;
                            elem <= ZEROVEC;

                        else

                            -- increment counter
                            counter <= std_logic_vector(unsigned(counter) + 1);

                            -- if elem^(n+(m-1))[msb] = 1
                            if (temp_elem(to_integer(unsigned(msb))) = '1') then

                                -- (elem^(n+(m-1)) << 1) xor elem^n
                                temp_elem <= std_logic_vector(
                                    shift_left(unsigned(temp_elem), 1)
                                ) xor nth_elem;

                            else
                                -- (elem^(n+(m-1)) << 1)
                                temp_elem <= std_logic_vector(
                                    shift_left(unsigned(temp_elem), 1)
                                );

                            end if;

                            -- generator control signals
                            gen_rdy <= '0';
                            id_gen <= '1';

                            -- address is counter, element is the temp element
                            -- register
                            addr_gen <= counter;
                            elem <= temp_elem and mask;

                        end if;  -- generator done

                    end if;  -- writing done

                end if;  -- rst

            end if;  -- en

        end if;  -- clk

    end process;

end fsm;
