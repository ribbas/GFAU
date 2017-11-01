----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:11:13 10/31/2017 
-- Design Name: 
-- Module Name:    MUX - Structural 
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
library STD;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MUX is
    Port ( op : in  STD_LOGIC_VECTOR (5 downto 0);
			  addSub : in  STD_LOGIC_VECTOR (15 downto 0);
			  mul : in  STD_LOGIC_VECTOR (15 downto 0);
			  div : in  STD_LOGIC_VECTOR (15 downto 0);
			  log : in  STD_LOGIC_VECTOR (15 downto 0);
           output : out  STD_LOGIC_VECTOR (15 downto 0));
end MUX;

architecture structural of MUX is

component and4_16
port(
    in1     :   in  std_logic;
    in2     :   in  std_logic;
	 in3     :   in  std_logic;
	 in4     :   in  std_logic_vector(15 downto 0);
    out1    :   out std_logic_vector(15 downto 0));
end component;

component or4_16
port(
	 in1     :   in  std_logic_vector(15 downto 0);
	 in2     :   in  std_logic_vector(15 downto 0);
	 in3     :   in  std_logic_vector(15 downto 0);
	 in4     :   in  std_logic_vector(15 downto 0);
    out1    :   out std_logic_vector(15 downto 0));
end component;

component inverter
port(
    in1     :   in  std_logic;
    out1    :   out std_logic);
end component;

signal n_in5, n_in4, n_in3: std_logic;
signal temp4, temp3, temp2, temp1: std_logic_vector(15 downto 0);

begin

inv1: inverter port map(op(5), n_in5);
inv2: inverter port map(op(4), n_in4);
inv3: inverter port map(op(3), n_in3);


and4_16_1: and4_16 port map (n_in5, n_in4, op(3), addSub, temp1);
and4_16_2: and4_16 port map (n_in5, op(4), n_in3, mul, temp2);
and4_16_3: and4_16 port map (n_in5, op(4), op(3), div, temp3);
and4_16_4: and4_16 port map (op(5), n_in4, n_in3, log, temp4);

or4_16_1: or4_16 port map (temp1, temp2, temp3, temp4, output);

end Structural;

