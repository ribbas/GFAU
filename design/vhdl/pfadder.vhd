library ieee;
use ieee.std_logic_1164.all;

entity pfadder is
    port(
        a   : in std_logic;
        b   : in std_logic;
        cin : in std_logic;
        s   : out std_logic;
        p   : out std_logic;
        g   : out std_logic
    );
end pfadder;

architecture structural of pfadder is

    component xor2
        port(
            in1     :   in  std_logic;
            in2     :   in  std_logic;
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

    signal w1   :   std_logic;

begin

    xor2_1  :   xor2 port map(a, b, w1);
    xor2_2  :   xor2 port map(w1, cin, s);
    p <= w1;
    and2_1  :   and2 port map(a, b, g);

end structural;