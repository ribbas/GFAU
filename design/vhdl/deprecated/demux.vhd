
-- demux.vhd

-- Sabbir Ahmed
-- 2018-01-14


----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:48:31 11/05/2017 
-- Design Name: 
-- Module Name:    demux - Behavioral 
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

