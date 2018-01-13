library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

entity iszero is
    port(
        en              : in std_logic;
        operand         : in std_logic_vector(15 downto 0);  -- operand
        mem_t           : in std_logic;
        is_zero_flag    : out std_logic
   );
end iszero;

architecture structural of iszero is

    component unary_and16 is
        port(
            in1     :   in std_logic_vector(15 downto 0);
            in2     :   in std_logic_vector(15 downto 0);
            out1    :   out std_logic
        );
    end component;

    signal uand : std_logic;

begin

    unary_and1: unary_and16 port map(
        in1 => operand,
        in2 => operand,
        out1 => uand
    );

    is_zero_flag <= (uand xor mem_t) and en;

end structural;
