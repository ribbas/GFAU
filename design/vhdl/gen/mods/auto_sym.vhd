library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity auto_sym is
    port(
        rst     : in std_logic;
        data    : out std_logic_vector(15 downto 0)
    );
end auto_sym;

architecture behavioral of auto_sym is
 
    signal temp_data    : std_logic_vector(15 downto 0);

begin

    process (rst) 
    begin

        if (rst = '1') then

            temp_data <= "0000000000000001";

        else -- if there is a rising edge

            temp_data <= std_logic_vector(shift_left(unsigned(temp_data), 1));

        end if;

        data <= temp_data;

    end process;

end behavioral;
