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
    use work.demo.all;

entity control_unit is
    generic(
        n           : positive := DEGREE
    );
    port(
        clk         : in std_logic;
        opcode      : in std_logic_vector(5 downto 1);   -- op code
        opand1      : in std_logic_vector(n downto 0);   -- operand 1
        opand2      : in std_logic_vector(n downto 0);   -- operand 2

        -- registers
        mask        : in  std_logic_vector(n downto 0);

        -- generation signals
        en_gen      : out std_logic;  -- polynomial generator enable
        rst_gen     : out std_logic;  -- polynomial generator reset

        -- operation signals
        i           : out std_logic_vector(n downto 0);  -- i
        j           : out std_logic_vector(n downto 0);  -- j

        -- memory types and methods
        mem_t       : out std_logic; -- memory type

        -- memory wrapper control signals
        id_cu       : out std_logic;
        mem_rdy     : in std_logic;

        -- memory address and data signals
        addr_cu     : out std_logic_vector(n downto 0);  -- address in memory
        dout_cu     : in std_logic_vector(n downto 0);  -- data from memory

        -- exceptions and flags
        err_b       : out std_logic;  -- set membership exception
        opand1_null : out std_logic;  -- operand 1 zero flag
        opand2_null : out std_logic  -- operand 2 zero flag
    );
end control_unit;

architecture behavioral of control_unit is

    component ismember
        port(
            operand     : in std_logic_vector(n downto 0);
            mask        : in std_logic_vector(n downto 0);
            is_not_in   : out std_logic
        );
    end component;

    component isnull
        port(
            opand       : in std_logic_vector(n downto 0);
            mem_t       : in std_logic;
            is_null     : out std_logic
        );
    end component;

    signal opand_b : std_logic_vector(n downto 0);  -- address from memory

    signal mem_t_z1 : std_logic;
    signal opand_z1 : std_logic_vector(n downto 0); -- zero flag for operand 1

    signal mem_t_z2 : std_logic;
    signal opand_z2 : std_logic_vector(n downto 0); -- zero flag for operand 2

    signal op_state : op_state_type;
    signal dbnc_state : debounce_state_type;
    signal rd_state1, rd_state2 : rd_state_type;

