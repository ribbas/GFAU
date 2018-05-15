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

        init        : in std_logic;  -- control unit enable
        rst         : in std_logic; --reset

        -- registers
        mask        : in  std_logic_vector(n downto 0);

        -- generation signals
        en_gen      : out std_logic;  -- polynomial generator enable
        rst_gen     : out std_logic;  -- polynomial generator reset

        -- operation signals
        en_ops      : out std_logic;  -- operators enable
        rst_ops     : out std_logic;
        i           : out std_logic_vector(n downto 0) := DCAREVEC;  -- i
        j           : out std_logic_vector(n downto 0) := DCAREVEC;  -- j

        -- memory wrapper control signals
        id_cu       : out std_logic := '0';
        mem_rdy     : in std_logic;

        -- memory address and data signals
        addr_cu     : out std_logic_vector((n + 1) downto 0);  -- address in memory
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

    signal en : std_logic;

    signal opand_b : std_logic_vector(n downto 0);  -- address from memory

    signal mem_t_z1 : std_logic := '0';
    signal opand_z1 : std_logic_vector(n downto 0) := ZEROVEC; -- zero flag for operand 1

    signal mem_t_z2 : std_logic := '0';
    signal opand_z2 : std_logic_vector(n downto 0) := ZEROVEC; -- zero flag for operand 2

    signal op_state : op_state_type;
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

    process (clk) begin

        if (rising_edge(clk)) then

            if (init = '1' and rst = '0') then

                en <= '1';

                -- reset operand state
                op_state <= op1_state;

            end if;

            if (rst = '1') then

                -- reset operators
                rst_ops <= '1';
                en_ops <= '0';

                -- disable generator
                rst_gen <= '1';
                en_gen <= '0';

                -- disable arithmetic exceptions
                opand_b <= ZEROVEC;
                mem_t_z1 <= '0';
                opand_z1 <= ZEROVEC;
                mem_t_z2 <= '0';
                opand_z2 <= ZEROVEC;

                -- disable memory lookup
                id_cu <= '0';
                addr_cu <= '-' & DCAREVEC;

            end if;

            if (en = '1' and rst = '0') then

                case opcode(5 downto 3) is  -- instruction bits

                    -- initiate element generator
                    when "000" =>

                        rst_gen <= '0';

                        -- enable generator
                        en_gen <= '1';

                        -- disable arithmetic exceptions
                        opand_b <= ZEROVEC;
                        mem_t_z1 <= '0';
                        opand_z1 <= ZEROVEC;
                        mem_t_z2 <= '0';
                        opand_z2 <= ZEROVEC;

                        -- disable operators
                        en_ops <= '0';

                        -- disable memory lookup
                        id_cu <= '0';
                        addr_cu <= '-' & DCAREVEC;

                    -- add / sub
                    when "001" =>

                        -- disable generator
                        en_gen <= '0';
                        rst_gen <= '0';


                        case op_state is

                            when op1_state =>

                                -- disable operators
                                en_ops <= '0';
                                rst_ops <= '1';

                                mem_t_z1 <= not opcode(2);

                                -- if operand 1 is in element form
                                if (opcode(2) = '0') then

                                    id_cu <= '1';
                                    -- mem2, addr = element, data = polynomial
                                    addr_cu <= '1' & opand1;

                                    case rd_state1 is

                                        -- send address to memory wrapper
                                        when send_addr =>

                                            i <= DCAREVEC;

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
                                            addr_cu <= 'Z' & HIIMPVEC;
                                            i <= DCAREVEC;

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
                                rst_ops <= '0';

                                -- if operand 2 is in element form
                                if (opcode(1) = '0') then

                                    id_cu <= '1';
                                    addr_cu <= '1' & opand2;

                                    case rd_state2 is

                                        -- send address to memory wrapper
                                        when send_addr =>

                                            j <= DCAREVEC;

                                            -- disable operators
                                            en_ops <= '0';

                                            rd_state2 <= get_data;
                                            op_state <= op2_state;

                                        when get_data =>

                                            id_cu <= '1';

                                            if (mem_rdy = '1') then

                                                -- j is converted to polynomial
                                                j <= dout_cu;
                                                -- check dout_cu for set
                                                -- membership exceptions
                                                opand_b <= dout_cu;
                                                opand_z2 <= dout_cu;

                                                rd_state2 <= get_data;

                                                -- enable operators
                                                en_ops <= '1';

                                            else

                                                rd_state2 <= send_addr;
                                                op_state <= op2_state;

                                                -- disable generator
                                                en_ops <= '0';

                                            end if;

                                        when others =>

                                            id_cu <= '0';
                                            addr_cu <= 'Z' & HIIMPVEC;
                                            j <= DCAREVEC;

                                            rd_state2 <= send_addr;
                                            op_state <= op2_state;

                                    end case;

                                -- if operand 2 is in polynomial form
                                else

                                    -- enable generator
                                    en_ops <= '1';
                                    rst_ops <= '0';

                                    id_cu <= '0';

                                    -- j is the user input
                                    j <= opand2;

                                    -- check operand 1 for set membership
                                    -- exceptions
                                    opand_b <= opand2;
                                    opand_z2 <= opand2;
                                    op_state <= op1_state;

                                end if;

                            when others =>

                                -- op_state initializes to op1_state
                                op_state <= op1_state;

                        end case;

                    -- mul / div
                    when "010" | "011" =>

                        -- disable generator
                        en_gen <= '0';
                        rst_gen <= '0';

                        case op_state is

                            when op1_state =>

                                -- disable generator
                                en_ops <= '0';
                                rst_ops <= '1';

                                mem_t_z1 <= opcode(2);

                                -- if operand 1 is in polynomial form
                                if (opcode(2) = '1') then

                                    id_cu <= '1';
                                    -- mem1, addr = polynomial, data = element
                                    addr_cu <= '0' & opand1;

                                    case rd_state1 is

                                        -- send address to memory wrapper
                                        when send_addr =>

                                            i <= DCAREVEC;

                                            rd_state1 <= get_data;
                                            op_state <= op1_state;

                                        when get_data =>

                                            id_cu <= '1';

                                            if (mem_rdy = '1') then

                                                -- i is converted to element
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
                                            addr_cu <= 'Z' & HIIMPVEC;
                                            i <= DCAREVEC;

                                            rd_state1 <= send_addr;
                                            op_state <= op1_state;

                                    end case;

                                -- if operand 1 is in element form
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
                                rst_ops <= '0';

                                -- if operand 2 is in polynomial form
                                if (opcode(1) = '1') then

                                    id_cu <= '1';
                                    addr_cu <= '0' & opand2;

                                    case rd_state2 is

                                        -- send address to memory wrapper
                                        when send_addr =>

                                            j <= DCAREVEC;

                                            -- disable generator
                                            en_ops <= '0';

                                            rd_state2 <= get_data;
                                            op_state <= op2_state;

                                        when get_data =>

                                            id_cu <= '1';

                                            if (mem_rdy = '1') then

                                                -- j is converted to element
                                                j <= dout_cu;
                                                -- check dout_cu for set
                                                -- membership exceptions
                                                opand_b <= dout_cu;
                                                opand_z2 <= dout_cu;

                                                rd_state2 <= get_data;

                                                -- enable generator
                                                en_ops <= '1';

                                            else

                                                rd_state2 <= send_addr;
                                                op_state <= op2_state;

                                                -- disable generator
                                                en_ops <= '0';

                                            end if;

                                        when others =>

                                            id_cu <= '0';
                                            addr_cu <= 'Z' & HIIMPVEC;
                                            j <= DCAREVEC;

                                            rd_state2 <= send_addr;
                                            op_state <= op2_state;

                                    end case;

                                -- if operand 2 is in element form
                                else

                                    -- enable generator
                                    en_ops <= '1';
                                    rst_ops <= '0';

                                    id_cu <= '0';

                                    -- j is the user input
                                    j <= opand2;

                                    -- check operand 1 for set membership
                                    -- exceptions
                                    opand_b <= opand2;
                                    opand_z2 <= opand2;
                                    op_state <= op1_state;

                                end if;

                            when others =>

                                -- op_state initializes to op1_state
                                op_state <= op1_state;

                        end case;

                    -- log
                    when "100" =>

                        -- disable generator
                        en_gen <= '0';
                        rst_gen <= '0';

                        -- default values for opand2
                        -- j is the user input
                        j <= DCAREVEC;

                        -- check operand 2 for set membership
                        -- exceptions
                        opand_b <= ZEROVEC;
                        opand_z2 <= ZEROVEC;

                        case op_state is

                            when op1_state =>

                                mem_t_z1 <= opcode(2);
                                en_ops <= '1';
                                rst_ops <= '0';

                                -- if operand 1 is in polynomial form
                                if (opcode(2) = '1') then

                                    id_cu <= '1';

                                    -- mem1, addr = polynomial, data = element
                                    addr_cu <= '0' & opand1;

                                    case rd_state1 is

                                        -- send address to memory wrapper
                                        when send_addr =>

                                            i <= DCAREVEC;

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
                                            addr_cu <= 'Z' & HIIMPVEC;
                                            i <= DCAREVEC;

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

                                -- op_state initializes to op1_state
                                op_state <= op1_state;

                        end case;

                    -- multiplicative inverse
                    when "101" =>

                        -- disable operations
                        en_ops <= '0';

                        -- reset generator
                        en_gen <= '1';
                        rst_gen <= '1';

                        -- disable arithmetic exceptions
                        opand_b <= ZEROVEC;
                        mem_t_z1 <= '0';
                        opand_z1 <= ZEROVEC;
                        mem_t_z2 <= '0';
                        opand_z2 <= ZEROVEC;

                        -- disable memory lookup
                        id_cu <= '0';
                        addr_cu <= '-' & DCAREVEC;

                    when others =>

                        -- disable operations
                        en_ops <= '0';

                        -- disable generator
                        en_gen <= '0';
                        rst_gen <= '0';

                        -- disable arithmetic exceptions
                        opand_b <= ZEROVEC;
                        mem_t_z1 <= '0';
                        opand_z1 <= ZEROVEC;
                        mem_t_z2 <= '0';
                        opand_z2 <= ZEROVEC;

                        -- disable memory lookup
                        id_cu <= '0';
                        addr_cu <= '-' & DCAREVEC;

                end case;


            else

                -- disable operations
                en_ops <= '0';
                rst_ops <= '1';

                -- disable generator
                en_gen <= '0';
                rst_gen <= '1';

                -- disable arithmetic exceptions
                opand_b <= ZEROVEC;
                mem_t_z1 <= '0';
                opand_z1 <= ZEROVEC;
                mem_t_z2 <= '0';
                opand_z2 <= ZEROVEC;

                -- disable memory lookup
                id_cu <= '0';
                addr_cu <= '-' & DCAREVEC;

            end if;  -- enable

        end if;  -- clock

    end process;

end behavioral;
