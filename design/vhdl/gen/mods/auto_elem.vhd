-- auto_elem.vhd
--
-- Sabbir Ahmed
-- 2018-01-16
--
-- Generates the automatic elembols.
--

library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;
library work;
    use work.demo.all;

entity auto_elem is
    generic(
        n       : positive := DEGREE
    );
    port(
        clk     : in std_logic;
        rst     : in std_logic;
        en      : in std_logic;
        elem    : out std_logic_vector(n downto 0)
    );
end auto_elem;

architecture behavioral of auto_elem is

    signal temp_elem : std_logic_vector(n downto 0);

begin

    process (clk, en, rst, temp_elem)
    begin

        if (en = '1') then

            if (rst = '1') then

                temp_elem <= ONEVEC;

            elsif falling_edge(clk) then  -- on falling edge

                temp_elem <= std_logic_vector(
                                shift_left(unsigned(temp_elem), 1)
                            );

            end if;

            elem <= temp_elem;

        else

            elem <= DCAREVEC;

        end if;

    end process;

end behavioral;
