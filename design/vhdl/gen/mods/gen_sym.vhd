library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity gen_sym is
    port(
        clk     : in std_logic;
        rst     : in std_logic;
        nth_sym : in std_logic_vector(15 downto 0);
        msb     : in std_logic_vector(3 downto 0);  -- size of element
        sym     : out std_logic_vector(15 downto 0)
    );
end gen_sym;

architecture behavioral of gen_sym is

    signal temp_sym : std_logic_vector(15 downto 0);

begin

    process (clk, rst)
    begin

        if (rst = '1') then

            temp_sym <= nth_sym;

        elsif rising_edge(clk) then  -- if there is a rising edge

            if (temp_sym(to_integer(unsigned(msb))) = '1') then
                temp_sym <= std_logic_vector(
                                shift_left(unsigned(temp_sym), 1)
                            ) xor nth_sym;

            else
                temp_sym <= std_logic_vector(
                                shift_left(unsigned(temp_sym), 1)
                            );

            end if;

        end if;

        sym <= temp_sym;

    end process;

end behavioral;
