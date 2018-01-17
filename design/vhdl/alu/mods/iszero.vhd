-- iszero.vhd
--
-- Sabbir Ahmed
-- 2018-01-16
--
-- Generates the zero flag, when enabled.
--

library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity iszero is
    port(
        en              : in std_logic;
        operand         : in std_logic_vector(15 downto 0);  -- operand
        mem_t           : in std_logic;
        is_zero_flag    : out std_logic
   );
end iszero;

architecture structural of iszero is

    signal is_zero_flag_uand : std_ulogic;

begin

    is_zero_flag_uand <= operand(15) and operand(14) and 
                operand(13) and operand(12) and operand(11) and 
                operand(10) and operand(9) and operand(8) and 
                operand(7) and operand(6) and operand(5) and 
                operand(4) and operand(3) and operand(2) and 
                operand(1) and operand(0);

    is_zero_flag <= (is_zero_flag_uand xor mem_t) and en;

end structural;
