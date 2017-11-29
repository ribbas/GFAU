library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity twosComp is
    Port (input: in  STD_LOGIC_VECTOR (15 downto 0);
	       size    :   in integer;    
	       output: out  STD_LOGIC_VECTOR (15 downto 0));
end twosComp;

architecture structural of twosComp is

component inverter
port(
    in1     :   in  std_logic;
    out1    :   out std_logic);
end component;

component claadder16
port(
        a       : in std_logic_vector (15 downto 0);
        b       : in std_logic_vector (15 downto 0);
        cin     : in std_logic;
        s       : out std_logic_vector (15 downto 0);
        cout    : out std_logic);
end component;

signal carry: std_logic; 
signal temp, temp2: std_logic_vector(15 downto 0);
signal one16: std_logic_vector(15 downto 0) := "0000000000000001";

begin

INVERT: for i in 15 downto 0 generate
    INVERT_X: inverter port map (input(i), temp(i));
end generate INVERT;

cla16: claadder16 port map(
           temp,
			  one16,
			  '0',
			  output,
			  carry
       );
		 
process(size)
variable i: POSITIVE:= size;
begin
	while i < 16 loop
	    output(i) <= '0';
		 i:= i + 1;
   end loop;
end process;


end structural;

