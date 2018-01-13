--and.vhd

library std;
library ieee;
use ieee.std_logic_1164.all;

entity unary_and16 is
    port(
        in1     :   in std_logic_vector(15 downto 0);
        in2     :   in std_logic_vector(15 downto 0);
        out1    :   out std_logic
    );
end unary_and16;

architecture structural of unary_and16 is

    function unary_and(vect : in std_logic_vector(15 downto 0))
    return std_logic is
        variable bit_and : std_logic := '1';
    begin
        for i in 15 downto 0 loop
            bit_and := bit_and and vect(i);
        end loop;
        return bit_and;
    end function;

begin

    out1 <= unary_and(in1 or in2);

end structural;
