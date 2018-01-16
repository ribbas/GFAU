-- top_tb.vhd
--
-- Sabbir Ahmed
-- 2018-01-16
--

library ieee;
use ieee.std_logic_1164.all;
 
entity top_tb is
end top_tb;
 
architecture behavior of top_tb is 
 
    component top
        port(
            CLK     : in std_logic;
            RST     : in std_logic;
            POLYBCD : in std_logic_vector(15 downto 0);
            OPCODE  : in std_logic_vector(5 downto 0);
            OPAND1  : in std_logic_vector(15 downto 0);
            OPAND2  : in std_logic_vector(15 downto 0);
            RESULT  : out std_logic_vector(15 downto 0);
            RDYGEN  : out std_logic;
            ERRB    : out std_logic;
            ERRZ    : out std_logic

            -------------- TEMPORARY - JUST FOR TB ------------

            ---- universal registers
            --t_n         : out std_logic_vector(3 downto 0);
            --t_m         : out std_logic_vector(3 downto 0);
            --t_mask      : out std_logic_vector(15 downto 0);

            ---- generated terms
            --t_addr      : out std_logic_vector(15 downto 0);
            --t_sym       : out std_logic_vector(15 downto 0)
        );
    end component;

    --inputs
    signal CLK     : std_ulogic := '1';
    signal RST     : std_logic;
    signal POLYBCD : std_logic_vector(15 downto 0);
    signal OPCODE  : std_logic_vector(5 downto 0);
    signal OPAND1  : std_logic_vector(15 downto 0);
    signal OPAND2  : std_logic_vector(15 downto 0);

    -- outputs
    signal RESULT  : std_logic_vector(15 downto 0);
    signal RDYGEN  : std_logic;
    signal ERRB    : std_logic;
    signal ERRZ    : std_logic;

    -------------- TEMPORARY - JUST FOR TB ------------

    ---- universal registers
    --signal t_n : std_logic_vector(3 downto 0);
    --signal t_m : std_logic_vector(3 downto 0);
    --signal t_mask : std_logic_vector(15 downto 0);

    ---- memory signals
    --signal t_addr : std_logic_vector(15 downto 0);
    --signal t_sym : std_logic_vector(15 downto 0);

    -- testbench clocks
    constant t_nums : integer := 320;
 
begin
 
    -- instantiate the unit under test (uut)
    uut: top port map (
        CLK => CLK,
        RST => RST,
        POLYBCD => POLYBCD,
        OPCODE => OPCODE,
        OPAND1 => OPAND1,
        OPAND2 => OPAND2,
        RESULT => RESULT,
        RDYGEN => RDYGEN,
        ERRB => ERRB,
        ERRZ => ERRZ

        -- TEMPORARY SIGNALS
        --RST => RST,
        --t_n => t_n,
        --t_m => t_m,
        --t_mask => t_mask,
        --t_addr => t_addr,
        --t_sym => t_sym
    );

    -- clock process
    CLK_proc: process
    begin

        for i in 1 to t_nums loop
            CLK <= not CLK;
            wait for 10 ns;
            -- clock period = 50 MHz
        end loop;

    end process;

    -- stimulus process
    stim_proc: process
        begin    

        POLYBCD <= "0000000000011001";
        RST <= '1';

        OPAND1 <= "0000000000001001";
        OPAND2 <= "0000000000001100";

        wait for 20 ns;

        RST <= '0';

        -- hold reset state for 40 ns.
        wait for 40 ns;

        -- add/sub
        OPCODE <= "111110";

        -- hold reset state for 40 ns.
        wait for 60 ns;

        -- add/sub
        OPCODE <= "001110";

        -- hold reset state for 40 ns.
        wait for 60 ns;

        -- mul
        OPCODE <= "010000";

        -- hold reset state for 40 ns.
        wait for 60 ns;

        -- div
        OPCODE <= "001110";

        -- hold reset state for 40 ns.
        wait for 60 ns;

        -- log
        OPCODE <= "001000";

        -- hold reset state for 40 ns.
        wait for 60 ns;

        -- convert
        OPCODE <= "000111";

        -- hold reset state for 40 ns.
        wait for 160 ns;

        -- convert
        OPCODE <= "111111";

        wait for 1000 ns;

        -- stop simulation
        assert false report "simulation ended" severity failure;

    end process;

end;
