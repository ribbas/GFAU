-- mul_sync.vhd
--
-- Sabbir Ahmed
-- 2018-01-16
--
--
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mul_sync is
    generic(
        n       : positive := 8;
        clgn    : positive := 3
    );
    port(
        clk     : in std_logic; -- clock
        rst     : in std_logic; -- reset
        i       : in std_logic_vector(n downto 0); -- first element
        j       : in std_logic_vector(n downto 0); -- second element
        size    : in std_logic_vector(clgn downto 0);  -- size of element
        prod    : out std_logic_vector(n downto 0) -- product of elements
    );
end mul_sync;

architecture structural of mul_sync is

    signal  sumij,
            sumij1  : std_logic_vector(n downto 0);

    type state_type is (init, addij, mux);  -- define the states
    signal state : state_type;

begin

    process (clk, rst)
    begin

        if (rst = '1') then            -- upon reset, set the state to a

            state <= init;

        elsif rising_edge(clk) then    -- if there is a rising edge

            case state is

                when init =>

                    sumij <= std_logic_vector(unsigned(i) + unsigned(j));
                    state <= addij;

                when addij =>

                    sumij1 <= std_logic_vector(unsigned(sumij) + 1);
                    state <= mux;

                when mux =>

                    -- if (OF(i + j) or OF(i + j + 1) == 0)
                    if ((sumij(to_integer(unsigned(size))) or
                        sumij1(to_integer(unsigned(size)))) = '0') then
                        prod <= sumij;          -- prod = i + j
                    else
                        prod <= sumij1;         -- prod = i + j + 1
                    end if;

                    state <= init;

                when others =>

                    state <= init;

            end case;

        end if;

    end process;

end structural;
