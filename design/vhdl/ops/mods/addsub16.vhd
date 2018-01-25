-- addsub16.vhd
--
-- Jeffrey Osazuwa, Sabbir Ahmed
-- 2018-01-16
--
-- Computes the Galois addition / subtraction of two symbols.
--

library ieee;
use ieee.std_logic_1164.all;

entity addsub16 is
    port (
        i       : in std_logic_vector (15 downto 0);
        j       : in std_logic_vector (15 downto 0);
        i_null  : in std_logic;
        j_null  : in std_logic;
        bitxor  : out std_logic_vector (15 downto 0)
    );
end addsub16;

architecture structural of addsub16 is
begin

    process (i, j, i_null, j_null)
    begin

        -- if operand 1 is null
        if (i_null = '1' and j_null = '0') then

            bitxor <= j;

        -- if operand 2 is null
        elsif (i_null = '0' and j_null = '1') then

            bitxor <= i;

        -- if both operands are null
        elsif (i_null = '1' and j_null = '1') then

            bitxor <= "0000000000000000";

        -- if both operands are non-null
        else

            bitxor <= i xor j;

        end if;

    end process;

end structural;
