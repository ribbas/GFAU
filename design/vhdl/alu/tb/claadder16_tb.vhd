
-- claadder16_tb.vhd

-- Sabbir Ahmed
-- 2018-01-14


library ieee;
use ieee.std_logic_1164.all;

entity claadder16_tb is
end claadder16_tb;

architecture behavioral of claadder16_tb is

    -- component declaration for the unit under test (uut)     
    component claadder16
        port(
            a       : in std_logic_vector(15 downto 0);
            b       : in std_logic_vector(15 downto 0);
            s       : out std_logic_vector(15 downto 0)
        );
    end component;

    --inputs
    signal a : std_logic_vector(15 downto 0) := (others => '0');
    signal b : std_logic_vector(15 downto 0) := (others => '0');

    --outputs
    signal s : std_logic_vector(15 downto 0);

begin

    -- instantiate the unit under test (uut)
    uut: claadder16 port map(
        a => a,
        b => b,
        s => s
    );

    -- stimulus process
    stim_proc: process
    begin
        -- hold reset state for 100 ns.
        wait for 10 ns;

        a <= "1111111111111111";
        b <= "1111111111111111";

        wait;

    end process;

end;
