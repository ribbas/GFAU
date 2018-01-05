
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

 
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
         m2_out : OUT  std_logic_vector(15 downto 0);
         A : OUT  std_logic_vector(15 downto 0);
         nADSP : OUT  std_logic;
         nADSC : OUT  std_logic;
         nADV : OUT  std_logic;
         nBW : OUT  std_logic_vector(3 downto 0);
         nBWE : OUT  std_logic;
         nGW : OUT  std_logic;
         nCE : OUT  std_logic;
         nCE2 : OUT  std_logic;
         CE2 : OUT  std_logic;
         nOE : OUT  std_logic;
         DQ : INOUT  std_logic_vector(31 downto 0);
         MODE : OUT  std_logic;
         ZZ : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal op : std_logic_vector(5 downto 0) := (others => '0');
   signal m1 : std_logic_vector(15 downto 0) := (others => '0');
   signal m2 : std_logic_vector(15 downto 0) := (others => '0');

	--BiDirs
   signal m : std_logic_vector(15 downto 0);
   signal DQ : std_logic_vector(31 downto 0);

 	--Outputs
   signal gen_term : std_logic;
   signal enable : std_logic;
   signal sel : std_logic;
   signal m1_out : std_logic_vector(15 downto 0);
   signal m2_out : std_logic_vector(15 downto 0);
   signal A : std_logic_vector(15 downto 0);
   signal nADSP : std_logic;
   signal nADSC : std_logic;
   signal nADV : std_logic;
   signal nBW : std_logic_vector(3 downto 0);
   signal nBWE : std_logic;
   signal nGW : std_logic;
   signal nCE : std_logic;
   signal nCE2 : std_logic;
   signal CE2 : std_logic;
   signal nOE : std_logic;
   signal MODE : std_logic;
   signal ZZ : std_logic;

   -- Clock period definitions
   --constant clk_period : time := 10 ns;
 
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
          m2_out => m2_out,
          A => A,
          nADSP => nADSP,
          nADSC => nADSC,
          nADV => nADV,
          nBW => nBW,
          nBWE => nBWE,
          nGW => nGW,
          nCE => nCE,
          nCE2 => nCE2,
          CE2 => CE2,
          nOE => nOE,
          DQ => DQ,
          MODE => MODE,
          ZZ => ZZ
        );

   -- Clock process definitions
   clock :process
   begin
		clk <= '0';
		
		wait for 50 ns;
		clk <= '1';
		wait for 50 ns;
   end process;
 

   -- Stimulus process
  test: process
   begin		
	
	
     --op <= "000000"; -- generate terms
     --wait for 400 ns;	
		
	  op <= "001010"; -- add/sub, m1, m2 exponent  
	  m1 <= "1010101010101010";
	  m2 <= "0101010101010101";
	  wait for 400 ns;
	  
	  op <= "010000";
	  m1 <= "1111111111111111";
	  m2 <= "0000000000000000";
	  wait for 400 ns;
	  
		wait;
	  

   end process;

END;
