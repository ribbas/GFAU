-- isnull.vhd
--
-- Sabbir Ahmed
-- 2018-01-16
--
-- Generates the zero flag, when enabled.
--

library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_misc.all;

entity isnull is
    port(
        opand   : in std_logic_vector(15 downto 0);  -- opand
        mem_t   : in std_logic;
        is_null : out std_logic
   );
end isnull;

architecture structural of isnull is

begin

    process(mem_t, opand)
    begin

        if (mem_t = '0') then

            is_null <= and_reduce(opand);

        elsif (mem_t = '1') then

            is_null <= not or_reduce(opand);

        end if;

    end process;

end structural;