begin

    ismember_unit: ismember port map(
        operand => opand_b,
        mask => mask,
        is_not_in => err_b
    );

    iszero_unit1: isnull port map(
        opand => opand_z1,
        mem_t => mem_t_z1,
        is_null => opand1_null
    );

    iszero_unit2: isnull port map(
        opand => opand_z2,
        mem_t => mem_t_z2,
        is_null => opand2_null
    );

    process (clk, opcode, opand1, opand2, mask, mem_rdy, dout_cu)
    begin

        if (rising_edge(clk)) then

            case opcode(5 downto 3) is  -- instruction bits

                -- initiate element generator
                when "000" =>

                    -- enable generator
                    en_gen <= '1';

                    case dbnc_state is

                        when rst_state =>

                            -- reset generator values
                            rst_gen <= '1';
                            dbnc_state <= en_state;

                        when en_state =>

                            rst_gen <= '0';
                            --dbnc_state <= rst_state;

                        when others =>

                            dbnc_state <= rst_state;

                    end case;

                    -- disable arithmetic exceptions
                    opand_b <= ZEROVEC;
                    mem_t_z1 <= '-';
                    opand_z1 <= DCAREVEC;
                    mem_t_z2 <= '-';
                    opand_z2 <= DCAREVEC;

                    -- disable memory lookup
                    mem_t <= '-';
                    id_cu <= '0';
                    addr_cu <= DCAREVEC;

                -- add / sub
                when "001" =>

                    -- disable generator
                    en_gen <= '0';
                    rst_gen <= '0';

                    -- mem2, addr = element, data = polynomial
                    mem_t <= '1';

                    case op_state is

                        when op1_state =>


                            mem_t_z1 <= not opcode(2);

                            -- if operand 1 is in element form
                            if (opcode(2) = '0') then

                                case rd_state1 is

                                    -- send address to memory wrapper
                                    when send_addr =>

                                        id_cu <= '1';
                                        addr_cu <= opand1;
                                        i <= HIIMPVEC;

                                        rd_state1 <= get_data;
                                        op_state <= op1_state;

                                    when get_data =>


                                        id_cu <= '1';
                                        if (mem_rdy = '1') then

                                            -- i is converted to polynomial
                                            i <= dout_cu;
                                            -- check dout_cu for set
                                            -- membership exceptions
                                            opand_b <= dout_cu;
                                            opand_z1 <= dout_cu;

                                            op_state <= op2_state;
                                            rd_state1 <= get_data;

                                        else

                                            rd_state1 <= send_addr;
                                            op_state <= op1_state;

                                        end if;

                                    when others =>

                                        id_cu <= '0';
                                        addr_cu <= HIIMPVEC;
                                        i <= HIIMPVEC;

                                        rd_state1 <= send_addr;
                                        op_state <= op1_state;

                                end case;

                            -- if operand 1 is in polynomial form
                            else

                                id_cu <= '0';

                                -- i is the user input
                                i <= opand1;

                                -- check operand 1 for set membership
                                -- exceptions
                                opand_b <= opand1;
                                opand_z1 <= opand1;

                                op_state <= op2_state;

                            end if;

                        when op2_state =>

                            mem_t_z2 <= not opcode(1);

                            -- if operand 2 is in element form
                            if (opcode(1) = '0') then

                                case rd_state2 is

                                    -- send address to memory wrapper
                                    when send_addr =>

                                        id_cu <= '1';
                                        addr_cu <= opand2;
                                        j <= HIIMPVEC;

                                        rd_state2 <= get_data;
                                        op_state <= op2_state;

                                    when get_data =>

                                        id_cu <= '1';
                                        -- i is converted to polynomial
                                        j <= dout_cu;

                                        -- check dout_cu for set membership
                                        -- exceptions
                                        opand_b <= dout_cu;
                                        opand_z2 <= dout_cu;

                                        rd_state2 <= send_addr;
                                        op_state <= op1_state;

                                    when others =>

                                        id_cu <= '0';
                                        addr_cu <= HIIMPVEC;
                                        j <= HIIMPVEC;

                                        rd_state2 <= send_addr;
                                        op_state <= op2_state;

                                end case;

                            -- if operand 2 is in polynomial form
                            else


                                id_cu <= '0';

                                -- j is the user input
                                j <= opand2;

                                -- check operand 1 for set membership
                                -- exceptions
                                opand_b <= opand2;
                                opand_z2 <= opand2;

                            end if;

                        when others =>

                            -- address = element
                            addr_cu <= opand1;

                            -- op_state initializes to op1_state
                            op_state <= op1_state;

                    end case;

                -- mul / div
                when "010" | "011" =>

                    -- disable generator
                    en_gen <= '0';
                    rst_gen <= '0';

                    -- mem1, addr = polynomial, data = element
                    mem_t <= '0';

                    case op_state is

                        when op1_state =>

                            mem_t_z1 <= opcode(2);

                            -- if operand 1 is in polynomial form
                            if (opcode(2) = '1') then

                                case rd_state1 is

                                    -- send address to memory wrapper
                                    when send_addr =>

                                        id_cu <= '1';
                                        addr_cu <= opand1;
                                        i <= HIIMPVEC;

                                        rd_state1 <= get_data;
                                        op_state <= op1_state;

                                    when get_data =>

                                        id_cu <= '1';

                                        if (mem_rdy = '1') then

                                            -- i is converted to polynomial
                                            i <= dout_cu;
                                            -- check dout_cu for set membership
                                            -- exceptions
                                            opand_b <= dout_cu;
                                            opand_z1 <= dout_cu;

                                            op_state <= op2_state;
                                            rd_state1 <= get_data;

                                        else

                                            rd_state1 <= send_addr;
                                            op_state <= op1_state;

                                        end if;

                                    when others =>

                                        id_cu <= '0';
                                        addr_cu <= HIIMPVEC;
                                        i <= HIIMPVEC;

                                        rd_state1 <= send_addr;
                                        op_state <= op1_state;

                                end case;

                            -- if operand 1 is in polynomial form
                            else

                                id_cu <= '0';

                                -- i is the user input
                                i <= opand1;

                                -- check operand 1 for set membership
                                -- exceptions
                                opand_b <= opand1;
                                opand_z1 <= opand1;

                                op_state <= op2_state;

                            end if;

                        when op2_state =>

                            mem_t_z2 <= opcode(1);

                            -- if operand 2 is in polynomial form
                            if (opcode(1) = '1') then

                                case rd_state2 is

                                    -- send address to memory wrapper
                                    when send_addr =>

                                        id_cu <= '1';
                                        addr_cu <= opand2;
                                        j <= HIIMPVEC;

                                        rd_state2 <= get_data;
                                        op_state <= op2_state;

                                    when get_data =>

                                        id_cu <= '1';
                                        -- i is converted to polynomial
                                        j <= dout_cu;

                                        -- check dout_cu for set membership
                                        -- exceptions
                                        opand_b <= dout_cu;
                                        opand_z2 <= dout_cu;

                                        rd_state2 <= send_addr;
                                        op_state <= op1_state;

                                    when others =>

                                        id_cu <= '0';
                                        addr_cu <= HIIMPVEC;
                                        j <= HIIMPVEC;

                                        rd_state2 <= send_addr;
                                        op_state <= op2_state;

                                end case;

                            -- if operand 2 is in element form
                            else


                                id_cu <= '0';

                                -- j is the user input
                                j <= opand2;

                                -- check operand 1 for set membership
                                -- exceptions
                                opand_b <= opand2;
                                opand_z2 <= opand2;

                            end if;

                        when others =>

                            -- address = element
                            addr_cu <= opand1;

                            -- op_state initializes to op1_state
                            op_state <= op1_state;

                    end case;

                -- log
                when "100" =>

                    -- disable generator
                    en_gen <= '0';
                    rst_gen <= '0';

                    -- mem1, addr = polynomial, data = element
                    mem_t <= '0';

                    -- default values for opand2
                    -- j is the user input
                    j <= DCAREVEC;

                    -- check operand 2 for set membership
                    -- exceptions
                    opand_b <= ZEROVEC;
                    opand_z2 <= DCAREVEC;

                    case op_state is

                        when op1_state =>

                            mem_t_z1 <= opcode(2);

                            -- if operand 1 is in polynomial form
                            if (opcode(2) = '1') then

                                case rd_state1 is

                                    -- send address to memory wrapper
                                    when send_addr =>

                                        id_cu <= '1';
                                        addr_cu <= opand1;
                                        i <= HIIMPVEC;

                                        rd_state1 <= get_data;
                                        op_state <= op1_state;

                                    when get_data =>

                                        id_cu <= '1';

                                        if (mem_rdy = '1') then

                                            -- i is converted to polynomial
                                            i <= dout_cu;
                                            -- check dout_cu for set membership
                                            -- exceptions
                                            opand_b <= dout_cu;
                                            opand_z1 <= dout_cu;

                                            op_state <= op2_state;
                                            rd_state1 <= get_data;

                                        else

                                            rd_state1 <= send_addr;
                                            op_state <= op1_state;

                                        end if;

                                    when others =>

                                        id_cu <= '0';
                                        addr_cu <= HIIMPVEC;
                                        i <= HIIMPVEC;

                                        rd_state1 <= send_addr;
                                        op_state <= op1_state;

                                end case;

                            -- if operand 1 is in polynomial form
                            else

                                id_cu <= '0';

                                -- i is the user input
                                i <= opand1;

                                -- check operand 1 for set membership
                                -- exceptions
                                opand_b <= opand1;
                                opand_z1 <= opand1;

                                op_state <= op2_state;

                            end if;

                        when others =>

                            -- address = element
                            addr_cu <= opand1;

                            -- op_state initializes to op1_state
                            op_state <= op1_state;

                    end case;

                -- reset
                when "101" =>

                    -- reset generator
                    en_gen <= '1';
                    rst_gen <= '1';

                    -- disable arithmetic exceptions
                    opand_b <= ZEROVEC;
                    opand_z1 <= DCAREVEC;
                    opand_z2 <= DCAREVEC;

                    -- disable memory lookup
                    mem_t <= '-';
                    id_cu <= '0';
                    addr_cu <= DCAREVEC;

                -- mode
                when "110" =>

                    -- disable generator
                    en_gen <= '0';
                    rst_gen <= '0';

                    -- disable arithmetic exceptions
                    opand_b <= ZEROVEC;
                    opand_z1 <= DCAREVEC;
                    opand_z2 <= DCAREVEC;

                    -- disable memory lookup
                    mem_t <= '-';
                    id_cu <= '0';
                    addr_cu <= DCAREVEC;

                when others =>

                    -- disable generator
                    en_gen <= '0';
                    rst_gen <= '0';

                    -- disable arithmetic exceptions
                    opand_b <= ZEROVEC;
                    opand_z1 <= DCAREVEC;
                    opand_z2 <= DCAREVEC;

                    -- disable memory lookup
                    mem_t <= '-';
                    id_cu <= '0';
                    addr_cu <= DCAREVEC;

            end case;

        end if;

    end process;

end behavioral;
