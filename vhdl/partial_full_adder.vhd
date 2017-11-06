library IEEE; use IEEE.STD_LOGIC_1164.ALL;
 
entity partial_full_adder is port (
        A   : in std_logic;
        B   : in std_logic;
        Cin : in std_logic;
        S   : out std_logic;
        P   : out std_logic;
        G   : out std_logic
    );
end partial_full_adder;

component xor2 port(
        in1     :   in std_logic;
        in2     :   in std_logic;
        out1    :   out std_logic
    );
end component;

architecture structural of partial_full_adder is
begin

    S <= A xor B;
    S <= S xor Cin;
    P <= A xor B;
    G <= A and B;
 
end structural;
