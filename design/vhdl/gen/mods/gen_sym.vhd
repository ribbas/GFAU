library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity gen_sym is
    port(
        clk         : in std_logic;
        rst         : in std_logic;
        n           : in std_logic_vector(3 downto 0);  -- size of element
        nth_term    : in std_logic_vector(15 downto 0);
        cur_term    : out std_logic_vector(15 downto 0)
    );
end gen_sym;

architecture behavioral of gen_sym is

    signal temp_data    : std_logic_vector(15 downto 0);
    signal just_shift   : std_logic := '0';

    type state_type is (init, lshift, ready);  -- define the states
    signal state: state_type;

begin

    process (clk, rst) 
    begin

        if (rst = '1') then

            state <= init;
            temp_data <= nth_term;

        elsif rising_edge(clk) then  -- if there is a rising edge

            case state is

                when init =>

                    if (temp_data(to_integer(unsigned(n))) = '0') then
                        just_shift <= '1';
                    end if;

                    temp_data <= std_logic_vector(
                                    shift_left(unsigned(temp_data), 1)
                                );
                    state <= lshift;

                when lshift =>

                    if (just_shift = '0') then
                        temp_data <= temp_data xor nth_term;
                    end if;

                    state <= ready;

                when ready =>

                    cur_term <= temp_data;
                    state <= init;

                when others =>

                    state <= init;

            end case;

        end if;

    end process;

end behavioral;
