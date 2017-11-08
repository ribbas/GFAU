library STD;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX is

port ( 
    op : in  STD_LOGIC_VECTOR (5 downto 0);
    addSub : in  STD_LOGIC_VECTOR (15 downto 0);
    mul : in  STD_LOGIC_VECTOR (15 downto 0);
	div : in  STD_LOGIC_VECTOR (15 downto 0);
    log : in  STD_LOGIC_VECTOR (15 downto 0);
    output : out  STD_LOGIC_VECTOR (15 downto 0);
    convert: out std_logic);
end MUX;

architecture structural of MUX is

component and3
port(
	in1     :   in  std_logic;
	in2     :   in  std_logic;
	in3     :   in  std_logic;
    out1    :   out std_logic);
end component;

component or2
port(
	in1     :   in  std_logic;
	in2     :   in  std_logic;
    out1    :   out std_logic);
end component;

component and4
port(
    in1     :   in  std_logic;
    in2     :   in  std_logic;
	in3     :   in  std_logic;
    in4     :   in  std_logic;
    out1    :   out std_logic);
end component;

component or4
port(
    in1     :   in  std_logic;
    in2     :   in  std_logic;
	in3     :   in  std_logic;
    in4     :   in  std_logic;
    out1    :   out std_logic);
end component;

component inverter
port(
    in1     :   in  std_logic;
    out1    :   out std_logic);
end component;

signal n_op5, n_op4, n_op3, n_op2, n_op1, n_op0, temp5, temp6: std_logic;
signal temp4, temp3, temp2, temp1: std_logic_vector(15 downto 0);

begin

inv1: inverter port map(op(5), n_op5);
inv2: inverter port map(op(4), n_op4);
inv3: inverter port map(op(3), n_op3);
inv4: inverter port map(op(2), n_op2);
inv5: inverter port map(op(1), n_op1);
inv6: inverter port map(op(0), n_op0);

and3_1: and3 port map (op(2), op(1), op(0), temp5);
and3_2: and3 port map (n_op2, n_op1, n_op0, temp6);

or2_1: or2 port map (temp5, temp6, convert);

BIT_AND  :   for i in 15 downto 0 generate
	AND4_1: and4 port map (n_op5, n_op4, op(3), addSub(i), temp4(i));
	AND4_2: and4 port map (n_op5, op(4), n_op3, mul(i), temp3(i));
	AND4_3: and4 port map (n_op5, op(4), op(3), div(i), temp2(i));
	AND4_4: and4 port map (op(5), n_op4, n_op3, log(i), temp1(i));
end generate BIT_AND;

BIT_OR  :   for i in 15 downto 0 generate
	OR4_1: or4 port map(temp4(i), temp3(i), temp2(i), temp1(i), output(i));
end generate BIT_OR;


end Structural;

