library ieee;
use ieee.std_logic_1164.all;

entity addsub is
   
port ( 
    op1 : in  std_logic_vector (15 downto 0);
    op2 : in  std_logic_vector (15 downto 0);
    output : out  std_logic_vector (15 downto 0));
end addsub;

architecture structural of addsub is

component xor2
port(
    in1     :   in  std_logic;
    in2     :   in  std_logic;
    out1    :   out std_logic);
end component;

begin

compute  :   for i in 15 downto 0 generate
    xor_x  :   xor2 port map (op1(i), op2(i), output(i));
end generate compute;

end structural;

