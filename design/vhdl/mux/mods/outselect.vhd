library std;
library ieee;
use ieee.std_logic_1164.all;

entity outselect is
    port( 
        op          : in std_logic_vector (5 downto 0);
        addsubop    : in std_logic_vector (15 downto 0);
        mulop       : in std_logic_vector (15 downto 0);
        divop       : in std_logic_vector (15 downto 0);
        logop       : in std_logic_vector (15 downto 0);
        sel         : out std_logic_vector (15 downto 0);
        memselect   : out std_logic;
        convert     : out std_logic
    );
end outselect;

architecture behavioral of outselect is

begin

with op select
    convert <= '1' when "---000",
	 '1' when "---111",
	 '0' when others;

with op select
    sel <= addsubop when "001---",
	 mulop when "010---",
	 divop when "011---",
	 logop when "100---";
	 
end behavioral;

