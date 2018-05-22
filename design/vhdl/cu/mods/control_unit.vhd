-- control_unit.vhd
--
-- Sabbir Ahmed
-- 2018-01-16
--
-- Control unit to parse the opcode and validate operands.
--

library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;
    use ieee.std_logic_unsigned.all;
library work;
    use work.glob.all;

entity control_unit is
    generic(
        n           : positive := DEGREE
    );
    port(
        clk         : in std_logic;
        opcode      : in std_logic_vector(5 downto 1);   -- op code
        opand1      : in std_logic_vector(n downto 0);   -- operand 1
        opand2      : in std_logic_vector(n downto 0);   -- operand 2

        start       : in std_logic;  -- control unit enable
        rst         : in std_logic; -- global reset

        -- generation signals
        en_gen      : out std_logic;  -- polynomial generator enable
        rst_gen     : out std_logic;  -- polynomial generator reset
        gen_rdy     : in std_logic;  -- generation done

        -- operation signals
        ops_rdy     : out std_logic;  -- operators enable
        rst_ops     : out std_logic;
        i           : out std_logic_vector(n downto 0) := ZEROVEC;  -- i
        j           : out std_logic_vector(n downto 0) := ZEROVEC;  -- j

        -- memory wrapper control signals
        id_cu       : out std_logic := '0';
        nOE         : out std_logic := '1';
        nCE         : out std_logic := '1';

        -- memory address and data signals
        addr_cu     : out std_logic_vector((n + 1) downto 0);  -- address in memory
        dout_cu     : in std_logic_vector(n downto 0)  -- data from memory
    );
end control_unit;

architecture behavioral of control_unit is

    signal en : std_logic;
    signal ij : std_logic;
    signal came_from_both : std_logic;
    signal ops_rdy_sig    :   std_logic;
    signal en_gen_s     :   std_logic;
    signal get_data_h   :   std_logic := '0'; --hold get_data state to latch received data
    signal get_data_h2  :   std_logic := '0';
    signal ops_rdy_h    :   std_logic := '0';


    type cu_state_type is (ready, convi, convj, both, gen, memrd);
    signal cu_state : cu_state_type := ready;

    signal rd_state : rd_state_type := send_addr;

begin

    ops_rdy <= ops_rdy_sig;
    en_gen <= en_gen_s;

    process (clk) begin

        if (rising_edge(clk)) then

            if (rst = '1') then

                -- reset operators
                rst_ops <= '1';

                -- disable memory lookup
                id_cu <= '0';
                addr_cu <= '-' & DCAREVEC;
                cu_state <= ready;
                rd_state <= send_addr;
                nCE <= '1';
                nOE <= '1';

            else

            case (cu_state) is

                when ready =>
                    rst_ops <= '0';
                    id_cu <= '0';
                    nCE <= '1';
                    nOE <= '1';
                    en_gen_s <= '0';
                    rd_state <= send_addr;
                    if(ops_rdy_sig = '1' and ops_rdy_h = '1') then
                        ops_rdy_sig <= '0';
                        ops_rdy_h <= '0';
                    elsif(ops_rdy_sig = '1' and ops_rdy_h = '0') then
                        ops_rdy_h <= '1';
                    end if;
                    if (start = '1') then
                        en <= '1';
                        case (opcode) is

                            when "00000" | "00001" | "00010" | "00011" =>

                                cu_state <= gen;

                            when "00101" | "01010" | "01110" | "10010" | "10011" =>

                                cu_state <= convi;

                            when "00110" | "01001" | "01101" =>

                                cu_state <= convj;

                            when "00100" | "01011" | "01111" =>

                                cu_state <= both;

                        ----end no memory lookup
                            when "00111" | "01000" | "01100" | "10000" =>

                                i <= opand1;
                                j <= opand2;

                                ops_rdy_sig <= '1';

                                cu_state <= ready;
                            when others =>

                            ----end try again
                                cu_state <= ready;

                        end case;
                    else
                        --en_gen <= '0';
                        --rst_gen <= '1';
                    end if;
                    came_from_both <= '0';

                when gen =>

                    if (en = '1') then

                        -- start generator
                        if en_gen_s = '0' then
                            en_gen_s <= '1';
                        else
                            cu_state <= ready;
                        end if;
                          

                        -- disable memory lookup
                        id_cu <= '0';

                        --if(gen_rdy = '1') then
                        --    cu_state <= ready;
                        --end if;
                        

                    end if;

                    ops_rdy_sig <= '0';

                when convi =>

                    if (en = '1') then

                        -- came from convi
                        ij <= '0';

                        j <= opand2;

                        ops_rdy_sig <= '0';

                        cu_state <= memrd;

                    end if;

                when convj =>

                    if (en = '1') then

                        -- came from convj
                        ij <= '1';
                        came_from_both <= '0';

                        i <= opand1;

                        ops_rdy_sig <= '0';

                        cu_state <= memrd;

                    end if;

                when memrd =>

                    case (rd_state) is

                        when send_addr =>

                            ops_rdy_sig <= '0';
                            nOE <= '0';
                            nCE <= '0';
                            
                            if (ij = '0') then

                                addr_cu <= (not opcode(2)) & opand1;
                                id_cu <= '1';

                            else

                                addr_cu <= (not opcode(1)) & opand2;
                                id_cu <= '1';

                            end if;

                            rd_state <= get_data;

                        when get_data =>

                                if(get_data_h = '1') then
                                    get_data_h2 <= '1';
                                    get_data_h <= '0';
                                elsif(get_data_h2 = '1') then

                                    if (ij = '0') then

                                        i <= dout_cu;
                                        
                                        if(came_from_both = '1') then
                                            rd_state <= send_addr;
                                            came_from_both <= '0';
                                            ij <= '1';
                                        else 
                                            cu_state <= ready;
                                            rd_state <= send_addr;
                                            ops_rdy_sig <= '1';
                                            en <= '0';
                                            id_cu <= '0';
                                        end if;

                                    else

                                        j <= dout_cu;
                                        cu_state <= ready;
                                        rd_state <= send_addr;
                                        ops_rdy_sig <= '1';
                                        en <= '0';
                                        id_cu <= '0';

                                    end if;
                                    
                                    get_data_h2 <= '0';
                                
                                else
                                
                                    get_data_h <= '1';
                                  
                                end if;

                        end case;

                    when both =>

                        if (en = '1') then

                            came_from_both <= '1';
                            ops_rdy_sig <= '0';

                            cu_state <= convi;

                        end if;

                    end case;  -- control unit state
                end if;

        end if;

    end process;

end behavioral;
