-- twoscmp.vhd
--
-- Sabbir Ahmed
-- 2018-01-16
--
-- Generates the two's complement of the operand.
--

library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;
library work;
    use work.demo.all;

entity twoscmp is
    generic(
        n       : positive := DEGREE
    );
    port(
        num     : in std_logic_vector(n downto 0);
        tcnum   : out std_logic_vector(n downto 0)
   );
end twoscmp;

architecture structural of twoscmp is

begin

    tcnum <= std_logic_vector(unsigned(not num) + unsigned(ONEVEC));

end structural;
