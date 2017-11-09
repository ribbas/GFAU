library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity addSub is
   
port ( 
    op1 : in  STD_LOGIC_VECTOR (15 downto 0);
    op2 : in  STD_LOGIC_VECTOR (15 downto 0);
    output : out  STD_LOGIC_VECTOR (15 downto 0));
end addSub;

architecture structural of addSub is

component xor2
port(
    in1     :   in  std_logic;
    in2     :   in  std_logic;
    out1    :   out std_logic);
end component;

begin

COMPUTE  :   for i in 15 downto 0 generate
    XOR_X  :   xor2 port map (op1(i), op2(i), output(i));
end generate COMPUTE;

end structural;

