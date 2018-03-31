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

        mem_rd      : out std_logic;
        mem_wr      : out std_logic;

        -- memory wrapper control signals
        id_con      : out std_logic;
        rdy         : in std_logic;

        -- memory address and data signals
        addr_con    : out std_logic_vector(n downto 0);
        dout_con    : inout std_logic_vector(n downto 0);

        result      : out std_logic_vector(n downto 0)
    );
end outconvert;

architecture behavioral of outconvert is

    -- define the states for writing data
    type state_type is (send_addr, get_data);
    signal state : state_type;

begin

    process (clk, convert, mask, out_sel, rdy) begin

        if (rising_edge(clk)) then

            if (convert = '1') then

                case state is

                    when send_addr =>

                        -- read control signal with ID
                        id_con <= '1';
                        mem_rd <= '1';
                        mem_wr <= '0';

                        addr_con <= out_sel;
                        result <= HIIMPVEC;

                        state <= get_data;

                    when get_data =>

                        -- read control signal with ID
                        id_con <= '1';
                        mem_rd <= '1';
                        mem_wr <= '0';

                        if (rdy = '1') then

                            result <= dout_con and mask;
                            state <= send_addr;

                        else

                            result <= HIIMPVEC;
                            state <= get_data;

                        end if;

                    when others =>

                        -- stand-by control signal with ID
                        id_con <= '0';
                        mem_rd <= '0';
                        mem_wr <= '0';

                        addr_con <= HIIMPVEC;
                        result <= HIIMPVEC;

                        state <= send_addr;

                end case;

            else

                result <= out_sel and mask;

            end if;

        end if;

    end process;

end behavioral;

