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

entity control_unit is
    port(
        clk         : in std_logic;
        opcode      : in std_logic_vector(5 downto 0);   -- op code
        opand1      : in std_logic_vector(8 downto 0);   -- operand 1
        opand2      : in std_logic_vector(8 downto 0);   -- operand 2

        -- registers
        mask        : in  std_logic_vector(8 downto 0);

        -- generation signals
        en_gen      : out std_logic;  -- polynomial generator enable
        rst_gen     : out std_logic;  -- polynomial generator reset

        -- operation signals
        i           : out std_logic_vector(8 downto 0);  -- i
        j           : out std_logic_vector(8 downto 0);  -- j

        -- memory signals
        mem_data    : in std_logic_vector(8 downto 0);  -- data from memory
        mem_addr    : out std_logic_vector(8 downto 0);  -- address in memory
        mem_t       : inout std_logic;  -- which memory
        mem_rd      : out std_logic;  -- read signal to memory

        -- exceptions
        err_b       : out std_logic;  -- out of bound exception
        opand1_null : out std_logic;  -- zero exception
        opand2_null : out std_logic  -- zero exception
    );
end control_unit;

architecture structural of control_unit is

    component isbounded
        port(
            operand     : in std_logic_vector(8 downto 0);
            mask        : in std_logic_vector(8 downto 0);
            is_out_bd   : out std_logic
        );
    end component;

    component isnull
        port(
            opand      : in std_logic_vector(8 downto 0);
            mem_t      : in std_logic;
            is_null    : out std_logic
        );
    end component;

    signal opand_b : std_logic_vector(8 downto 0);  -- mem_data from memory

    signal mem_t_z1 : std_logic;
    signal mem_t_z2 : std_logic;
    signal opand_z1 : std_logic_vector(8 downto 0); -- zero flag for operand 1
    signal opand_z2 : std_logic_vector(8 downto 0); -- zero flag for operand 2

    type state_type is (op1_state, op2_state);  -- define the states
    signal state : state_type;

