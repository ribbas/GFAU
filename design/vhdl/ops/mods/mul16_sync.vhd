
-- mul16_sync.vhd

-- Sabbir Ahmed
-- 2018-01-14


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mul16 is
    port(
        clk     : in std_logic;
        rst     : in std_logic;
        i       : in std_logic_vector(15 downto 0); -- first element
        j       : in std_logic_vector(15 downto 0); -- second element
        n       : in std_logic_vector(3 downto 0);  -- size of element
        prod    : out std_logic_vector(15 downto 0) -- product of elements
    );
end mul16;

architecture structural of mul16 is

    component claadder16
        port(
            a       : in std_logic_vector(15 downto 0);
            b       : in std_logic_vector(15 downto 0);
            s       : out std_logic_vector(15 downto 0)
        );
    end component;
 
    signal  one16   : std_logic_vector(15 downto 0) := "0000000000000001";
    signal  in1,
            in2,
            sum     : std_logic_vector(15 downto 0);
    signal  sumij,
            sumij1  : std_logic_vector(15 downto 0);
    signal  sumijof,
            sumij1of: std_logic;

    type state_type is (init, addij, addij1, mux);  -- define the states
    signal state : state_type;

begin

    adder   :   claadder16 port map(
                    in1,              -- first element
                    in2,              -- second element
                    sum               -- sum of i and j
                );

    process (clk, rst) 
    begin

        if (rst = '1') then            -- upon reset, set the state to a

            state <= init;
            in1 <= "0000000000000000";
            in2 <= "0000000000000000";

        elsif rising_edge(clk) then    -- if there is a rising edge

            case state is

                when init =>

                    in1 <= i;
                    in2 <= j;
                    state <= addij;

                when addij =>

                    sumij <= sum;
                    sumijof <= sum(to_integer(unsigned(n)));
                    in1 <= sum;
                    in2 <= one16;
                    state <= addij1;

                when addij1 =>

                    sumij1 <= sum;
                    sumij1of <= sum(to_integer(unsigned(n)));
                    state <= mux;

                when mux =>

                    -- if (OF(i + j) or OF(i + j + 1) == 0)
                    if ((sumijof or sumij1of) = '0') then
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
