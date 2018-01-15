
-- control_unit_old.vhd

-- Sabbir Ahmed
-- 2018-01-14


-- control_unit
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity control_unit is
    port(
        clk         : in std_logic;  -- clock for counter
        op          : in std_logic_vector(5 downto 0);   -- op code
        m1          : in std_logic_vector(15 downto 0);  -- first operand
        m2          : in std_logic_vector(15 downto 0);  -- second operand
        -- bidirectional bus for accessing memory
        m           : inout std_logic_vector(15 downto 0);
        gen_term    : out std_logic;  -- poly generation
        enable      : out std_logic;  -- enable demux to enable memory 
        sel         : out std_logic;  -- select the correct memory chip 
        -- converted value for m1
        m1_out      : out std_logic_vector(15 downto 0);
        -- converted value for m2
        m2_out      : out std_logic_vector(15 downto 0);
        A           : out std_logic_vector(15 downto 0);
        nADSP       : out std_logic;
        nADSC       : out std_logic;
        nADV        : out std_logic;
        nBW         : out std_logic_vector(3 downto 0);
        nBWE        : out std_logic;
        nGW         : out std_logic;
        nCE         : out std_logic;
        nCE2        : out std_logic;
        CE2         : out std_logic;
        nOE         : out std_logic;
        DQ          : inout std_logic_vector(31 downto 0);
        MODE        : out std_logic;
        ZZ          : out std_logic
    );
end control_unit;

architecture structural of control_unit is

    signal s_a      : std_logic_vector(15 downto 0);
    signal s_clk    : std_logic := '0';
    signal n_NADSP  : std_logic;
    signal n_NADSC  : std_logic;
    signal s_nADV   : std_logic;
    signal s_nBW    : std_logic_vector(3 downto 0);
    signal s_nBWE   : std_logic;
    signal s_nGW    : std_logic;
    signal s_nce    : std_logic;
    signal s_nCE2   : std_logic;
    signal s_ce2    : std_logic;
    signal s_nOE    : std_logic;
    signal s_DQ     : std_logic_vector(31 downto 0);
    signal s_MODE   : std_logic;
    signal s_ZZ     : std_logic;
    signal counter  : std_logic_vector(0 to 2) := "000";

begin

    process (op, clk) begin

        if (rising_edge(clk)) then
            counter <= counter + 1;
        end if;

        case op(5 downto 3) is 

            when "000" => 

                gen_term <= '1';
                m <= "UUUUUUUUUUUUUUUU";

            when "001" | "010" | "011" | "100" =>  -- add, sub, mul, div

                if counter = "100" then -- reset counter 
                    counter <= "000";
                end if;

                -- memory control signal for write 
                nCE <= '0';
                nCE2 <= '0';
                CE2 <= '1';
                ZZ <= '0';
                nADSP <= '1';
                nADSC <= '0';
                nBWE <= '0';

                enable <= '1';  --enable mux
                gen_term <= '0';

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
        
    end process;

end structural;
