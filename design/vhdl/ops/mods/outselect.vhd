-- outselect.vhd
--
-- Sabbir Ahmed
-- 2018-01-16
--
-- Multiplexer to select the operator's output as the result.
--

library ieee;
    use ieee.std_logic_1164.all;
library work;
    use work.demo.all;

entity outselect is
    generic(
        n       : positive := DEGREE
    );
    port(
        op      : in std_logic_vector(2 downto 0);
        out_t   : in std_logic;
        out_as  : in std_logic_vector(n downto 0);
        out_m   : in std_logic_vector(n downto 0);
        out_d   : in std_logic_vector(n downto 0);
        out_l   : in std_logic_vector(n downto 0);
        i_null  : in std_logic;
        j_null  : in std_logic;
        out_sel : out std_logic_vector(n downto 0);
        mem_t   : out std_logic;
        convert : out std_logic;
        en_con  : out std_logic;
        err_z   : out std_logic
    );
end outselect;

architecture behavioral of outselect is
begin

    process (op, out_t, out_as, out_m, out_d, out_l, i_null, j_null) begin

        case op is  -- first 3 bits

            -- add / sub
            when "001" =>

                -- add / sub output is selected
                out_sel <= out_as;
                -- enable output converter
                en_con <= '1';

                -- add / sub never throws a zero exception
                err_z <= '0';

                -- if output is requested in element form
                if (out_t = '0') then

                    -- convert to polynomial form
                    convert <= '1';
                    mem_t <= out_t;

                else

                    convert <= '0';
                    mem_t <= '-';

                end if;

            -- mul
            when "010" =>

                -- enable output converter
                en_con <= '1';

                -- mul never throws a zero exception
                err_z <= '0';

                -- if both non-null operands (a * b)
                if (i_null = '0' and j_null = '0') then

                    -- mul output is selected
                    out_sel <= out_m;

                    -- if output is requested in polynomial form
                    if (out_t = '1') then

                        -- convert to element form
                        convert <= '1';
                        mem_t <= out_t;

                    else

                        convert <= '0';
                        mem_t <= '-';

                    end if;

                -- if any of the operands are null (a * 0 or 0 * b or 0 * 0)
                else

                    convert <= '0';
                    mem_t <= '-';
                    -- null (in element form) is selected
                    out_sel <= HIVEC;

                end if;

            -- div
            when "011" =>

                for i in n downto 0 loop
                    report "quot("&integer'image(i)&")=" & std_logic'image(out_d(i));
                end loop;

                -- if both non-null operands (a/b)
                if (i_null = '0' and j_null = '0') then

                    -- enable output converter
                    en_con <= '1';

                    -- div output is selected
                    out_sel <= out_d;
                    err_z <= '0';

                    -- if output is requested in polynomial form
                    if (out_t = '1') then

                        -- convert to element form
                        convert <= '1';
                        mem_t <= out_t;

                    else

                        convert <= '0';
                        mem_t <= '-';

                    end if;

                -- if divide by null is attempted (a/0)
                elsif (j_null = '1') then

                    convert <= '0';
                    mem_t <= '-';

                    -- disable output converter
                    en_con <= '0';

                    -- throw divide by zero exception
                    err_z <= '1';
                    out_sel <= DCAREVEC;

                -- if dividing null is attempted (0/b)
                else

                    report "QUE";

                    -- enable output converter
                    en_con <= '1';

                    convert <= '0';
                    mem_t <= '-';

                    err_z <= '0';
                    out_sel <= HIVEC;

                end if;

            -- log
            when "100" =>

                -- if non-null operand (log(a))
                if (i_null <= '0') then

                    -- enable output converter
                    en_con <= '1';

                    -- log output is selected
                    out_sel <= out_l;
                    err_z <= '0';

                    -- if output is requested in polynomial form
                    if (out_t = '1') then

                        convert <= '1';
                        mem_t <= out_t;

                    else

                        convert <= '0';
                        mem_t <= '-';

                    end if;

                -- if log of null is attempted (log(0))
                else

                    -- disable output converter
                    en_con <= '0';

                    convert <= '0';
                    mem_t <= '-';

                    -- throw zero exception
                    err_z <= '1';
                    out_sel <= DCAREVEC;

                end if;

            when others =>

                -- disable output converter
                en_con <= '0';

                err_z <= '0';
                convert <= '0';
                mem_t <= '-';
                out_sel <= DCAREVEC;

        end case;

    end process;

end behavioral;
