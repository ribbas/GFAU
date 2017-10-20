library STD;
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;
use STD.textio.all;

entity reducable16_test is

end reducable16_test;

architecture test of reducable16_test is

component reducable16 is
port (
    inp     :   in  std_logic_vector(15 downto 0);
    out1    :   out std_logic);
end component;

signal s_inp    :   std_logic_vector(15 downto 0);
signal s_out1   :   std_logic;

begin

    r16 :   reducable16 port map(s_inp, s_out1);

    process

        file infile     :   text is in "input.txt";
        file outfile    :   text is out "output.txt";
        variable v_inp  :   std_logic_vector(15 downto 0);
        variable v_out1 :   std_logic;
        variable buf    :   line;

    begin

        while not (endfile(infile)) loop

            readline(infile, buf);
            read(buf, v_inp);
            s_inp <= v_inp;
            wait for 1 fs;
            v_out1 := s_out1;
            write(buf, v_out1);
            writeline(outfile, buf);

        end loop;
        wait;
    end process;
end test;
 
