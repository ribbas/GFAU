----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:44:58 10/23/2017 
-- Design Name: 
-- Module Name:    addSub - Structural 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity addSub is
    Port ( op1 : in  STD_LOGIC_VECTOR (15 downto 0);
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

end Structural;

