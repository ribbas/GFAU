library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity gen_sym is
    port(
        clk         : in std_logic;
        rst         : in std_logic;
        nth_term    : in std_logic_vector(15 downto 0);
        msb         : in std_logic_vector(3 downto 0);  -- size of element
        cur_term    : out std_logic_vector(15 downto 0)
    );
end gen_sym;

architecture behavioral of gen_sym is

    signal temp_data : std_logic_vector(15 downto 0);

begin

    process (clk, rst) 
    begin

        if (rst = '1') then

            temp_data <= nth_term;

        elsif rising_edge(clk) then  -- if there is a rising edge

            if (temp_data(to_integer(unsigned(msb))) = '1') then
                temp_data <= std_logic_vector(
                                shift_left(unsigned(temp_data), 1)
                            ) xor nth_term;

            else
                temp_data <= std_logic_vector(
                                shift_left(unsigned(temp_data), 1)
                            );

            end if;

        end if;

        cur_term <= temp_data;

    end process;

end behavioral;
