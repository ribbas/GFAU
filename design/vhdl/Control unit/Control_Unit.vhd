
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;



entity Control_Unit is
    Port ( 
    		clk : in STD_LOGIC; -- clock for counter 
			op : in STD_LOGIC_VECTOR (5 downto 0);  -- input to control unit (op code)
			m1 : in  STD_LOGIC_VECTOR (15 downto 0); -- input to control unit (first operand) 
         m2 : in  STD_LOGIC_VECTOR (15 downto 0); -- input to control unit (second opernd)
         m : INOUT STD_LOGIC_VECTOR (15 downto 0); -- bidirectional bus for accessing memory 
		   gen_term : out STD_LOGIC; -- poly generation
		    enable : out STD_LOGIC; -- enable demux to enable memory 
		    sel : out STD_LOGIC; -- select the correct memory chip 
		    m1_out : out STD_LOGIC_VECTOR (15 downto 0); -- converted value for m1 
		    m2_out : out STD_LOGIC_VECTOR (15 downto 0); -- converted valued for m2 
			 A       :   out      std_logic_vector(15 downto 0);
        nADSP   :   out      std_logic;
        nADSC   :   out      std_logic;
        nADV    :   out      std_logic;
        nBW     :   out      std_logic_vector(3 downto 0);
        nBWE    :   out      std_logic;
        nGW     :   out      std_logic;
        nCE     :   out      std_logic;
        nCE2    :   out      std_logic;
        CE2     :   out      std_logic;
        nOE     :   out      std_logic;
        DQ      :   inout   std_logic_vector(31 downto 0);
        MODE    :   out      std_logic;
        ZZ      :   out      std_logic
		
	);
end Control_Unit;


architecture structural of Control_Unit is

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

signal counter : std_logic_vector(0 to 2):="000";

begin

	--variable rst : STD_LOGIC := '0';
	--variable convert : boolean := false;
	--variable input_type : STD_LOGIC := '0';
	
	
	
	process(op,clk) begin
	--variable counter : STD_LOGIC := '0';

	if(rising_edge(clk))then
	
	
		counter <= counter + 1;
	end if;
	
	
	
	case op (5 downto 3) is 
		
		
			
		
		when "000" => 
		
		gen_term <= '1';
		
		m<="UUUUUUUUUUUUUUUU";
		
		
		when "001" | "010" | "011" | "100" => --add,sub,mul,div
		
	
			
		if counter = "100" then -- reset counter 
				counter <= "000";
		end if;
			
			-- memory control signal for write 
		nCE <= '0';
		nCE2 <= '0';
		CE2 <= '1';
		ZZ <= '0';
		nADSP <= '1';
		nADSC <= '0';
		nBWE <= '0';
			
			
		enable <= '1';--enable MUX
			gen_term <= '0';
			
			if counter = 1 then -- set output m1_out to converted value  
					m1_out <= m;
				else
					m1_out <= "UUUUUUUUUUUUUUUU";
				
				end if;
				
			if counter = 3 then -- set ouput m2_out to conerted value
					m2_out <= m;
				else
					m2_out <= "UUUUUUUUUUUUUUUU";
				
				end if;
			
			
			
			
			
			if (counter = 0) or (counter = 1) or (counter = 4) then-- first two cycles for m1 
			
				
			
				m <= m1;
				if op(2) = '0' then -- If m1 is in exponent form 
					sel <= '0'; -- select mem1 to convert from exponent to polynomial 
					
				
				else
					sel <= '1'; -- select mem2 to convert from polynomial to exponent 
					
				end if;
			
			elsif (counter = 2) or (counter = 3) then -- second two cycles for m2 
				
				
			
				m <= m2;
				if op(1) = '0' then -- If m2 is in exponent form  
					sel <= '0'; -- select mem2 to convert from exponent to polynomial 
				else 
					sel <= '1'; -- select mem1 to convert from polynomial to exponent 
				end if;
			end if;
			
			
		
		when others => 
		gen_term <= '0';
		enable <= '0';
		m<="UUUUUUUUUUUUUUUU";
	
	end case;
	
	end process;


	
	
			


end structural;

