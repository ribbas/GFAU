-- pfadder.vhd
--
-- Sabbir Ahmed
-- 2018-01-16
--
-- 1-bit partial full adder.
--

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

begin

    s <= a xor b xor cin;
    p <= a xor b;
    g <= a and b;

end structural;
