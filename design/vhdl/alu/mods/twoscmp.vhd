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

entity twoscmp is
    generic(
        n       : positive := 8
    );
    port(
        num     : in  std_logic_vector(n downto 0);
        tcnum   : out  std_logic_vector(n downto 0)
   );
end twoscmp;

architecture structural of twoscmp is

    component claadder16
        port(
            a   : in std_logic_vector(n downto 0);
            b   : in std_logic_vector(n downto 0);
            s   : out std_logic_vector(n downto 0)
        );
    end component;

    signal tc: std_logic_vector(n downto 0);

begin

    tc <= not num;

    cla16:  claadder16 port map(  -- add 1
        tc,
        (0 => '1', others => '0'),
        tcnum
    );

end structural;
