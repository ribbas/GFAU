-- isnull_gen.vhd
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

entity isnull_gen is
    generic(
        nbits : positive := 16
    );
    port(
        opand   : in std_logic_vector(nbits - 1 downto 0);  -- opand
        mem_t   : in std_logic;
        is_null : out std_logic
   );
end isnull_gen;

architecture structural of isnull_gen is

signal is_null_tmp1 : std_logic := '1';
signal is_null_tmp2 : std_logic := '0';

begin

    process(mem_t, opand, is_null_tmp1, is_null_tmp2)
    begin

        if (mem_t = '0') then

            for i in 0 to nbits - 1 loop
                is_null_tmp1 <= is_null_tmp1 and opand(i);
            end loop;

            is_null <= is_null_tmp1;

            --is_null <= and_reduce(opand);

            --is_null <=
            --            opand(15) and
            --            opand(14) and
            --            opand(13) and
            --            opand(12) and
            --            opand(11) and
            --            opand(10) and
            --            opand(9) and
            --            opand(8) and
            --            opand(7) and
            --            opand(6) and
            --            opand(5) and
            --            opand(4) and
            --            opand(3) and
            --            opand(2) and
            --            opand(1) and
            --            opand(0);

        elsif (mem_t = '1') then

            --for i in 0 to nbits - 1 loop
            --    is_null_tmp2 <= is_null_tmp2 or opand(i);
            --end loop;

            --is_null <= not(is_null_tmp2);
            --is_null <= not or_reduce(opand);

            is_null <= not(
                        opand(15) or
                        opand(14) or
                        opand(13) or
                        opand(12) or
                        opand(11) or
                        opand(10) or
                        opand(9) or
                        opand(8) or
                        opand(7) or
                        opand(6) or
                        opand(5) or
                        opand(4) or
                        opand(3) or
                        opand(2) or
                        opand(1) or
                        opand(0));

        end if;

    end process;

end structural;
