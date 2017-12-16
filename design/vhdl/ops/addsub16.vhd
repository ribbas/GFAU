library ieee;
use ieee.std_logic_1164.all;

entity addsub16 is
    port ( 
        i     : in  std_logic_vector (15 downto 0);
        j     : in  std_logic_vector (15 downto 0);
        bitxor  : out  std_logic_vector (15 downto 0)
    );
end addsub16;

architecture structural of addsub16 is

    component xor2
        port(
            in1     :   in  std_logic;
            in2     :   in  std_logic;
            out1    :   out std_logic
        );
    end component;

begin

    compute     :   for k in 15 downto 0 generate
        xor_x   :   xor2 port map(i(k), j(k), bitxor(k));
    end generate compute;

end structural;
