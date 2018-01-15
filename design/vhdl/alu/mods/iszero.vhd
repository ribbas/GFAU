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

    is_zero_flag_uand <= '1' when not operand = 0 else '0';    
    is_zero_flag <= (is_zero_flag_uand xor mem_t) and en;

end structural;
