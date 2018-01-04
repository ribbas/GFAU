
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use IEEE.std_logic_textio.all;
use IEEE.numeric_std.all;
use STD.textio.all;

 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY Control_Unit_tb IS
END Control_Unit_tb;
 
ARCHITECTURE behavior OF Control_Unit_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Control_Unit
    PORT(
         clk : IN  std_logic;
         op : IN  std_logic_vector(5 downto 0);
         m1 : IN  std_logic_vector(15 downto 0);
         m2 : IN  std_logic_vector(15 downto 0);
         m : INOUT  std_logic_vector(15 downto 0);
         gen_term : OUT  std_logic;
         enable : OUT  std_logic;
         sel : OUT  std_logic;
         m1_out : OUT  std_logic_vector(15 downto 0);
         m2_out : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
	 
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
    

   --Inputs
   signal clk : std_logic := '0';
   signal op : std_logic_vector(5 downto 0) := (others => '0');
   signal m1 : std_logic_vector(15 downto 0) := (others => '0');
   signal m2 : std_logic_vector(15 downto 0) := (others => '0');

	--BiDirs
   signal m : std_logic_vector(15 downto 0);

 	--Outputs
   signal gen_term : std_logic;
   signal enable : std_logic;
   signal sel : std_logic;
   signal m1_out : std_logic_vector(15 downto 0);
   signal m2_out : std_logic_vector(15 downto 0);
   
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
signal s_DQ     :   std_logic_vector(31 downto 0):="00000000000000000000000000000000";
signal s_MODE   :   std_logic;
signal s_ZZ     :   std_logic;
 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Control_Unit PORT MAP (
          clk => clk,
          op => op,
          m1 => m1,
          m2 => m2,
          m => m,
          gen_term => gen_term,
          enable => enable,
          sel => sel,
          m1_out => m1_out,
          m2_out => m2_out
        );

 

    clock : process
	 begin

       clk <= '0';
		 wait for 50 ns;
		 clk<='1';
		 wait for 50 ns;
		
    end process;

   -- Stimulus process
   test: process
	
        --file infile         :   text is in "input.txt";
        file outfile        :   text is out "output.txt";
        variable buf        :   line;
        variable v_A        :   std_logic_vector(15 downto 0);
        variable v_clk      :   std_logic;
        variable v_nADSP    :   std_logic;
        variable v_nADSC    :   std_logic;
        variable v_nADV     :   std_logic;
        variable v_nBW      :   std_logic_vector(3 downto 0);
        variable v_nBWE     :   std_logic;
        variable v_nGW      :   std_logic;
        variable v_nCE      :   std_logic;
        variable v_nCE2     :   std_logic;
        variable v_CE2      :   std_logic;
        variable v_nOE      :   std_logic;
        variable v_DQ       :   std_logic_vector(31 downto 0);
        variable v_MODE     :   std_logic;
        variable v_ZZ       :   std_logic;
        variable counter    :   integer := 0;

   begin		
	
  
  
 
  
  
	
	s_clk <= clk;
	s_A <= "0000000000000000";
	s_nADSP <= '1';
	s_nCE <= '0';
	s_nCE2 <= '0';
	s_CE2 <= '1';
	s_ZZ <= '0';
	s_nADSC <= '0';
	s_nBWE <= '0';
	--s_DQ <= "11111111111111111111111111111111";
	
	
	--mem : mem1 port map(s_A,s_clk,s_nADSP,s_nADSC,s_nADV,s_nBW,s_nBWE,s_nGW,s_nCE,s_nCE2,s_CE2,s_nOE,s_DQ,s_MODE,s_ZZ);
		--for i in 0 to 65535 loop
		--s_A <= std_logic_vector(to_unsigned(i,16));
		--mem : mem1 port map(s_A,s_clk,s_nADSP,s_nADSC,s_nADV,s_nBW,s_nBWE,s_nGW,s_nCE,s_nCE2,s_CE2,s_nOE,s_DQ,s_MODE,s_ZZ);
		
	--end loop;


	for i in 0 to 65535 loop
		
		wait until rising_edge (clk);
		s_DQ <= std_logic_vector(to_unsigned(i,32));
		
		write(buf,s_DQ);
		writeline(outfile,buf);
	
	end loop;
		

	
		
	end process;
		
		
  
	
	

END;
