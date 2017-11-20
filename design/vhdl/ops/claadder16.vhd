library ieee;
use ieee.std_logic_1164.all;

entity claadder16 is
    port(
        a       : in std_logic_vector (15 downto 0);
        b       : in std_logic_vector (15 downto 0);
        cin     : in std_logic;
        s       : out std_logic_vector (15 downto 0);
        cout    : out std_logic
    );
end claadder16;

architecture structural of claadder16 is

    component cladder4
        port(
            a       : in std_logic_vector (3 downto 0);
            b       : in std_logic_vector (3 downto 0);
            cin     : in std_logic;
            s       : out std_logic_vector (3 downto 0);
            cout    : out std_logic
        );
    end component;
 
    signal  c1, c2, c3: std_logic;

begin

    cla1    :   cladder4 port map(
                    a(15 downto 12),
                    b(15 downto 12),
                    cin,
                    s(15 downto 12),
                    c1
                );

    cla2    :   cladder4 port map(
                    a(11 downto 8),
                    b(11 downto 8),
                    c1,
                    s(11 downto 8),
                    c2
                );

    cla3    :   cladder4 port map(
                    a(7 downto 4),
                    b(7 downto 4),
                    c2,
                    s(7 downto 4),
                    c3
                );

    cla4    :   cladder4 port map(
                    a(3 downto 0),
                    b(3 downto 0),
                    c3,
                    s(3 downto 0),
                    cout
                );

end structural;
