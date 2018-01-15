
-- claadder4.vhd

-- Sabbir Ahmed
-- 2018-01-14


library ieee;
use ieee.std_logic_1164.all;

entity claadder4 is
    port(
        a       : in std_logic_vector(3 downto 0);
        b       : in std_logic_vector(3 downto 0);
        cin     : in std_logic;
        s       : out std_logic_vector(3 downto 0);
        cout    : out std_logic
    );
end claadder4;

architecture structural of claadder4 is

    component pfadder
        port(
            a   : in std_logic;
            b   : in std_logic;
            cin : in std_logic;
            s   : out std_logic;
            p   : out std_logic;
            g   : out std_logic
        );
    end component;

    signal c1, c2, c3: std_logic;
    signal p, g: std_logic_vector(3 downto 0);

begin

    pfa1 : pfadder port map(a(0), b(0), cin, s(0), p(0), g(0));
    pfa2 : pfadder port map(a(1), b(1), c1, s(1), p(1), g(1));
    pfa3 : pfadder port map(a(2), b(2), c2, s(2), p(2), g(2));
    pfa4 : pfadder port map(a(3), b(3), c3, s(3), p(3), g(3));

    c1 <=   g(0) or
            (p(0) and cin);
    c2 <=   g(1) or
            (p(1) and g(0)) or
            (p(1) and p(0) and cin);
    c3 <=   g(2) or
            (p(2) and g(1)) or
            (p(2) and p(1) and g(0)) or
            (p(2) and p(1) and p(0) and cin);
    cout <= g(3) or
            (p(3) and g(2)) or
            (p(3) and p(2) and g(1)) or
            (p(3) and p(2) and p(1) and g(0)) or
            (p(3) and p(2) and p(1) and p(0) and cin);

end structural;
