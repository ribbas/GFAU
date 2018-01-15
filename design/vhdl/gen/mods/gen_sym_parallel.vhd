
-- gen_sym_parallel.vhd

-- Sabbir Ahmed
-- 2018-01-14


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity gen_sym_parallel is
    port(
        clk     : in std_logic;
        rst     : in std_logic;
        nth_sym : in std_logic_vector(15 downto 0);
        cur_sym : in std_logic_vector(15 downto 0);
        msb     : in std_logic_vector(3 downto 0);  -- size of element
        sym1    : out std_logic_vector(15 downto 0);
        sym2    : out std_logic_vector(15 downto 0)
    );
end gen_sym_parallel;

architecture behavioral of gen_sym_parallel is

    signal temp_sym1 : std_logic_vector(15 downto 0);
    signal temp_sym2 : std_logic_vector(15 downto 0);

begin

    process (clk, rst, temp_sym1, cur_sym)
    begin

        if (rst = '1') then

            sym1 <= nth_sym;

            if (nth_sym(to_integer(unsigned(msb))) = '1') then
                sym2 <= std_logic_vector(
                            shift_left(unsigned(nth_sym), 1)
                        ) xor nth_sym;

            else
                sym2 <= std_logic_vector(
                            shift_left(unsigned(nth_sym), 1)
                        );

            end if;

            report "reset";

        elsif rising_edge(clk) then  -- if there is a rising edge

            report std_logic'image(cur_sym(15)) & " " & std_logic'image(cur_sym(0));

            if (cur_sym(to_integer(unsigned(msb))) = '1') then
                temp_sym1 <= std_logic_vector(
                                shift_left(unsigned(cur_sym), 1)
                            ) xor nth_sym;

            else
                temp_sym1 <= std_logic_vector(
                                shift_left(unsigned(cur_sym), 1)
                            );

            end if;

            sym1 <= temp_sym1;

            if (temp_sym1(to_integer(unsigned(msb))) = '1') then
                sym2 <= std_logic_vector(
                            shift_left(unsigned(temp_sym1), 1)
                        ) xor nth_sym;

            else
                sym2 <= std_logic_vector(
                            shift_left(unsigned(temp_sym1), 1)
                        );

            end if;

        end if;


    end process;

end behavioral;