begin

    isbounded_unit: isbounded port map(
        operand => opand_b,
        mask => mask,
        is_out_bd => err_b
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

    process (clk, opcode, opand1, opand2, mask, mem_data, mem_t)

        constant DCAREVEC : std_logic_vector(8 downto 0) := (others => '-');

    begin

        if (rising_edge(clk)) then

            case opcode(5 downto 3) is  -- instruction bits

                -- intiate polynomial generator
                when "000" =>

                    -- enable generator
                    en_gen <= '1';
                    rst_gen <= '0';

                    -- disable arithmetic exceptions
                    opand_b <= DCAREVEC;
                    opand_z1 <= DCAREVEC;
                    opand_z2 <= DCAREVEC;

                    -- disable memory lookup
                    mem_t <= '-';
                    mem_rd <= '0';
                    mem_addr <= DCAREVEC;

                -- add/sub
                when "001" =>

                    -- disable generator
                    en_gen <= '0';
                    rst_gen <= '0';

                    -- read from memory to convert element to polynomial
                    mem_rd <= '1';

                    -- mem2, addr = element, data = polynomial
                    mem_t <= '1';

                    case state is

                        when op1_state =>

                            mem_t_z1 <= not opcode(2);

                            -- if operand 1 is in element form
                            if (opcode(2) = '0') then

                                -- i is converted to polynomial
                                i <= mem_data;

                                -- check mem_data for out-of-bound exceptions
                                opand_b <= mem_data;
                                opand_z1 <= mem_data;

                            -- if operand 1 is in polynomial form
                            else

                                -- i is the user input
                                i <= opand1;

                                -- check operand 1 for out-of-bound exceptions
                                opand_b <= opand1;
                                opand_z1 <= opand1;

                            end if;

                            -- address = element
                            mem_addr <= opand2;

                            state <= op2_state;

                        when op2_state =>

                            mem_t_z2 <= not opcode(1);

                            -- if operand 2 is in element form
                            if (opcode(1) = '0') then

                                -- j is converted to polynomial
                                j <= mem_data;

                                -- check mem_data for out-of-bound exceptions
                                opand_b <= mem_data;
                                opand_z2 <= mem_data;

                            -- if operand 2 is in polynomial form
                            else

                                -- j is the user input
                                j <= opand2;

                                -- check operand 1 for out-of-bound exceptions
                                opand_b <= opand2;
                                opand_z2 <= opand2;

                            end if;

                            state <= op1_state;

                        when others =>

                            -- address = element
                            mem_addr <= opand1;

                            -- state initializes to op1_state
                            state <= op1_state;

                    end case;

                -- mul / div
                when "010" | "011" =>

                    -- disable generator
                    en_gen <= '0';
                    rst_gen <= '0';

                    -- read from memory to convert element to polynomial
                    mem_rd <= '1';

                    -- mem1, addr = polynomial, data = element
                    mem_t <= '0';

                    case state is

                        when op1_state =>

                            mem_t_z1 <= opcode(2);

                            -- if operand 1 is in polynomial form
                            if (opcode(2) = '1') then

                                -- i is converted to element
                                i <= mem_data;

                                -- check mem_data for out-of-bound exceptions
                                opand_b <= mem_data;
                                opand_z1 <= mem_data;

                            -- if operand 1 is in element form
                            else

                                -- i is the user input
                                i <= opand1;

                                -- check operand 1 for out-of-bound exceptions
                                opand_b <= opand1;
                                opand_z1 <= opand1;

                            end if;

                            -- address = polynomial
                            mem_addr <= opand2;

                            state <= op2_state;

                        when op2_state =>

                            mem_t_z2 <= opcode(1);

                            -- if operand 2 is in polynomial form
                            if (opcode(1) = '1') then

                                -- j is converted to element
                                j <= mem_data;

                                -- check mem_data for out-of-bound exceptions
                                opand_b <= mem_data;
                                opand_z2 <= mem_data;

                            -- if operand 2 is in element form
                            else

                                -- j is the user input
                                j <= opand2;

                                -- check operand 1 for out-of-bound exceptions
                                opand_b <= opand2;
                                opand_z2 <= opand2;

                            end if;

                            state <= op1_state;

                        when others =>

                            -- address = polynomial
                            mem_addr <= opand1;

                            -- state initializes to op1_state
                            state <= op1_state;

                    end case;

                -- log
                when "100" =>

                    -- disable generator
                    en_gen <= '0';
                    rst_gen <= '0';

                    -- read from memory to convert element to polynomial
                    mem_rd <= '1';

                    -- mem1, addr = polynomial, data = element
                    mem_t <= '0';

                    case state is

                        when op1_state =>

                            mem_t_z1 <= opcode(2);

                            -- if operand 1 is in polynomial form
                            if (opcode(2) = '1') then

                                -- i is converted to element
                                i <= mem_data;

                                -- check mem_data for out-of-bound exceptions
                                opand_b <= mem_data;
                                opand_z1 <= mem_data;

                            -- if operand 1 is in element form
                            else

                                -- i is the user input
                                i <= opand1;

                                -- check operand 1 for out-of-bound exceptions
                                opand_b <= opand1;
                                opand_z1 <= opand1;

                            end if;

                            -- address = don't care
                            mem_addr <= DCAREVEC;

                            state <= op1_state;

                        when others =>

                            -- address = polynomial
                            mem_addr <= opand1;

                            -- state initializes to op1_state
                            state <= op1_state;

                    end case;

                -- reset
                when "101" =>

                    -- reset generator
                    en_gen <= '1';
                    rst_gen <= '1';

                    -- disable arithmetic exceptions
                    opand_b <= DCAREVEC;
                    opand_z1 <= DCAREVEC;
                    opand_z2 <= DCAREVEC;

                    -- disable memory lookup
                    mem_t <= '-';
                    mem_rd <= '0';
                    mem_addr <= DCAREVEC;

                -- mode
                when "110" =>

                    -- disable generator
                    en_gen <= '0';
                    rst_gen <= '0';

                    -- disable arithmetic exceptions
                    opand_b <= DCAREVEC;
                    opand_z1 <= DCAREVEC;
                    opand_z2 <= DCAREVEC;

                    -- disable memory lookup
                    mem_t <= '-';
                    mem_rd <= '0';
                    mem_addr <= DCAREVEC;

                -- nop
                when "111" =>

                    -- disable generator
                    en_gen <= '0';
                    rst_gen <= '0';

                    -- disable arithmetic exceptions
                    opand_b <= DCAREVEC;
                    opand_z1 <= DCAREVEC;
                    opand_z2 <= DCAREVEC;

                    -- disable memory lookup
                    mem_t <= '-';
                    mem_rd <= '0';
                    mem_addr <= DCAREVEC;

                when others =>

                    -- disable generator
                    en_gen <= '0';
                    rst_gen <= '0';

                    -- disable arithmetic exceptions
                    opand_b <= DCAREVEC;
                    opand_z1 <= DCAREVEC;
                    opand_z2 <= DCAREVEC;

                    -- disable memory lookup
                    mem_t <= '-';
                    mem_rd <= '0';
                    mem_addr <= DCAREVEC;

            end case;

        end if;

    end process;

end structural;
