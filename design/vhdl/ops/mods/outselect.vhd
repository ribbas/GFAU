library std;
library ieee;
use ieee.std_logic_1164.all;

entity outselect is
    port( 
        opcode      : in std_logic_vector(5 downto 0);
        addsubop    : in std_logic_vector(15 downto 0);
        mulop       : in std_logic_vector(15 downto 0);
        divop       : in std_logic_vector(15 downto 0);
        logop       : in std_logic_vector(15 downto 0);
        sel_out     : out std_logic_vector(15 downto 0);
        memselect   : out std_logic;
        convert     : out std_logic
    );
end outselect;

architecture behavioral of outselect is

begin

    process (opcode) begin

        case opcode(2 downto 0) is

            when "000" | "111" =>
                convert <= '1';

            when others =>
                convert <= '0';

        end case;

        case opcode(5 downto 3) is

            when "001" =>
                sel_out <= addsubop;

            when "010" =>
                sel_out <= mulop;

            when "011" =>
                sel_out <= divop;

            when "100" =>
                sel_out <= logop;

            when others =>
                sel_out <= "XXXXXXXXXXXXXXXX";

        end case;

    end process;
     
end behavioral;

