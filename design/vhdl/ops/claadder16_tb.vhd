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
            cin     : in std_logic;
            s       : out std_logic_vector(15 downto 0);
            cout    : out std_logic
        );
    end component;

    --inputs
    signal a : std_logic_vector(15 downto 0) := (others => '0');
    signal b : std_logic_vector(15 downto 0) := (others => '0');
    signal cin : std_logic := '0';

    --outputs
    signal s : std_logic_vector(15 downto 0);
    signal cout : std_logic;

begin

    -- instantiate the unit under test (uut)
    uut: claadder16 port map(
        a => a,
        b => b,
        cin => cin,
        s => s,
        cout => cout
    );

    -- stimulus process
    stim_proc: process
    begin
        -- hold reset state for 100 ns.
        wait for 10 ns;

        a <= "0000001000000000";
        b <= "0000010000000000";
        cin <= '0';

        --wait for 10 ns;

        --a <= "1010";
        --b <= "0111";
        --cin <= '0';

        --wait for 10 ns;

        --a <= "1000";
        --b <= "1001";
        --cin <= '0';

        wait;

    end process;

end;
