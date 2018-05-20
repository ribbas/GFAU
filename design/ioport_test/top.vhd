----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:46:26 05/18/2018 
-- Design Name: 
-- Module Name:    top - Behavioral 
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

entity top is
port (
    io_bus  : inout STD_LOGIC_VECTOR (7 downto 0);
    oe      : in    STD_LOGIC;
    clk     : in    STD_LOGIC;
    result_out  :   out std_logic_vector(7 downto 0);
    dbg     : out   std_logic_vector(7 downto 0);
    wr      : in    STD_LOGIC
);
end top;

architecture Behavioral of top is

    component io_port
    port(
        op      :   in      std_logic_vector(7 downto 0);  --out to pad
        oe      :   in      std_logic;                     --enable pad output
        ip      :   out     std_logic_vector(7 downto 0);  --in from pad
        pad     :   inout   std_logic_vector(7 downto 0)   --external io pad
    );
    end component;
    
    signal test     :   std_logic_vector(7 downto 0) := "00000000";
    signal ntest    :   std_logic_vector(7 downto 0);
    
    signal ip       :   std_logic_vector(7 downto 0);
    
begin

    ntest <= not test;
    result_out <= test;
    dbg <= io_bus;

    p   :   process(clk)
    begin
        if(falling_edge(clk)) then
            if (wr = '1' and oe = '0') then
                test <= ip;
            end if;
        end if;
    end process p;
                
    io  :   io_port port map(
        op  => ntest,
        oe  => oe,
        ip  => ip,
        pad => io_bus
    );
        
end Behavioral;

