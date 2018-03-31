-- isbounded.vhd
--
-- Sabbir Ahmed
-- 2018-01-16
--
-- Generates the out-of-bound flags when the operand is greater than 2^n-2.
--

library ieee;
    use ieee.numeric_std.all;
    use ieee.std_logic_unsigned.all;
    use ieee.std_logic_1164.all;
    use ieee.std_logic_misc.all;
library work;
    use work.demo.all;

entity isbounded is
    generic(
        n           : positive := DEGREE
    );
    port(
        operand     : in std_logic_vector(n downto 0);  -- operand
        mask        : in std_logic_vector(n downto 0);  -- mask
        is_out_bd   : out std_logic
    );
end isbounded;

architecture behavioral of isbounded is

    signal is_same_mask : std_ulogic;
    signal is_below_bd : std_ulogic;

begin

    is_same_mask <= and_reduce(not operand or mask);

    is_below_bd <= and_reduce(not mask or operand);

    is_out_bd <= not is_same_mask or is_below_bd;

end behavioral;
