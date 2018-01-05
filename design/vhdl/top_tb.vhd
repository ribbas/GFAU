library ieee;
use ieee.std_logic_1164.all;
 
entity top_tb is
end top_tb;
 
architecture behavior of top_tb is 
 
    component top
        port(
            op : in  std_logic_vector(5 downto 0);
            m1 : in  std_logic_vector(15 downto 0);
            m2 : in  std_logic_vector(15 downto 0);
            m1_out : out  std_logic_vector(15 downto 0);
            m2_out : out  std_logic_vector(15 downto 0)
        );
    end component;

    --inputs
    signal op : std_logic_vector(5 downto 0) := (others => '0');
    signal m1 : std_logic_vector(15 downto 0) := (others => '0');
    signal m2 : std_logic_vector(15 downto 0) := (others => '0');

    --outputs
    signal m1_out : std_logic_vector(15 downto 0);
    signal m2_out : std_logic_vector(15 downto 0);
    -- no clocks detected in port list. replace <clock> below with 
    -- appropriate port name 

    constant <clock>_period : time := 10 ns;
 
begin
 
    -- instantiate the unit under test (uut)
    uut: top port map (
        op => op,
        m1 => m1,
        m2 => m2,
        m1_out => m1_out,
        m2_out => m2_out
    );

    -- clock process definitions
    <clock>_process :process
        begin
        <clock> <= '0';
        wait for <clock>_period/2;
        <clock> <= '1';
        wait for <clock>_period/2;
    end process;


    -- stimulus process
    stim_proc: process
        begin    
        -- hold reset state for 100 ns.
        wait for 100 ns;  

        wait for <clock>_period*10;

        -- insert stimulus here 

        wait;

    end process;

end;
