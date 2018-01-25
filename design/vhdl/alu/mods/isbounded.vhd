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

entity isbounded is
    port(
        operand     : in std_logic_vector(15 downto 0);  -- operand
        mask        : in std_logic_vector(15 downto 0);  -- mask
        is_out_bd   : out std_logic
   );
end isbounded;

architecture structural of isbounded is

    signal is_same_mask : std_logic_vector(15 downto 0);
    signal is_below_bd : std_logic_vector(15 downto 0);
    signal is_same_mask_uand : std_ulogic;
    signal is_below_bd_uand : std_ulogic;

begin

    is_same_mask <= not operand or mask;
    is_same_mask_uand <= is_same_mask(15) and is_same_mask(14) and
                is_same_mask(13) and is_same_mask(12) and is_same_mask(11) and
                is_same_mask(10) and is_same_mask(9) and is_same_mask(8) and
                is_same_mask(7) and is_same_mask(6) and is_same_mask(5) and
                is_same_mask(4) and is_same_mask(3) and is_same_mask(2) and
                is_same_mask(1) and is_same_mask(0);

    is_below_bd <= not mask or operand;
    is_below_bd_uand <= is_below_bd(15) and is_below_bd(14) and
                is_below_bd(13) and is_below_bd(12) and is_below_bd(11) and
                is_below_bd(10) and is_below_bd(9) and is_below_bd(8) and
                is_below_bd(7) and is_below_bd(6) and is_below_bd(5) and
                is_below_bd(4) and is_below_bd(3) and is_below_bd(2) and
                is_below_bd(1) and is_below_bd(0);

    is_out_bd <= not is_same_mask_uand or is_below_bd_uand;

end structural;
