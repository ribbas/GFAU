library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity twoscmp is
    port(
        num     : in  std_logic_vector(15 downto 0);
        tcnum   : out  std_logic_vector(15 downto 0)
   );
end twoscmp;

architecture structural of twoscmp is

    component claadder16
        port(
            a       : in std_logic_vector(15 downto 0);
            b       : in std_logic_vector(15 downto 0);
            cin     : in std_logic;
            s       : out std_logic_vector(15 downto 0);
            cout    : out std_logic
        );
    end component;

    signal carry: std_logic; 
    signal inv, tc: std_logic_vector(15 downto 0);
    signal one16: std_logic_vector(15 downto 0) := "0000000000000001";
    signal all_hi: std_logic_vector(15 downto 0) := "1111111111111111";
    signal mask: unsigned(15 downto 0) := "0000000000000000";

begin

    process (num)
    begin
        for i in 15 downto 0 loop
            inv(i) <= not num(i);
        end loop;
    end process;

    cla16:  claadder16 port map(
                inv,
                one16,
                '0',
                tcnum,
                carry
            );

    --mask <= shift_right(unsigned(all_hi), (16 - n));
    --tcnum <= std_logic_vector(mask);

end structural;
