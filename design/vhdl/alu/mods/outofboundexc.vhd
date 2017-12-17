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

    signal operand_mask: std_logic_vector(15 downto 0) := (others => '0');
    signal operand_in: std_logic_vector(15 downto 0) := (others => '0');
    signal operand_mask_wire: std_logic_vector(15 downto 0) := (others => '0');
    signal r_Signed_R   : unsigned(15 downto 0);
    component varmask
        port(
            poly_bcd    : in std_logic_vector(15 downto 0);
            mask        : out std_logic_vector(15 downto 0)
        );
    end component;

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

    --operand_in <= std_logic_vector(shift_left(unsigned(operand), 1));

    --mask1:  varmask port map(
    --    operand_in,
    --    operand_mask
    --);

    --operand_mask_wire <= mask xnor operand_mask;

    --process (operand_mask, mask, operand_mask_wire)
    --begin
    --    for i in 15 downto 0 loop
    --        report std_logic'image(operand_mask(i))& std_logic'image(mask(i)) & std_logic'image(operand_mask_wire(i));
    --    end loop;
    --end process;
    outofbound <= unary_and(not mask or operand);

end structural;
