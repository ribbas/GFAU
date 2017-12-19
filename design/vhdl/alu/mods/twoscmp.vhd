library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity twoscmp is
    port(
        num     : in  std_logic_vector(15 downto 0);
        tcnum   : out  std_logic_vector(15 downto 0)
   );
end twoscmp;

architecture structural of twoscmp is

    component claadder16
        port(
            a       : in std_logic_vector(15 downto 0);
            b       : in std_logic_vector(15 downto 0);
            s       : out std_logic_vector(15 downto 0)
        );
    end component;

    signal tc: std_logic_vector(15 downto 0);
    signal one16: std_logic_vector(15 downto 0) := "0000000000000001";

begin

    cla16:  claadder16 port map(  -- add 1
                not num,
                one16,
                tcnum
            );

end structural;
