-- outfilter.vhd
--
-- Sabbir Ahmed
-- 2018-02-14
--
-- Multiplexer to convert the result of the operations and look up their
-- conversions in the other forms.
--

library std;
library ieee;
use ieee.std_logic_1164.all;

entity outfilter is
    port(
        opcode  : in std_logic_vector(5 downto 0);
        out_as  : in std_logic_vector(15 downto 0);
        out_m   : in std_logic_vector(15 downto 0);
        out_d   : in std_logic_vector(15 downto 0);
        out_l   : in std_logic_vector(15 downto 0);
        i_null  : in std_logic;
        j_null  : in std_logic;
        mask    : in std_logic_vector(15 downto 0);
        mem_id  : inout std_logic_vector(1 downto 0);
        mem_t   : out std_logic;
        err_z   : out std_logic;
        result  : out std_logic_vector(15 downto 0)
    );
end outfilter;

architecture behavioral of outfilter is

    type state_type is (init_state, flush_state);  -- define the states
    signal state : state_type;

begin

    process (opcode, out_as, out_m, out_d, out_l, i_null, j_null) begin

        if (en = '1') then

            mem_id <= "10";  -- memory ID for outfilter

            if rising_edge(clk) then  -- if there is a rising edge

                case state is

                    when init_state =>

                        case opcode(5 downto 3) is  -- first 3 bits

                            -- add / sub
                            when "001" =>

                                -- add / sub output is selected

                                -- add / sub never throws a zero exception
                                err_z <= '0';

                                -- if output is requested in element form
                                if (opcode(0) = '0') then

                                    -- convert to';
                                    mem_t <= opcode(0);

                                else

                                    mem_t <= 'X';

                                end if;

                            -- mul
                            when "010" =>

                                -- mul never throws a zero exception
                                err_z <= '0';

                                -- if both non-null operands
                                if (i_null = '0' and j_null = '0') then

                                    -- mul output is selected

                                    -- if output is requested in polynomial form
                                    if (opcode(0) = '1') then

                                        -- convert to element form
                                        mem_t <= opcode(0);

                                    else

                                        mem_t <= 'X';

                                    end if;

                                -- if any of the operands are null
                                elsif (i_null = '1' or j_null = '1') then

                                    -- null (in element form) is selected
                                    result <= "1111111111111111";

                                end if;

                            -- div
                            when "011" =>

                                -- if both non-null operands
                                if (i_null = '0' and j_null = '0') then

                                    -- div output is selected
                                    err_z <= '0';

                                    -- if output is requested in polynomial form
                                    if (opcode(0) = '1') then

                                        -- convert to element form
                                        mem_t <= opcode(0);

                                    else

                                        mem_t <= 'X';

                                    end if;

                                -- if divide by null is attempted
                                elsif (j_null = '1') then

                                    -- throw divide by zero exception
                                    err_z <= '1';
                                    result <= "XXXXXXXXXXXXXXXX";

                                -- if dividing null is attempted
                                elsif (i_null = '1' and j_null = '0') then

                                    err_z <= '0';
                                    result <= "1111111111111111";

                                end if;

                            -- log
                            when "100" =>

                                -- if non-null operand
                                if (i_null <= '0') then

                                    -- log output is selected
                                    err_z <= '0';

                                    -- if output is requested in polynomial form
                                    if (opcode(0) = '1') then

                                        mem_t <= opcode(0);

                                    else

                                        mem_t <= 'X';

                                    end if;

                                -- if log of null is attempted
                                elsif (i_null <= '1') then

                                    -- throw zero exception
                                    err_z <= '1';
                                    result <= "XXXXXXXXXXXXXXXX";

                                end if;

                            when others =>

                                err_z <= '0';
                                mem_t <= 'X';
                                result <= "XXXXXXXXXXXXXXXX";

                        end case;

                    when final_state =>

                        

                    when others =>

                        mem_t => 'X';

                    end case;

            else
                mem_t <= '0';
            end if;

        else

            mem_id <= "ZZ";  -- set high impedence to disable output
            mem_t <= 'X';
            err_z <= '0';
            result <= "XXXXXXXXXXXXXXXX";

        end if;

    end process;

end behavioral;
