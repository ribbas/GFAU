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
        opand1      : in std_logic_vector(15 downto 0);   -- operand 1
        opand2      : in std_logic_vector(15 downto 0);   -- operand 2

        -- registers
        mask        : in  std_logic_vector(15 downto 0);

        -- generation signals
        en_gen      : out std_logic;  -- polynomial generator enable
        rst_gen     : out std_logic;  -- polynomial generator reset

        -- operation signals
        i           : out std_logic_vector(15 downto 0);  -- i
        j           : out std_logic_vector(15 downto 0);  -- j

        -- memory signals
        mem_data    : in std_logic_vector(15 downto 0);  -- data from memory
        mem_addr    : out std_logic_vector(15 downto 0);  -- address in memory
        mem_t       : inout std_logic;  -- which memory
        mem_rd      : out std_logic;  -- read signal to memory

        -- exceptions
        err_b       : out std_logic;  -- out of bound exception
        err_z       : out std_logic  -- zero exception
    );
end control_unit;

architecture structural of control_unit is

    component isbounded
        port(
            operand     : in std_logic_vector(15 downto 0);
            mask        : in std_logic_vector(15 downto 0);
            is_out_bd   : out std_logic
        );
    end component;

    component iszero
        port(
            opand           : in std_logic_vector(15 downto 0);
            mem_t           : in std_logic;
            is_null    : out std_logic
        );
    end component;

    signal err_z_t : std_logic;
    signal zero_mem_t : std_logic;
    signal zero_opand : std_logic_vector(15 downto 0);  -- mem_data from memory
    signal bd_opand : std_logic_vector(15 downto 0);  -- mem_data from memory

    type state_type is (op1_state, op2_state, rdy_state);  -- define the states
    signal state : state_type;

