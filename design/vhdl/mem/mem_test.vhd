
-- mem_test.vhd

-- Sabbir Ahmed
-- 2018-01-14


library STD;
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;
use IEEE.numeric_std.all;
use STD.textio.all;

entity mem_test is

end mem_test;

architecture test of mem_test is

component IS61LP6432A is
    port (
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

    mem : IS61LP6432A port map(
        A       => s_A,
        clk     => s_clk,
        nADSP   => s_nADSP,
        nADSC   => s_nADSC,
        nADV    => s_nADV,
        nBW     => s_nBW,
        nBWE    => s_nBWE,
        nGW     => s_nGW,
        nCE     => s_nCE,
        nCE2    => s_nCE2,
        CE2     => s_CE2,
        nOE     => s_nOE,
        DQ      => s_DQ,
        MODE    => s_MODE,
        ZZ      => s_ZZ
    );

    clock : process 

    begin

        s_clk <= not s_clk after 10 ns;

    end process;

    test : process

        file infile         :   text is in "input.txt";
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

        while not (endfile(infile)) loop

            if (rising_edge(s_clk)) then

                readline(infile, buf);

                read(buf, v_DQ);
                s_DQ <= v_DQ;

                s_nCE <= '0';
                s_nCE2 <= '0';
                s_ZZ <= '0';
                s_nADSC <= '0';
                s_nBWE <= '0';
                s_CE2 <= '1';
                s_nADSP <= '1';
                s_A <= std_logic_vector(to_unsigned(counter, 16));

                counter := counter + 1;

            end if;

        end loop;

        for i in 0 to counter loop

            wait until rising_edge(s_clk);
            s_nCE <= '0';
            s_nCE2 <= '0';
            s_ZZ <= '0';
            s_nADSP <= '0';
            s_nOE <= '0';
            s_CE2 <= '1';

            wait for 1 fs;
            v_DQ := s_DQ;
            write(buf, v_DQ);
            writeline(outfile, buf);

        end loop;

        wait;

    end process;

end test;

