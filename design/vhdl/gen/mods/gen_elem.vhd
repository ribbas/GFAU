-- gen_elem.vhd
--
-- Sabbir Ahmed
-- 2018-01-16
--
-- Generates the generated elembols.
--

library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;
library work;
    use work.demo.all;

entity gen_elem is
    generic(
        n       : positive := DEGREE;
        clgn1   : positive := CEILLGN1   -- ceil(log2(n - 1))
    );
    port(
        clk         : in std_logic;
        rst         : in std_logic;
        en          : in std_logic;
        nth_elem    : in std_logic_vector(n downto 0);
        msb         : in std_logic_vector(clgn1 downto 0);  -- size of element
        elem        : out std_logic_vector(n downto 0)
    );
end gen_elem;

architecture behavioral of gen_elem is

    signal temp_elem : std_logic_vector(n downto 0);

begin

    process (clk, en, rst, nth_elem, msb, temp_elem)
    begin

        if (en = '1') then

            if (rst = '1') then

                temp_elem <= nth_elem;

            elsif rising_edge(clk) then  -- if there is a rising edge

                if (temp_elem(to_integer(unsigned(msb))) = '1') then
                    temp_elem <= std_logic_vector(
                                    shift_left(unsigned(temp_elem), 1)
                                ) xor nth_elem;

                else
                    temp_elem <= std_logic_vector(
                                    shift_left(unsigned(temp_elem), 1)
                                );

                end if;

            end if;

            elem <= temp_elem;

        else

            elem <= DCAREVEC;

        end if;

    end process;

end behavioral;