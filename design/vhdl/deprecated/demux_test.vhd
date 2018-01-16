-- demux_test.vhd
--
-- Howard To
-- 2018-01-16
--

--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   21:18:44 11/12/2017
-- Design Name:   
-- Module Name:   E:/Unit_Control/demux_test.vhd
-- Project Name:  Unit_Control
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: demux
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY demux_test IS
END demux_test;
 
ARCHITECTURE behavior OF demux_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT demux
    PORT(
         sel : IN  std_logic;
         enable : IN  std_logic;
         mem1 : OUT  std_logic;
         mem2 : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal sel : std_logic := '0';
   signal enable : std_logic := '0';

 	--Outputs
   signal mem1 : std_logic;
   signal mem2 : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 

BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: demux PORT MAP (
          sel => sel,
          enable => enable,
          mem1 => mem1,
          mem2 => mem2
        );



   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

		enable <= '0'; sel <= '0';
		wait for 100 ns;
		enable <= '0'; sel <= '1';
		wait for 100 ns;
		enable <= '1'; sel <= '0';
		wait for 100 ns;
		enable <= '1'; sel <= '1';
		wait for 100 ns;
 
      -- insert stimulus here 

      wait;
   end process;

END;
