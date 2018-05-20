-- ismember.vhd
--
-- Sabbir Ahmed
-- 2018-01-16
--
-- Generates the non-membership flag when the operand exceeds 2^n-2.
--

library ieee;
    use ieee.numeric_std.all;
    use ieee.std_logic_unsigned.all;
    use ieee.std_logic_1164.all;
    use ieee.std_logic_misc.all;
library work;
    use work.glob.all;

entity ismember is
    generic(
        n           : positive := 14
    );
    port(
        operand     : in std_logic_vector(n downto 0);  -- operand
        mask        : in std_logic_vector(n downto 0);  -- mask
        is_not_in   : out std_logic
    );
end ismember;

architecture behavioral of ismember is
    
    signal is_same_mask : std_ulogic;
    signal is_below_bd : std_ulogic;

begin

    is_same_mask <= and_reduce(not operand or mask);

    is_below_bd <= and_reduce(not mask or operand);

    is_not_in <= not is_same_mask or is_below_bd;

end behavioral;
