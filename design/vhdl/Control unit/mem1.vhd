library STD;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;


entity mem1 is
    Port ( 
    	
    A       :   in      std_logic_vector(15 downto 0); --
    clk     :   in      std_logic; -- synchronous clk
    nADSP   :   in      std_logic; -- synchronous processor address status 
    nADSC   :   in      std_logic; -- synchronous controller address status
    nADV    :   in      std_logic; -- synchronous burst address advance 
    nBW     :   in      std_logic_vector(3 downto 0); -- individual byte write enable 
    nBWE    :   in      std_logic; -- synchronous byte write enable 
    nGW     :   in      std_logic; -- synchronous global write enable 
    nCE     :   in      std_logic; -- synchronous chip enable 
    nCE2    :   in      std_logic; -- 
    CE2     :   in      std_logic;
    nOE     :   in      std_logic; --output enable 
    DQ      :   inout   std_logic_vector(31 downto 0); -- synchronous data input/output
    MODE    :   in      std_logic; -- burst sequence mode selection 
    ZZ      :   in      std_logic); -- snooze enabl 
end mem1;

architecture Behavioral of mem1 is

	type memory is array (65535 downto 0) of std_logic_vector (31 downto 0);
	signal MEM : memory;
	signal nWRITE : std_logic;


begin

	nWRITE <= (not nBWE) or (not nBW(0)) or (not nBW(1)) or (not nBW(2)) or (not nBW(3));
	main : process(clk)

	begin 

		if(rising_edge(clk)) then
            if nCE = '1' and ZZ = '0' and nADSC = '1' then
                DQ <= "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ";
            elsif nCE = '0' and CE2 = '0'  and ZZ = '0' and nADSP = '0' then
                DQ <= "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ";
            elsif nCE = '0' and nCE2 = '1'  and ZZ = '0' and nADSP = '0' then
                DQ <= "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ"; 
            elsif nCE = '0' and CE2 = '0'  and ZZ = '0' and nADSP = '1' and nADSC = '0' then
                DQ <= "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ"; 
            elsif nCE = '0' and CE2 = '1'  and ZZ = '0' and nADSP = '1' and nADSC = '0'then
                DQ <= "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ"; 
            elsif ZZ = '1' then
                DQ <= "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ"; 
            elsif nCE = '0' and nCE2='0' and CE2='1' and ZZ = '0' and nADSP = '0' and nOE = '0' then
                DQ <= MEM(to_integer(unsigned(A)));
            elsif nCE = '0' and nCE2='0' and CE2='1' and ZZ = '0' and nADSP = '0' and nOE = '1' then
                DQ <= "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ"; 
            elsif nCE = '0' and nCE2='0' and CE2='1' and ZZ = '0' and nADSP = '1' and nADSC = '0' and nWRITE = '0' then
                MEM(to_integer(unsigned(A))) <= DQ;
            elsif nCE = '0' and nCE2='0' and CE2='1' and ZZ = '0' and nADSP = '1' and nADSC = '0' and nWRITE = '1' and nOE = '0' then
                DQ <= MEM(to_integer(unsigned(A)));
            elsif nCE = '0' and nCE2='0' and CE2='1' and ZZ = '0' and nADSP = '1' and nADSC = '0' and nWRITE = '1' and nOE = '1' then
                DQ <= "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ"; 
            else
                DQ <= "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ";
            end if;
        end if;



	end process; 


end Behavioral;