begin

    isbounded_unit: isbounded port map(
        operand => bd_opand,
        mask => mask,
        is_out_bd => err_b
    );

    iszero_unit: iszero port map(
        opand => zero_opand,
        mem_t => zero_mem_t,
        is_null => err_z
    );

    process (clk, opcode, opand1, opand2, mask, mem_data, mem_t) begin

        if (rising_edge(clk)) then

            case opcode(5 downto 3) is  -- instruction bits

                -- intiate polynomial generator
                when "000" =>

                    -- enable generator
                    en_gen <= '1';
                    rst_gen <= '0';

                    -- disable arithmetic exceptions
                    bd_opand <= "XXXXXXXXXXXXXXXX";
                    zero_opand <= "XXXXXXXXXXXXXXXX";

                    -- disable memory lookup
                    mem_t <= 'X';
                    mem_rd <= '0';
                    mem_addr <= "XXXXXXXXXXXXXXXX";

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

                            --err_z <= err_z_t;
                            zero_mem_t <= opcode(2);

                            -- if operand 1 is in element form
                            if (opcode(2) = '0') then

                                -- i is converted to polynomial
                                i <= mem_data;

                                -- check mem_data for out-of-bound exceptions
                                bd_opand <= mem_data;
                                zero_opand <= mem_data;

                            -- if operand 1 is in polynomial form
                            else

                                -- i is the user input
                                i <= opand1;

                                -- check operand 1 for out-of-bound exceptions
                                bd_opand <= opand1;
                                zero_opand <= opand1;

                            end if;

                            -- address = element
                            mem_addr <= opand2;

                            state <= op2_state;

                        when op2_state =>

                            --err_z <= err_z_t;
                            zero_mem_t <= opcode(1);

                            -- if operand 2 is in element form
                            if (opcode(1) = '0') then

                                -- j is converted to polynomial
                                j <= mem_data;

                                -- check mem_data for out-of-bound exceptions
                                bd_opand <= mem_data;
                                zero_opand <= mem_data;

                            -- if operand 2 is in polynomial form
                            else

                                -- j is the user input
                                j <= opand2;

                                -- check operand 1 for out-of-bound exceptions
                                bd_opand <= opand2;
                                zero_opand <= opand2;

                            end if;

                            state <= op1_state;

                        when others =>

                            -- address = element
                            mem_addr <= opand1;

                            -- state initializes to op1_state
                            state <= op1_state;

                    end case;

                -- mul / div / log
                when "010" | "011" | "100" =>

                    -- disable generator
                    en_gen <= '0';
                    rst_gen <= '0';

                    -- read from memory to convert polynomial to element
                    mem_rd <= '1';

                    -- mem2, addr = element, data = polynomial
                    mem_t <= '0';

                    case state is

                        when op1_state =>

                            zero_mem_t <= not opcode(2);

                            -- if operand 1 is in polynomial form
                            if (opcode(2) = '1') then

                                -- i is converted to element
                                i <= mem_data;

                                -- check mem_data for out-of-bound exceptions
                                bd_opand <= mem_data;
                                zero_opand <= mem_data;

                            -- if operand 1 is in element form
                            else

                                -- i is the user input
                                i <= opand1;

                                -- check operand 1 for out-of-bound exceptions
                                bd_opand <= opand1;
                                zero_opand <= opand1;

                            end if;

                            --case opcode(5 downto 3) is

                            --    when "010" =>

                            --        --err_z <= err_z_t and '1';
                            --        report "mul" & std_logic'image(err_z_t);

                            --    when "011" =>

                            --        report "div" & std_logic'image(err_z_t);

                            --    when "100" =>

                            --        report "log" & std_logic'image(err_z_t);

                            --    when others =>

                            --        report "na " & std_logic'image(err_z_t);

                            --end case;

                            -- address = element
                            mem_addr <= opand2;

                            state <= op2_state;

                        when op2_state =>

                            zero_mem_t <= opcode(1);

                            -- if operand 2 is in polynomial form
                            if (opcode(1) = '1') then

                                -- j is converted to element
                                j <= mem_data;

                                -- check mem_data for out-of-bound exceptions
                                bd_opand <= mem_data;
                                zero_opand <= mem_data;

                            -- if operand 2 is in element form
                            else

                                -- j is the user input
                                j <= opand2;
                                zero_opand <= opand2;

                                -- check operand 2 for out-of-bound exceptions
                                bd_opand <= opand2;

                            end if;

                            state <= op1_state;

                        when others =>

                            -- address = polynomial
                            mem_addr <= opand1;

                            -- state initializes to op1_state
                            state <= op1_state;

                    end case;

                ---- div
                --when "011" =>

                --    -- disable generator
                --    en_gen <= '0';
                --    rst_gen <= '0';

                --    -- read from memory to convert polynomial to element
                --    mem_rd <= '1';

                --    -- mem2, addr = element, data = polynomial
                --    mem_t <= '0';

                --    case state is

                --        when op1_state =>

                --            zero_mem_t <= opcode(2);

                --            -- if operand 1 is in polynomial form
                --            if (opcode(2) = '1') then

                --                -- i is converted to element
                --                i <= mem_data;

                --                -- check mem_data for out-of-bound exceptions
                --                bd_opand <= mem_data;
                --                zero_opand <= mem_data;

                --            -- if operand 1 is in element form
                --            else

                --                -- i is the user input
                --                i <= opand1;

                --                -- check operand 1 for out-of-bound exceptions
                --                bd_opand <= opand1;
                --                zero_opand <= opand1;

                --            end if;

                --            -- address = element
                --            mem_addr <= opand2;

                --            state <= op2_state;

                --        when op2_state =>

                --            zero_mem_t <= opcode(1);

                --            -- if operand 2 is in polynomial form
                --            if (opcode(1) = '1') then

                --                -- j is converted to element
                --                j <= mem_data;

                --                -- check mem_data for out-of-bound exceptions
                --                bd_opand <= mem_data;
                --                zero_opand <= mem_data;

                --            -- if operand 2 is in element form
                --            else

                --                -- j is the user input
                --                j <= opand2;

                --                -- check operand 2 for out-of-bound exceptions
                --                bd_opand <= opand2;
                --                zero_opand <= opand2;

                --            end if;

                --            state <= op1_state;

                --        when others =>

                --            -- address = polynomial
                --            mem_addr <= opand1;

                --            -- state initializes to op1_state
                --            state <= op1_state;

                --    end case;

                ---- log
                --when "100" =>

                --    -- disable generator
                --    en_gen <= '0';
                --    rst_gen <= '0';

                --    case state is

                --        when op1_state =>

                --            -- enable zero exception
                --            en_zero <= '1';
                --            zero_opand <= opand1;

                --            -- if operand 1 is in polynomial form
                --            if (opcode(2) = '1') then

                --                -- i is converted to element
                --                i <= mem_data;

                --                -- check mem_data for out-of-bound exceptions
                --                bd_opand <= mem_data;

                --            -- if operand 1 is in element form
                --            else

                --                -- i is the user input
                --                i <= opand1;

                --                -- check operand 1 for out-of-bound exceptions
                --                bd_opand <= opand1;

                --            end if;

                --            -- read from memory to convert polynomial to
                --            -- element
                --            mem_rd <= '1';

                --            -- mem2, addr = element, data = polynomial
                --            mem_t <= '0';

                --            state <= op1_state;

                --        when others =>

                --            -- read from memory to convert polynomial to
                --            -- element
                --            mem_rd <= '1';

                --            -- mem1, addr = polynomial, data = element
                --            mem_t <= '0';

                --            -- address = polynomial
                --            mem_addr <= opand1;

                --            -- state initializes to op1_state
                --            state <= op1_state;

                --    end case;

                -- reset
                when "101" =>

                    -- reset generator
                    en_gen <= '1';
                    rst_gen <= '1';

                    -- disable arithmetic exceptions
                    bd_opand <= "XXXXXXXXXXXXXXXX";
                    zero_opand <= "XXXXXXXXXXXXXXXX";

                    -- disable memory lookup
                    mem_t <= 'X';
                    mem_rd <= '0';
                    mem_addr <= "XXXXXXXXXXXXXXXX";

                -- mode
                when "110" =>

                    -- disable generator
                    en_gen <= '0';
                    rst_gen <= '0';

                    -- disable arithmetic exceptions
                    bd_opand <= "XXXXXXXXXXXXXXXX";
                    zero_opand <= "XXXXXXXXXXXXXXXX";

                    -- disable memory lookup
                    mem_t <= 'X';
                    mem_rd <= '0';
                    mem_addr <= "XXXXXXXXXXXXXXXX";

                when "111" =>  -- nop

                    -- disable generator
                    en_gen <= '0';
                    rst_gen <= '0';

                    -- disable arithmetic exceptions
                    bd_opand <= "XXXXXXXXXXXXXXXX";
                    zero_opand <= "XXXXXXXXXXXXXXXX";

                    -- disable memory lookup
                    mem_t <= 'X';
                    mem_rd <= '0';
                    mem_addr <= "XXXXXXXXXXXXXXXX";

                when others =>

                    -- disable generator
                    en_gen <= '0';
                    rst_gen <= '0';

                    -- disable arithmetic exceptions
                    bd_opand <= "XXXXXXXXXXXXXXXX";
                    zero_opand <= "XXXXXXXXXXXXXXXX";

                    -- disable memory lookup
                    mem_t <= 'X';
                    mem_rd <= '0';
                    mem_addr <= "XXXXXXXXXXXXXXXX";

            end case;

        end if;

    end process;

end structural;
