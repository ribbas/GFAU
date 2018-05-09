library IEEE;
--import gfau library here
use IEEE.STD_LOGIC_1164.ALL;

--add whatever you need for generics i forget what to do

entity flip is
port(
    --input from generator--
    elem    :   in  std_logic_vector(n downto 0);
    poly    :   in  std_logic_vector(n downto 0);

    --control signal--
    flip    :   in  std_logic;

    --out to memory wrapper--
    addr    :   out std_logic_vector(n downto 0);
    data    :   out std_Logic_vector(n downto 0)
);
end flip;

architecture Behavioral of flip is

begin

    if flip = '0' then
        addr <= elem;
        data <= poly;
    else
        addr <= poly;
        data <= elem;
    end if;

end architecture Behavioral;
