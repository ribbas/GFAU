-- memory.vhd
--
-- Sabbir Ahmed, Brian Weber
-- 2018-03-30
--
-- Wrapper for the CY7C1020DV33 memory chips.
--
-- CY7C1020DV33 truth table
--------------------------------------
-- signal   read    write   stand-by
-- nCE      0       0       1
-- nOE      0       -       -
-- nWE      1       0       -
-- nBLE     0       0       -
-- nBHE     0       0       -
--

library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;
library work;
    use work.demo.all;

entity memory is
    generic(
        n           : positive := DEGREE
    );
    port(
        -- clock
        clk         : in std_logic;

        -- memory types and methods
        mem_t_cu    : in std_logic;
        mem_t_con   : in std_logic;
        mem_rdy     : out std_logic;  -- ready

        -- module signals
        id_cu       : in std_logic;
        addr_cu     : in std_logic_vector(n downto 0);
        dout_cu     : out std_logic_vector(n downto 0);
        id_con      : in std_logic;
        addr_con    : in std_logic_vector(n downto 0);
        dout_con    : out std_logic_vector(n downto 0);
        id_gen      : in std_logic;
        addr_gen    : in std_logic_vector(n downto 0);
        din_gen     : in std_logic_vector(n downto 0);

        -- memory control signals
        nCE         : out std_logic;
        nWE         : out std_logic;
        nOE         : out std_logic;

        -- memory address and data signals
        A           : out std_logic_vector((n + 1) downto 0);
        DQ_in       : in std_logic_vector(n downto 0);
        wr_rd       : out std_logic; --1 output mode, 0 for read mode of ioport
        DQ_out      : out std_logic_vector(n downto 0);
        DQ          : inout std_logic_vector(n downto 0)
    );
end memory;

architecture behavioral of memory is

    -- define the states for reading data
    signal rd_state     : rd_state_type;

    -- define the states for writing data
    signal wr_state     : wr_state_type;
    
    --used for setting up address before writing
    signal setup        : setup_type := addr_init;
    
    signal ioport_oe    : std_logic;

    component io_port port(
        output  => DQ_out,
        oe      => wr_rd,
        input   => DQ_in,
        pad     => DQ
    );
    end component;

begin

    process (clk, id_cu, id_gen, id_con,
        addr_cu, addr_gen, addr_con, din_gen) begin

        if (rising_edge(clk)) then

            -- control unit
            if (id_cu = '1' and id_gen = '0' and id_con = '0') then

                case rd_state is

                    when send_addr =>
                        
                        -- memory read control signals
                        nCE <= '0';
			nOE <= '0';
                        nWE <= '1';

			wr_rd <= '0'; --set iobus mode to read

                        -- send output converter's address to memory
                        A <= mem_t_cu & addr_cu;

                        mem_rdy <= '0';

                        rd_state <= get_data;

                    when get_data =>

                        -- memory read control signals
                        nCE <= '0';
			nOE <= '0';
                        nWE <= '1';

			wr_rd <= '0'; --set iobus mode to read

                        -- send dout to output converter
                        dout_cu <= DQ_in; --read from iobus in
                        dout_con <= DCAREVEC;

                        mem_rdy <= '1';

                        rd_state <= send_addr;

                    when others =>

                        -- stand-by control signals
                        nCE <= '1';
                        nWE <= '-';

                        -- data outs are don't care
                        dout_con <= DCAREVEC;
                        dout_cu <= DCAREVEC;

                        mem_rdy <= '0';

                        rd_state <= send_addr;

                end case;

            -- output converter
            elsif (id_cu = '0' and id_gen = '0' and id_con = '1') then

                case rd_state is

                    when send_addr =>

                        -- memory read control signals
                        nCE <= '0';
			nOE <= '0';
                        nWE <= '1';

			wr_rd <= '0'; --set iobus mode to read

                        -- send output converter's address to memory
                        A <= mem_t_con & addr_con;

                        mem_rdy <= '0';

                        rd_state <= get_data;

                    when get_data =>

                        -- memory read control signals
                        nCE <= '0';
			nOE <= '0';
                        nWE <= '1';

			wr_rd <= '0'; --set iobus mode to read

                        -- send dout to output converter
                        dout_con <= DQ_in; --read from iobus in
                        dout_cu <= DCAREVEC;

                        mem_rdy <= '1';

                        rd_state <= send_addr;

                    when others =>

                        -- stand-by control signals
                        nCE <= '1';
                        nWE <= '-';

                        -- data outs are don't care
                        dout_con <= DCAREVEC;
                        dout_cu <= DCAREVEC;

                        mem_rdy <= '0';

                        rd_state <= send_addr;

                end case;

            -- generator
            elsif (id_cu = '0' and id_gen = '1' and id_con = '0') then

                -- data outs are don't care
                dout_con <= DCAREVEC;
                dout_cu <= DCAREVEC;

                case wr_state is

                    when wr_mem1 => --get address and data ready

                        case setup is
                            
                            when addr_setup => 
                                
                                -- memory read control signals
                                nCE <= '0';
                                nWE <= '1'; --don't write yet
                                nOE <= '1';
                                

                                -- send control unit's address to memory
                                A <= '0' & addr_gen;
                                DQ_out <= din_gen;
                                wr_rd <= '1'; --sets the io port to output mode
                                mem_rdy <= '0'; 

                                setup <= wr;
                            
                            when wr =>
                            
                                nCE <= '0';
                                nWE <= '0';
                                nOE <= '1';
                                
                                --hold address, data, and bus control signals
                                A <= mem_t_cu & addr_cu;
                                DQ_out <= din_gen;
                                wr_rd <= '1';
                                mem_rdy '1'; --data now written
                                setup <= addr_setup;
                                wr_state <= wr_mem2; 

                    when wr_mem2 =>

                        case setup is
                            
                            when addr_setup => 
                                
                                -- memory read control signals
                                nCE <= '0';
                                nWE <= '1'; --don't write yet
                                nOE <= '1';
                                

                                -- send control unit's address to memory
                                A <= '1' & addr_gen;
                                DQ_out <= din_gen;
                                wr_rd <= '1'; --sets the io port to output mode
                                mem_rdy <= '0'; 

                                setup <= wr;
                            
                            when wr =>
                            
                                nCE <= '0';
                                nWE <= '0';
                                nOE <= '1';
                                
                                --hold address, data, and bus control signals
                                A <= mem_t_cu & addr_cu;
                                DQ_out <= din_gen;
                                wr_rd <= '1';
                                mem_rdy '1'; --data now written
                                setup <= addr_setup;
                                wr_state <= wr_mem1;

                    when others =>

                        -- stand-by control signals
                        nCE <= '1';
                        nWE <= '-';

                        A <= '-' & DCAREVEC;

                        mem_rdy <= '0';

                        wr_state <= wr_mem1;

                end case;

            else

                -- stand-by control signals
                nCE <= '1';
                nWE <= '-';

                A <= '-' & DCAREVEC;
                DQ <= HIIMPVEC;

                mem_rdy <= '0';

                -- data outs are don't care
                dout_con <= DCAREVEC;
                dout_cu <= DCAREVEC;

            end if;

        end if;

    end process;

end behavioral;
