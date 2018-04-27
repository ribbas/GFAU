-- outconvert.vhd
--
-- Sabbir Ahmed
-- 2018-01-16
--
-- Multiplexer to convert the result of the operations if necessary.
--

library ieee;
    use ieee.std_logic_1164.all;
library work;
    use work.demo.all;

entity outconvert is
    generic(
        n           : positive := DEGREE
    );
    port(
        clk         : in std_logic;

        convert     : in std_logic;  -- convert flag
        mask        : in std_logic_vector(n downto 0);  -- operand mask

        -- result
        out_sel     : in std_logic_vector(n downto 0);

        -- memory wrapper control signals
        id_con      : out std_logic;
        mem_rdy     : in std_logic;

        -- memory address and data signals
        addr_con    : out std_logic_vector(n downto 0);
        dout_con    : inout std_logic_vector(n downto 0) := HIIMPVEC;

        -- final output
        result      : out std_logic_vector(n downto 0)
    );
end outconvert;

architecture behavioral of outconvert is

    -- define the states for writing data
    signal state : rd_state_type;

begin

    process (clk, convert, mask, out_sel, mem_rdy, dout_con) begin

        if (rising_edge(clk)) then

            -- if conversion requested
            if (convert = '1') then

                case state is

                    -- send address to memory wrapper
                    when send_addr =>

                        -- read control signal with ID
                        id_con <= '1';

                        addr_con <= out_sel;
                        result <= HIIMPVEC;

                        state <= get_data;

                    when get_data =>

                        -- read control signal with ID
                        id_con <= '1';
                        addr_con <= out_sel;

                        if (mem_rdy = '1') then

                            result <= dout_con and mask;
                            --state <= send_addr;

                        else

                            result <= HIIMPVEC;
                            state <= get_data;

                        end if;

                    when others =>

                        -- stand-by control signal with ID
                        id_con <= '0';

                        addr_con <= HIIMPVEC;
                        result <= HIIMPVEC;
                        state <= send_addr;

                end case;

            else

                -- stand-by control signal with ID
                id_con <= '0';

                addr_con <= HIIMPVEC;

                result <= out_sel and mask;

            end if;

        end if;

    end process;

end behavioral;
