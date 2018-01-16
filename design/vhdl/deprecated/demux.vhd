-- demux.vhd
--
-- Howard To
-- 2018-01-16
--

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity demux is

port(
	
	sel : in STD_LOGIC;
	enable : in STD_LOGIC;
	mem1 : out STD_LOGIC;
	mem2 : out STD_LOGIC);
	
end demux;

architecture behavior of demux is

begin
	mem1 <= enable and (not sel);
	mem2 <= enable and sel;

end behavior;

