
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity Control_Unit is
    Port ( 
    		clk : in STD_LOGIC; -- clock for counter 
			op : in STD_LOGIC_VECTOR (5 downto 0);  -- input to control unit (op code)
			m1 : in  STD_LOGIC_VECTOR (15 downto 0); -- input to control unit (first operand) 
            m2 : in  STD_LOGIC_VECTOR (15 downto 0); -- input to control unit (second opernd)
            m : INOUT STD_LOGIC_VECTOR (15 downto 0); -- bidirectional bus for accessing memory 
		    gen_term : out STD_LOGIC; -- output from control unit 
		    enable : out STD_LOGIC; -- enable demux to enable memory 
		    sel : out STD_LOGIC; -- select the correct memory chip 
		    m1_out : out STD_LOGIC_VECTOR (15 downto 0);
		    m2_out : out STD_LOGIC_VECTOR (15 downto 0)
		
	);
end Control_Unit;


architecture structural of Control_Unit is

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

signal s_A      :   std_logic_vector(15 downto 0);
signal s_clk    :   std_logic := '0';
signal s_nADSP  :   std_logic;
signal s_nADSC  :   std_logic;
signal s_nADV   :   std_logic;
signal s_nBW    :   std_logic_vector(3 downto 0);
signal s_nBWE   :   std_logic;
signal s_nGW    :   std_logic;
signal s_nCE    :   std_logic;
signal s_nCE2   :   std_logic;
signal s_CE2    :   std_logic;
signal s_nOE    :   std_logic;
signal s_DQ     :   std_logic_vector(31 downto 0);
signal s_MODE   :   std_logic;
signal s_ZZ     :   std_logic;


begin
	
	
	
	--variable rst : STD_LOGIC := '0';
	--variable convert : boolean := false;
	--variable input_type : STD_LOGIC := '0';
	
	
	--load memory 

	
	s_A <= "0000000000000000";
	s_nADSP <= '1';
	s_nCE <= '0';
	s_nCE2 <= '0';
	s_CE2 <= '1';
	s_ZZ <= '0';
	s_nADSC <= '0';
	s_nBWE <= '0';
	

	a : for i in 0 to 65535 generate
		
		mem : mem1 port map(i,s_clk,s_nADSP,s_nADSC,s_nADV,s_nBW,s_nBWE,s_nGW,s_nCE,s_nCE2,s_CE2,s_nOE,s_DQ,s_MODE,s_ZZ);
	end generate a;
	
	
	
	
	
	
	
--	gen_term <= '0';
--	enable <= '0';
--	case op (5 downto 3)  is
--
--		when "000" => gen_term <= '1'; -- op[5:3] = 000 
--		when "001" => -- op[5:3] = 001, add/sub
--			if op(2) = '0' then
--				
--				--mem1 : mem1 port map(A(m1),clk(clk),nADSP(1),nADSC(0),nADV(),nBW(000),nBWE(0),nGW(0),nCE(0),nCE2(0),CE2(1),nOE(0),DQ(0),MODE(0),ZZ(0));
--
--				--enable <= '1';
--				--sel <= '0';
--			end if;
--		when "010" => -- op[5:3] = 010, mul
--			if op(2) = '1' then 
--				enable <= '1';
--				sel <= '1';
--			end if;
--		when "011" => -- op[5:3] = 011, div 
--			if op(2) = '1' then 
--				enable <= '1';
--				sel <= '1';
--			end if;
--		when "100" => -- op[5:3] = 100, log 
--			if op(2) = '1' then
--				enable <= '1';
--				sel <= '1';
--			end if;
--
--
--		when others => gen_term <= '0';
--
--	end case;


	
	
			


end structural;

