-- reducible.vhd
--
-- Brian Weber
-- 2018-01-16
--

library std;
library ieee;
use ieee.std_logic_1164.all;

entity reducible is
    port(
        poly_bcd        : in std_logic_vector(15 downto 0);  -- BCD polynomial
        is_reducible    : out std_logic
    );
end reducible;

architecture structural of reducible is

    component xor2
        port(
            in1     : in std_logic;
            in2     : in std_logic;
            out1    : out std_logic
        );
    end component;

    component and2
        port(
            in1     : in std_logic;
            in2     : in std_logic;
            out1    : out std_logic
        );
    end component;

    signal layer1   : std_logic_vector(7 downto 0);
    signal layer2   : std_logic_vector(3 downto 0);
    signal layer3   : std_logic_vector(1 downto 0);
    signal tree_out : std_logic;

begin

    gen_layer1: for i in 7 downto 0 generate
        xor1_x: xor2 port map(poly_bcd(i * 2 + 1), poly_bcd(i * 2), layer1(i));
    end generate gen_layer1;

    gen_layer2: for i in 3 downto 0 generate
        xor2_x: xor2 port map(layer1(i * 2 + 1), layer1(i * 2), layer2(i));
    end generate gen_layer2;

    gen_layer3: for i in 1 downto 0 generate
        xor3_x: xor2 port map(layer2(i * 2 + 1), layer2(i * 2), layer3(i));
    end generate gen_layer3;

    xor4_1: xor2 port map(layer3(1), layer3(0), tree_out);
    and1: and2 port map(tree_out, poly_bcd(0), is_reducible);
 
end structural;
