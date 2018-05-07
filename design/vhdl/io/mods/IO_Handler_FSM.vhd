----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:24:53 05/03/2018 
-- Design Name: 
-- Module Name:    IO_Handler - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
-------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity IO_Handler_FSM is
port(

--============================================================================--
    --***External Signals***--
--============================================================================--

    --signals from/to extern device
    opcode_in   :   in      std_logic_vector(5 downto 0);
    Start       :   in      std_logic;
    --Done        :   in      std_logic;
    t_clk       :   in      std_logic;
    g_rst       :   in      std_logic;
    ready_sig   :   out     std_logic; --ready1 xnor ready2

    --interrupts
    INT         :   out     std_logic; --generate interrupt
    INTA        :   in      std_logic; --interrupt accepted

    --signals from/to gfau
    clk         :   in      std_logic;
    op_done     :   in      std_logic; --data from gfau ready
    opcode_out  :   out     std_logic_vector(5 downto 0);
    data_ready  :   out     std_logic; --data from extern dev ready
    rst         :   out     std_logic; --internal reset
    gen_rdy     :   in      std_logic; --field finished generating
    --gen_rst     :   out     std_logic; --resets gen_rdy signal

--============================================================================--
    --***IO Handler internal signals***--
--============================================================================--

    --serialize/deserialze--
    serial_e    :   out     std_logic := '0'; --serializer enable 
    serial_r    :   out     std_logic := '1'; --serialize reset
    serial_d    :   in      std_logic; --serialization of data done
    deserial_e  :   out     std_logic := '0'; --deserializer enable
    deserial_r  :   out     std_logic := '1'; --deserializer reset
    deserial_d  :   in      std_logic; --deserialization of data done
    mode_wr     :   out     std_logic; --writes mode bits

    --count_decoder
    poly_get    :   out     std_logic; --signal for mux that lets it know only 
                                       --one input is needed
    --counter--
    count_rst   :   out     std_logic := '0'; --reset signal for counter
    
    --error signals--
    z_err       :   in      std_logic; --zero error
    oob_err     :   in      std_logic  --out of bounds error
);
end IO_Handler_FSM;

architecture Behavioral of IO_Handler_FSM is

    --type IO_state is   (ready, get_mode, set_poly_ctl, set_norm_ctl, get_input,
    --                    gen, op, send_result, INT0, INT1);  

    --signal state    :   IO_state := ready; 
    signal poly_gen :   std_logic := '0'; --internal flag used to determine op
    signal wr_reg   :   std_logic := '0'; --register that leads to wr_mode so it can
                                   --easily be turned off after one cycle
    signal wr_reg2  :   std_logic := '0';

    --====================================--
    --state(0)  :   ready       00000001  --
    --state(1)  :   get_input   00000010  --
    --state(2)  :   gen         00000110  --
    --state(3)  :   op          00001010  --
    --state(4)  :   INT0        00010000  --
    --state(5)  :   INT1        00100000  --
    --state(6)  :   INT2        01000000  --
    --state(7)  :   send_output 10000000  --
    --====================================--

    signal state    :   std_logic_vector(7 downto 0);
    signal s_state  :   std_logic_vector(7 downto 0) := "00000000";
    signal n_state  :   std_logic_vector(7 downto 0) := "00000000";
    

    --ready signals--
    signal ready    :   std_logic;


    --interrupt signals--
    signal op_INT   :   std_logic := '0';
    signal gen_INT  :   std_logic := '0';
    signal err_INT  :   std_logic := '0';
    signal nop_INT  :   std_logic := '0';
    signal ngen_INT :   std_logic := '0';
    signal nerr_INT :   std_logic := '0';
    signal xop_INT  :   std_logic;
    signal xgen_INT :   std_logic;
    signal xerr_INT :   std_logic;

