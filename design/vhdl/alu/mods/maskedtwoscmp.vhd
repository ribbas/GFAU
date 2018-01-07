library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity maskedtwoscmp is
    port(
        num         : in std_logic_vector(15 downto 0);
        mask        : in std_logic_vector(15 downto 0);
        maskedtc    : out std_logic_vector(15 downto 0)
   );
end maskedtwoscmp;

architecture structural of maskedtwoscmp is

    -- twoscmp component
    component twoscmp
        port(
            num     : in  std_logic_vector(15 downto 0);
            tcnum   : out  std_logic_vector(15 downto 0)
        );
    end component;

    signal tcnum: std_logic_vector(15 downto 0);

begin

    tc: twoscmp port map(
        num,
        tcnum
    );

    maskedtc <= std_logic_vector(mask) and tcnum;

end structural;
