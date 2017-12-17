library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

entity iszero is
    port(
        operand         : in std_logic_vector(15 downto 0);  -- operand
        is_zero_flag    : out std_logic
   );
end iszero;

architecture structural of iszero is

    component unary_and16 is
        port(
            in1     :   in std_logic_vector(15 downto 0);
            out1    :   out std_logic
        );
    end component;

begin

    unary_and1: unary_and16 port map(
            operand,
            is_zero_flag
        );

end structural;
