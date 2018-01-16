-- outselect.vhd
--
-- Sabbir Ahmed, Jeffrey Osazuwa
-- 2018-01-16
--
-- Multiplexer to select the operator's output as the result.
--

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
        mem_t       : out std_logic;
        convert     : out std_logic
    );
end outselect;

architecture behavioral of outselect is

begin

    process (opcode, addsubop, mulop, divop, logop) begin

        case opcode(5 downto 3) is  -- first 3 bits

            when "001" =>

                sel_out <= addsubop;

                -- if output is requested in element form
                if (opcode(0) = '0') then

                    -- convert to polynomial form
                    convert <= '1';
                    mem_t <= opcode(0);

                else

                    convert <= '0';
                    mem_t <= 'X';

                end if;

            when "010" =>

                sel_out <= mulop;

                -- if output is requested in polynomial form
                if (opcode(0) = '1') then

                    -- convert to element form
                    convert <= '1';
                    mem_t <= opcode(0);

                else

                    convert <= '0';
                    mem_t <= 'X';

                end if;

            when "011" =>

                sel_out <= divop;

                -- if output is requested in polynomial form
                if (opcode(0) = '1') then

                    convert <= '1';
                    mem_t <= opcode(0);

                else

                    convert <= '0';
                    mem_t <= 'X';

                end if;

            when "100" =>

                sel_out <= logop;

                -- if output is requested in polynomial form
                if (opcode(0) = '1') then

                    convert <= '1';
                    mem_t <= opcode(0);

                else

                    convert <= '0';
                    mem_t <= 'X';

                end if;

            when others =>

                convert <= '0';
                mem_t <= 'X';
                sel_out <= "XXXXXXXXXXXXXXXX";

        end case;

    end process;
     
end behavioral;
