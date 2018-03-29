-- outselect.vhd
--
-- Sabbir Ahmed
-- 2018-01-16
--
-- Multiplexer to select the operator's output as the result.
--

library std;
library ieee;
use ieee.std_logic_1164.all;

entity outselect is
    generic(
        n       : positive := 8
    );
    port(
        opcode  : in std_logic_vector(5 downto 0);
        out_as  : in std_logic_vector(n downto 0);
        out_m   : in std_logic_vector(n downto 0);
        out_d   : in std_logic_vector(n downto 0);
        out_l   : in std_logic_vector(n downto 0);
        i_null  : in std_logic;
        j_null  : in std_logic;
        out_sel : out std_logic_vector(n downto 0);
        mem_t   : out std_logic;
        convert : out std_logic;
        err_z   : out std_logic
    );
end outselect;

architecture behavioral of outselect is

    constant HIVEC : std_logic_vector(n downto 0) := (others => '1');
    constant DCAREVEC : std_logic_vector(n downto 0) := (others => '-');

begin

    process (opcode, out_as, out_m, out_d, out_l, i_null, j_null) begin

        case opcode(5 downto 3) is  -- first 3 bits

            -- add / sub
            when "001" =>

                -- add / sub output is selected
                out_sel <= out_as;

                -- add / sub never throws a zero exception
                err_z <= '0';

                -- if output is requested in element form
                if (opcode(0) = '0') then

                    -- convert to polynomial form
                    convert <= '1';
                    mem_t <= opcode(0);

                else

                    convert <= '0';
                    mem_t <= '-';

                end if;

            -- mul
            when "010" =>

                -- mul never throws a zero exception
                err_z <= '0';

                -- if both non-null operands
                if (i_null = '0' and j_null = '0') then

                    -- mul output is selected
                    out_sel <= out_m;

                    -- if output is requested in polynomial form
                    if (opcode(0) = '1') then

                        -- convert to element form
                        convert <= '1';
                        mem_t <= opcode(0);

                    else

                        convert <= '0';
                        mem_t <= '-';

                    end if;

                -- if any of the operands are null
                elsif (i_null = '1' or j_null = '1') then

                    -- null (in element form) is selected
                    out_sel <= HIVEC;

                end if;

            -- div
            when "011" =>

                -- if both non-null operands
                if (i_null = '0' and j_null = '0') then

                    -- div output is selected
                    out_sel <= out_d;
                    err_z <= '0';

                    -- if output is requested in polynomial form
                    if (opcode(0) = '1') then

                        -- convert to element form
                        convert <= '1';
                        mem_t <= opcode(0);

                    else

                        convert <= '0';
                        mem_t <= '-';

                    end if;

                -- if divide by null is attempted
                elsif (j_null = '1') then

                    -- throw divide by zero exception
                    err_z <= '1';
                    out_sel <= DCAREVEC;

                -- if dividing null is attempted
                elsif (i_null = '1' and j_null = '0') then

                    err_z <= '0';
                    out_sel <= HIVEC;

                end if;

            -- log
            when "100" =>

                -- if non-null operand
                if (i_null <= '0') then

                    -- log output is selected
                    out_sel <= out_l;
                    err_z <= '0';

                    -- if output is requested in polynomial form
                    if (opcode(0) = '1') then

                        convert <= '1';
                        mem_t <= opcode(0);

                    else

                        convert <= '0';
                        mem_t <= '-';

                    end if;

                -- if log of null is attempted
                elsif (i_null <= '1') then

                    -- throw zero exception
                    err_z <= '1';
                    out_sel <= DCAREVEC;

                end if;

            when others =>

                err_z <= '0';
                convert <= '0';
                mem_t <= '-';
                out_sel <= DCAREVEC;

        end case;

    end process;

end behavioral;
