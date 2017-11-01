library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity and4_16 is

port (
    in1     :   in  std_logic;
    in2     :   in  std_logic;
	 in3     :   in  std_logic;
	 in4     :   in  std_logic_vector(15 downto 0);
    out1    :   out std_logic_vector(15 downto 0));
end and4_16;

architecture structural of and4_16 is

begin

	BIT_AND  :   for i in 15 downto 0 generate
		out1(i) <= in1 and in2 and in3 and in4(i);
	end generate BIT_AND;

end structural;