begin

    mode_wr <= wr_reg;
    rst <= g_rst;
    poly_get <= poly_gen;
    
    ready <= s_state(0) xnor n_state(0);
    ready_sig <= ready;

    xop_INT <= op_INT xor nop_INT;
    xgen_INT <= gen_INT xor ngen_INT;
    xerr_INT <= err_INT xor nerr_INT;

    state(7 downto 1) <= s_state(7 downto 1) xor n_state(7 downto 1);
    state(0) <= s_state(0) xnor n_state(0);

    INT <= xop_INT or xgen_INT or xerr_INT;

    comm        :   process(t_clk)
    begin
        if rising_edge(t_clk) then
            if g_rst = '1' then
                deserial_e <= '0';
                deserial_r <= '1';
                serial_e <= '0';
                serial_r <= '1';
                s_state(3 downto 0) <= "0000";
                s_state(7) <= '0';
                n_state(7 downto 4) <= "0000";
                n_state(0) <= '0';
                nop_INT <= '0';
                ngen_INT <= '0';
                nerr_INT <= '0';
            else
                case state is
                
                    --====================================--
                    --io handler is ready to get input    --
                    --====================================--
                    when "00000001" =>
                        if wr_reg = '1' then
                            wr_reg <= '0';
                        --elsif wr_reg = '1' and wr_reg2 = '1' then
                        --    wr_reg <= '0';
                        --    wr_reg <= '0';
                        end if;
                        if Start = '1' then --extern dev giving op
                            if opcode_in(5 downto 3) = "110" then --set mode
                                wr_reg <= '1';
                            elsif opcode_in(5 downto 3) = "000" then --gen field
                                opcode_out <= opcode_in;
                                poly_gen <= '1';
                                deserial_e <= '1';
                                deserial_r <= '0';
                                s_state(1) <= not s_state(1); --get input
                                n_state(0) <= not n_state(0); --not ready
                            else --normal operation
                                opcode_out <= opcode_in;
                                poly_gen <= '0';
                                deserial_e <= '1';
                                deserial_r <= '0';
                                s_state(1) <= not s_state(1); --get input
                                n_state(0) <= not n_state(0); --not ready
                            end if;
                        end if;
                        
                    --====================================--
                    --get input from extern dev           --
                    --====================================--
                    when "00000010"=>
                        if deserial_d = '1' then --data is received
                            if poly_gen = '1' then
                                s_state(2) <= not s_state(2); --set gen state bit
                                deserial_e <= '0';
                                deserial_r <= '1';
                            else
                                s_state(3) <= not s_state(3); --set op state bit
                                deserial_e <= '0';
                                deserial_r <= '1';
                            end if;
                        end if;
                        
                    --====================================--
                    --wait for CPU to be ready for data   --
                    --====================================--
                    when "00010000" =>
                        if INTA = '1' then
                            nop_INT <= not nop_INT; --unset INT
                            serial_e <= '1'; --start serializer
                            serial_r <= '0';
                            n_state(4) <= not n_state(4); --unset int state
                            s_state(7) <= not s_state(7); --set wait for send state
                        end if;

                    --====================================--
                    --wait for cpu to acknowledge int     --
                    --====================================--
                    when "00100000" =>
                        if INTA = '1' then
                            ngen_INT <= not ngen_INT; --unset INT
                            --gen_rst <= '1';
                            n_state(5) <= not n_state(5); -- unset int state
                            s_state(0) <= not s_state(0); --set ready
                        end if;

                    --====================================--
                    --wait for cpu to acknowledge error   --
                    --====================================--
                    when "01000000" =>
                        if INTA = '1' then
                            nerr_INT <= not nerr_INT; --unset_INT
                            n_state(6) <= not n_state(6); --unset int state
                            s_state(0) <= not s_state(0); --set ready
                        end if;
                    
                    --====================================--
                    --wait for data to be sent            --
                    --====================================--
                    when "10000000" =>
                        if serial_d = '1' then
                            serial_e <= '0';
                            serial_r <= '1';
                            n_state(7) <= not n_state(7);
                            s_state(0) <= not s_state(0); --set ready
                        end if;
                    when others =>
                        --do nothing will never happen
                end case;
            end if;
        end if;
    end process comm;

    internal    :   process(clk)
    begin
        if rising_edge(clk) then
            if g_rst = '1'then
                gen_INT <= '0';
                op_INT <= '0';
                err_INT <= '0';
                n_state(3 downto 1) <= "000";
                s_state(6 downto 4) <= "000";
            else
                case state is 

                    --====================================--
                    --wait for operation to complete      --
                    --====================================--
                    when "00001010" =>
                        if op_done = '1' then
                            op_INT <= not op_INT; --set op interrupt
                            n_state(3) <= not n_state(3);
                            n_state(1) <= not n_state(1); 
                            s_state(4) <= not s_state(4); --set int0
                        elsif (oob_err or z_err) = '1' then
                            err_INT <= not err_INT; --set error interrupt
                            n_state(3) <= not n_state(3);
                            n_state(1) <= not n_state(1);
                            s_state(6) <= not s_state(6); --set int2
                        end if;

                    --====================================--
                    --wait for field generation to finish --
                    --====================================--
                    when "00000110" =>
                        if gen_rdy = '1' then
                            gen_INT <= not gen_INT; --set gen interrupt
                            n_state(2) <= not n_state(2);
                            n_state(1) <= not n_state(1);
                            s_state(5) <= not s_state(5); --set int1
                        end if;

                    when others =>
                        --do nothing will never happen
                end case;
            end if;
        end if;
    end process internal;
    
end Behavioral;