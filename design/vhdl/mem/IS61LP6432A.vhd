-- IS61LP6432A.vhd
--
-- Brian Weber
-- 2018-01-16
--
--
--

library std;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- read:
--  nCE     = 0
--  nCE2    = 0
--  CE2     = 1
--  ZZ      = 0
--  nADSP   = 0
--  nOE     = 0

-- write:
--  nCE     = 0
--  nCE2    = 0
--  CE2     = 1
--  ZZ      = 0
--  nADSP   = 1
--  nADSC   = 0
--  nWRITE  = 0


entity IS61LP6432A is

    port(
        A       : in std_logic_vector(15 downto 0);  -- address
        clk     : in std_logic;
        nADSP   : in std_logic;
        nADSC   : in std_logic;
        nADV    : in std_logic;
        nBW     : in std_logic_vector(3 downto 0);
        nBWE    : in std_logic;
        nGW     : in std_logic;
        nCE     : in std_logic;
        nCE2    : in std_logic;
        CE2     : in std_logic;
        nOE     : in std_logic;
        DQ      : inout std_logic_vector(31 downto 0);  -- data
        MODE    : in std_logic;
        ZZ      : in std_logic
    );

end IS61LP6432A;

architecture behavioral of IS61LP6432A is
    
    type memory is array (65535 downto 0) of std_logic_vector(31 downto 0);
    signal MEM      : memory;
    signal nWRITE   : std_logic;

begin

    nWRITE <= (not nBWE) or (not nBW(0)) or (not nBW(1)) or (not nBW(2)) 
        or (not nBW(3));
    main : process(clk)
    begin

        if (rising_edge(clk)) then

            if nCE = '1' and ZZ = '0' and nADSC = '1' then
                DQ <= "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ";

            elsif nCE = '0' and CE2 = '0' and ZZ = '0' and nADSP = '0' then
                DQ <= "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ";

            elsif nCE = '0' and nCE2 = '1' and ZZ = '0' and nADSP = '0' then
                DQ <= "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ";

            elsif nCE = '0' and CE2 = '0' and ZZ = '0' and nADSP = '1' and
                nADSC = '0' then
                DQ <= "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ";

            elsif nCE = '0' and CE2 = '1'  and ZZ = '0' and nADSP = '1' and
                nADSC = '0' then
                DQ <= "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ";

            elsif ZZ = '1' then
                DQ <= "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ";

            elsif nCE = '0' and nCE2 = '0' and CE2 = '1' and ZZ = '0' and
                nADSP = '0' and nOE = '0' then
                DQ <= MEM(to_integer(unsigned(A)));

            elsif nCE = '0' and nCE2 = '0' and CE2 = '1' and ZZ = '0' and
                nADSP = '0' and nOE = '1' then
                DQ <= "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ";

            elsif nCE = '0' and nCE2 = '0' and CE2 = '1' and ZZ = '0' and 
                nADSP = '1' and nADSC = '0' and nWRITE = '0' then
                MEM(to_integer(unsigned(A))) <= DQ;

            elsif nCE = '0' and nCE2 = '0' and CE2 = '1' and ZZ = '0' and 
                nADSP = '1' and nADSC = '0' and nWRITE = '1' and nOE = '0' then
                DQ <= MEM(to_integer(unsigned(A)));

            elsif nCE = '0' and nCE2 = '0' and CE2 = '1' and ZZ = '0' and 
                nADSP = '1' and nADSC = '0' and nWRITE = '1' and nOE = '1' then
                DQ <= "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ"; 

            else
                DQ <= "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ";

            end if;

        end if;

    end process;

end behavioral;
