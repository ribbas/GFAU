-- control_unit
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity control_unit is
    port(
        clk         : in std_logic;
        rst         : in std_logic;
        opcode      : in std_logic_vector(5 downto 0);   -- op code
        op1         : in std_logic_vector(15 downto 0);   -- operand 1
        op2         : in std_logic_vector(15 downto 0);   -- operand 2

        -- generation signals
        en_gen      : out std_logic;  -- polynomial generator enable

        -- operation signals
        i           : out std_logic_vector(15 downto 0);  -- i
        j           : out std_logic_vector(15 downto 0);  -- j

        -- memory signals
        mem_data    : in std_logic_vector(15 downto 0);  -- data from memory
        mem_addr    : out std_logic_vector(15 downto 0);  -- address in memory
        mem_t       : out std_logic;  -- which memory - 0 for elem, 1 for poly
        mem_rd      : out std_logic  -- read signal to memory
    );
end control_unit;

architecture structural of control_unit is

    type state_type is (op1_state, op2_state);  -- define the states
    signal state : state_type;
    signal temp_data : std_logic_vector(15 downto 0);  -- mem_data from memory

begin

    process (clk, opcode) begin

        if (rising_edge(clk)) then

            case opcode(5 downto 3) is  -- instruction bits

                -- intiate polynomial generator
                when "000" =>

                    -- enable generator
                    en_gen <= '1';

                    -- disable memory lookup
                    mem_t <= 'X';
                    mem_rd <= '0';
                    mem_addr <= "XXXXXXXXXXXXXXXX";

                when "001" =>  -- add/sub

                    -- disable generator
                    en_gen <= '0';

                    case state is

                        when op1_state =>

                            -- if input1 is in element form
                            if (opcode(2) = '0') then

                                -- i is converted to polynomial
                                i <= mem_data;

                            -- if input1 is in polynomial form
                            else

                                -- i is the user input
                                i <= op1;

                            end if;

                            -- read from memory to convert element to
                            -- polynomial
                            mem_rd <= '1';

                            -- mem2, addr = element, data = polynomial
                            mem_t <= '1';

                            -- address = element
                            mem_addr <= op2;

                            state <= op2_state;

                        when op2_state =>

                            -- if input2 is in element form
                            if (opcode(1) = '0') then

                                -- j is converted to polynomial
                                j <= mem_data;

                            -- if input1 is in polynomial form
                            else

                                -- i is the user input
                                j <= op2;

                            end if;

                            state <= op1_state;

                        when others =>

                            -- read from memory to convert element to
                            -- polynomial
                            mem_rd <= '1';

                            -- mem2, addr = element, data = polynomial
                            mem_t <= '1';

                            -- address = element
                            mem_addr <= op1;

                            -- state initializes to op1_state
                            state <= op1_state;

                    end case;

                when "010" | "011" | "100" =>  -- mul, div, log

                    -- disable generator
                    en_gen <= '0';

                    case state is

                        when op1_state =>

                            -- if input1 is in polynomial form
                            if (opcode(2) = '1') then

                                -- i is converted to element
                                i <= mem_data;

                            -- if input1 is in element form
                            else

                                -- i is the user input
                                i <= op1;

                            end if;

                            -- read from memory to convert polynomial to
                            -- element
                            mem_rd <= '1';

                            -- mem2, addr = element, data = polynomial
                            mem_t <= '0';

                            -- address = element
                            mem_addr <= op2;

                            state <= op2_state;

                        when op2_state =>

                            -- if input2 is in polynomial form
                            if (opcode(1) = '1') then

                                -- j is converted to element
                                j <= mem_data;

                            -- if input1 is in element form
                            else

                                -- i is the user input
                                j <= op2;

                            end if;

                            state <= op1_state;

                        when others =>

                            -- read from memory to convert polynomial to
                            -- element
                            mem_rd <= '1';

                            -- mem1, addr = polynomial, data = element
                            mem_t <= '0';

                            -- address = polynomial
                            mem_addr <= op1;

                            -- state initializes to op1_state
                            state <= op1_state;

                    end case;

                when "101" =>  -- reset

                    -- disable generator
                    en_gen <= '0';

                    -- disable memory lookup
                    mem_t <= 'X';
                    mem_rd <= '0';
                    mem_addr <= "XXXXXXXXXXXXXXXX";

                when "110" =>  -- mode

                    -- disable generator
                    en_gen <= '0';

                    -- disable memory lookup
                    mem_t <= 'X';
                    mem_rd <= '0';
                    mem_addr <= "XXXXXXXXXXXXXXXX";

                when "111" =>  -- nop

                    -- disable generator
                    en_gen <= '0';

                    -- disable memory lookup
                    mem_t <= 'X';
                    mem_rd <= '0';
                    mem_addr <= "XXXXXXXXXXXXXXXX";

                when others =>

                    -- disable generator
                    en_gen <= '0';

                    -- disable memory lookup
                    mem_t <= 'X';
                    mem_rd <= '0';
                    mem_addr <= "XXXXXXXXXXXXXXXX";

            end case;

        end if;
        
    end process;

end structural;
