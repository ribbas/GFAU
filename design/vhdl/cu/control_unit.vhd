-- control_unit
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity control_unit is
    port(
        clk     : in std_logic;
        rst     : in std_logic;
        opcode  : in std_logic_vector(5 downto 0);   -- op code
        op1     : in std_logic_vector(15 downto 0);   -- op code
        op2     : in std_logic_vector(15 downto 0);   -- op code
        en_gen  : out std_logic;  -- poly generation
        i       : out std_logic_vector(15 downto 0);  -- address in memory
        j       : out std_logic_vector(15 downto 0);  -- address in memory
        mem     : out std_logic;  -- which memory - 0 for elem, 1 for poly
        mem_rd  : out std_logic;  -- read signal to memory
        addr    : out std_logic_vector(15 downto 0);  -- address in memory
        data    : inout std_logic_vector(31 downto 0)  -- data from memory
    );
end control_unit;

architecture structural of control_unit is

    type state_type is (init_state, op1_state, op2_state);  -- define the states
    signal state : state_type;

begin

    process (clk, opcode) begin

        if (rising_edge(clk)) then

            case opcode(5 downto 3) is 

                when "000" => 

                    en_gen <= '1';
                    mem <= 'X';
                    mem_rd <= '0';
                    addr <= "UUUUUUUUUUUUUUUU";
                    data <= "UUUUUUUUUUUUUUUU";

                when "001" | "010" | "011" | "100" =>  -- add, sub, mul, div

                    case state is

                        when init =>

                            mem_rd <= '1';
                            mem <= opcode(2);
                            addr <= op1;


                    if counter = 1 then  -- set output m1_out to converted value  
                        m1_out <= m;
                    else
                        m1_out <= "UUUUUUUUUUUUUUUU";
                    end if;

                    if counter = 3 then  -- set ouput m2_out to conerted value
                        m2_out <= m;
                    else
                        m2_out <= "UUUUUUUUUUUUUUUU";
                    end if;

                    -- first two cycles for m1
                    if (counter = 0) or (counter = 1) or (counter = 4) then
                        m <= m1;
                        if op(2) = '0' then  -- if m1 is in exponent form 
                            -- select mem1 to convert from exponent to polynomial
                            sel <= '0';
                        else
                            -- select mem2 to convert from polynomial to exponent
                            sel <= '1';
                        end if;
                    
                    -- second two cycles for m2
                    elsif (counter = 2) or (counter = 3) then
                        m <= m2;
                        if op(1) = '0' then -- if m2 is in exponent form  
                            -- select mem2 to convert from exponent to polynomial
                            sel <= '0';
                        else
                            -- select mem1 to convert from polynomial to exponent
                            sel <= '1';
                        end if;
                    end if;

                when others => 
                    gen_term <= '0';
                    enable <= '0';
                    m <= "UUUUUUUUUUUUUUUU";

            end case;

        end if;
        
    end process;

end structural;
