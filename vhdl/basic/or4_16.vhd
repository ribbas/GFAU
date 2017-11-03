library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity or4_16 is

port (
	 in1     :   in  std_logic_vector(15 downto 0);
	 in2     :   in  std_logic_vector(15 downto 0);
	 in3     :   in  std_logic_vector(15 downto 0);
	 in4     :   in  std_logic_vector(15 downto 0);
	 out1    :   out std_logic_vector(15 downto 0));
end or4_16;

architecture structural of or4_16 is

begin

	BIT_OR  :   for i in 15 downto 0 generate
		out1(i) <= in1(i) or in2(i) or  in3(i) or  in4(i);
	end generate BIT_OR;

end structural;