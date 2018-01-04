
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;


entity Top is
	port(
		op : in STD_LOGIC_VECTOR(5 downto 0);
		m1 : in STD_LOGIC_VECTOR (15 downto 0);
		m2 : in STD_LOGIC_VECTOR (15 downto 0);
		m1_out : out STD_LOGIC_VECTOR (15 downto 0);
		m2_out : out STD_LOGIC_VECTOR (15 downto 0)
	
	
	);
end Top;

architecture Behavioral of Top is

component mem1
		port(
			A       :   in      std_logic_vector(15 downto 0);
        clk     :   in      std_logic;
        nADSP   :   in      std_logic;
        nADSC   :   in      std_logic;
        nADV    :   in      std_logic;
        nBW     :   in      std_logic_vector(3 downto 0);
        nBWE    :   in      std_logic;
        nGW     :   in      std_logic;
        nCE     :   in      std_logic;
        nCE2    :   in      std_logic;
        CE2     :   in      std_logic;
        nOE     :   in      std_logic;
        DQ      :   inout   std_logic_vector(31 downto 0);
        MODE    :   in      std_logic;
        ZZ      :   in      std_logic

			);
	end component;
	
	component mem2
		port(
				A       :   in      std_logic_vector(15 downto 0);
        clk     :   in      std_logic;
        nADSP   :   in      std_logic;
        nADSC   :   in      std_logic;
        nADV    :   in      std_logic;
        nBW     :   in      std_logic_vector(3 downto 0);
        nBWE    :   in      std_logic;
        nGW     :   in      std_logic;
        nCE     :   in      std_logic;
        nCE2    :   in      std_logic;
        CE2     :   in      std_logic;
        nOE     :   in      std_logic;
        DQ      :   inout   std_logic_vector(31 downto 0);
        MODE    :   in      std_logic;
        ZZ      :   in      std_logic

			);
	end component;
	


begin




end Behavioral;

