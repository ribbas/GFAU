library ieee;
use ieee.std_logic_1164.all;

entity claadder4 is
    port(
        a       : in std_logic_vector (3 downto 0);
        b       : in std_logic_vector (3 downto 0);
        cin     : in std_logic;
        s       : out std_logic_vector (3 downto 0);
        cout    : out std_logic
    );
end claadder4;

architecture structural of claadder4 is

    component or2
        port(
            in1     :   in  std_logic;
            in2     :   in  std_logic;
            out1    :   out std_logic
        );
    end component;

    component or3
        port(
            in1     :   in  std_logic;
            in2     :   in  std_logic;
            in3     :   in  std_logic;
            out1    :   out std_logic
        );
    end component;

    component and2
        port(
            in1     :   in  std_logic;
            in2     :   in  std_logic;
            out1    :   out std_logic
        );
    end component;

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
 
    signal  c1, c2, c3: std_logic;
    signal  c1_1,
            c2_1, c2_2,
            c3_1, c3_2, c3_3, c3_4, c3_5,
            c4_1, c4_2, c4_3, c4_4, c4_5, c4_6: std_logic;
    signal  p, g: std_logic_vector(3 downto 0);

begin

    pfa1    :   pfadder port map(a(0), b(0), cin, s(0), p(0), g(0));
    pfa2    :   pfadder port map(a(1), b(1), c1, s(1), p(1), g(1));
    pfa3    :   pfadder port map(a(2), b(2), c2, s(2), p(2), g(2));
    pfa4    :   pfadder port map(a(3), b(3), c3, s(3), p(3), g(3));

    and2_1  :   and2 port map(p(0), cin, c1_1);  -- p0 and cin = (1)
    or2_1   :   or2 port map(g(0), c1_1, c1);  -- g0 or (1) = (2)

    and2_2  :   and2 port map(p(1), g(0), c2_1);  -- p1 and g0 = (3)
    and2_3  :   and2 port map(p(1), c1_1, c2_2);  -- p1 and (1) = (4)
    or3_1   :   or3 port map(g(1), c2_1, c2_2, c2);  -- g1 or (4) or (3) = (5) 

    and2_4  :   and2 port map(p(2), g(1), c3_1);  -- p2 and g1 = (6)
    and2_5  :   and2 port map(p(2), c2_1, c3_2);  -- p2 and (3) = (7)
    and2_6  :   and2 port map(p(2), c2_2, c3_3);  -- p2 and (4) = (8)
    or2_2   :   or2 port map(c3_2, c3_3, c3_4);  -- (7) or (8) = (9)
    or2_3   :   or2 port map(g(2), c3_1, c3_5);  -- g2 or (6) = (10)
    or2_4   :   or2 port map(c3_4, c3_5, c3);  -- (9) or (10) = (11)

    and2_7  :   and2 port map(p(3), g(2), c4_1);  -- p3 and g2 = (12)
    and2_8  :   and2 port map(p(3), c3_1, c4_2);  -- p3 and (6) = (13)
    and2_9  :   and2 port map(p(3), c3_2, c4_3);  -- p3 and (7) = (14)
    and2_10 :   and2 port map(p(3), c3_3, c4_4);  -- p3 and (8) = (15)
    or3_2   :   or3 port map(c4_4, c4_3, c4_2, c4_5);  -- (15) or (14) or (13)
                                                       -- = (16)
    or2_5   :   or2 port map(g(3), c4_1, c4_6);  -- (g3) or (12) = (17)
    or2_6   :   or2 port map(c4_5, c4_6, cout);  -- (16) or (17) = (18)

end structural;
