library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity varmask is
    port(
        num         : in  std_logic_vector (15 downto 0);
        n           : in integer range 0 to 15;
        masked_out  : out  std_logic_vector (15 downto 0)
   );
end varmask;

architecture structural of varmask is

    component twoscmp
        port(
            num     : in  std_logic_vector (15 downto 0);
            n       : in integer range 0 to 15;
            tcnum   : out  std_logic_vector (15 downto 0)
        );
    end component;

    signal all_hi: std_logic_vector(15 downto 0) := "1111111111111111";
    signal mask: unsigned(15 downto 0) := "0000000000000000";

begin

    tc: twoscmp port map(
            num,
            n,
            tcnum
        );

    mask <= shift_right(unsigned(all_hi), (16 - n));
    masked_out <= std_logic_vector(mask) and tcnum;

end structural;
