
-- isbounded.vhd

-- Sabbir Ahmed
-- 2018-01-14


library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_1164.all;

entity isbounded is
    port(
        operand         : in std_logic_vector(15 downto 0);  -- operand
        mask            : in std_logic_vector(15 downto 0);  -- mask
        is_out_bd       : out std_logic
   );
end isbounded;

architecture structural of isbounded is

    signal is_same_mask : std_logic_vector(15 downto 0);
    signal is_below_bd : std_logic_vector(15 downto 0);
    signal is_same_mask_uand : std_ulogic;
    signal is_below_bd_uand : std_ulogic;

begin

    is_same_mask <= not operand or mask;
    is_same_mask_uand <= '1' when not is_same_mask = 0 else '0';

    is_below_bd <= not mask or operand;
    is_below_bd_uand <= '1' when not is_below_bd = 0 else '0';

    is_out_bd <= not is_same_mask_uand or is_below_bd_uand;

end structural;
