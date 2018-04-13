-- auto_sym.vhd
--
-- Sabbir Ahmed
-- 2018-01-16
--
-- Generates the automatic symbols.
--

library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;
library work;
    use work.demo.all;

entity auto_sym is
    generic(
        n       : positive := DEGREE
    );
    port(
        clk     : in std_logic;
        rst     : in std_logic;
        en      : in std_logic;
        sym     : out std_logic_vector(n downto 0)
    );
end auto_sym;

architecture behavioral of auto_sym is

    signal temp_sym : std_logic_vector(n downto 0);

begin

    process (clk, en, rst, temp_sym)
    begin

        if (en = '1') then

            if (rst = '1') then

                temp_sym <= ONEVEC;

            elsif falling_edge(clk) then  -- on falling edge

                temp_sym <= std_logic_vector(
                                shift_left(unsigned(temp_sym), 1)
                            );

            end if;

            sym <= temp_sym;

        else

            sym <= DCAREVEC;

        end if;

    end process;

end behavioral;
