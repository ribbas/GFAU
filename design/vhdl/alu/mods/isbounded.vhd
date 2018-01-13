library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

entity isbounded is
    port(
        operand         : in std_logic_vector(15 downto 0);  -- operand
        mask            : in std_logic_vector(15 downto 0);  -- mask
        is_out_bd       : out std_logic
   );
end isbounded;

architecture structural of isbounded is

    signal is_same_mask : std_logic;
    signal is_below_bd : std_logic;

    component unary_and16 is
        port(
            in1     :   in std_logic_vector(15 downto 0);
            in2     :   in std_logic_vector(15 downto 0);
            out1    :   out std_logic
        );
    end component;

begin

    unary_and1: unary_and16 port map(
        in1 => not operand,
        in2 => mask,
        out1 => is_same_mask
    );

    unary_and2: unary_and16 port map(
        in1 => not mask,
        in2 => operand,
        out1 => is_below_bd
    );

    is_out_bd <= not is_same_mask or is_below_bd;

end structural;
