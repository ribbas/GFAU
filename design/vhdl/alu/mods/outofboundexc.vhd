library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

entity outofboundexc is
    port(
        operand     : in std_logic_vector(15 downto 0);  -- operand
        mask        : in std_logic_vector(15 downto 0);  -- mask
        outofbound  : out std_logic
   );
end outofboundexc;

architecture structural of outofboundexc is

    signal or_mask: std_logic_vector(15 downto 0) := (others => '0');
    signal xnor_mask: std_logic_vector(15 downto 0) := (others => '0');

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

    or_mask <= operand or mask;
    xnor_mask <= or_mask xnor mask;

    outofbound <= not unary_and(xnor_mask) or unary_and(not mask or operand);

end structural;
