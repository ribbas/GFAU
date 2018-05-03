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

        en          : in std_logic;  -- enable
        convert     : in std_logic;  -- convert flag
        mask        : in std_logic_vector(n downto 0);  -- operand mask

        -- result
        out_sel     : in std_logic_vector(n downto 0);

        -- memory wrapper control signals
        id_con      : out std_logic := '0';
        mem_rdy     : in std_logic;

        -- memory address and data signals
        addr_con    : out std_logic_vector(n downto 0);
        dout_con    : inout std_logic_vector(n downto 0) := HIIMPVEC;

        -- final output
        result      : out std_logic_vector(n downto 0) := DCAREVEC;
        rdy_out     : out std_logic := '0' -- result ready interrupt
    );
end outconvert;

architecture behavioral of outconvert is

    -- define the states for writing data
    signal state : rd_state_type;

begin

    process (clk) begin

        if (rising_edge(clk)) then

            if (en = '1') then

                -- if conversion requested
                if (convert = '1') then

                    case state is

                        -- send address to memory wrapper
                        when send_addr =>

                            -- read control signal with ID
                            id_con <= '1';
                            rdy_out <= '0';

                            addr_con <= out_sel;
                            result <= DCAREVEC;

                            state <= get_data;

                        when get_data =>

                            -- read control signal with ID
                            id_con <= '1';
                            addr_con <= out_sel;

                            if (mem_rdy = '1') then

                                result <= dout_con and mask;
                                rdy_out <= '1';

                            else

                                result <= DCAREVEC;
                                rdy_out <= '0';
                                state <= get_data;

                            end if;

                        when others =>

                            -- stand-by control signal with ID
                            id_con <= '0';
                            rdy_out <= '0';

                            addr_con <= DCAREVEC;
                            result <= DCAREVEC;
                            state <= send_addr;

                    end case;

                else

                    -- stand-by control signal with ID
                    id_con <= '0';
                    rdy_out <= '1';

                    addr_con <= DCAREVEC;

                    result <= out_sel and mask;

                end if;  -- convert

            else

                rdy_out <= '0';

            end if;  -- enable

        end if;  -- clock

    end process;

end behavioral;
