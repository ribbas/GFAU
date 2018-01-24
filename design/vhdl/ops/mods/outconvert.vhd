-- outconvert.vhd
--
-- Sabbir Ahmed
-- 2018-01-16
--
-- Multiplexer to convert the result of the operations if necessary.
--

library std;
library ieee;
use ieee.std_logic_1164.all;

entity outconvert is
    port(
        convert : in std_logic;
        out_sel : in std_logic_vector(15 downto 0);
        mem_out : in std_logic_vector(15 downto 0);
        result  : out std_logic_vector(15 downto 0)
    );
end outconvert;

architecture behavioral of outconvert is

begin

    process (convert, out_sel, mem_out) begin

        if (convert = '1') then

            result <= mem_out;

        else

            result <= out_sel;

        end if;

    end process;

end behavioral;

