
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top is
    port(
        op      : in std_logic_vector(5 downto 0);
        m1      : in std_logic_vector (15 downto 0);
        m2      : in std_logic_vector (15 downto 0);
        m1_out  : out std_logic_vector (15 downto 0);
        m2_out  : out std_logic_vector (15 downto 0)
    );
end top;

architecture behavioral of top is

    component IS61LP6432A is
        port(
            A       : in std_logic_vector(15 downto 0);
            clk     : in std_logic;
            nADSP   : in std_logic;
            nADSC   : in std_logic;
            nADV    : in std_logic;
            nBW     : in std_logic_vector(3 downto 0);
            nBWE    : in std_logic;
            nGW     : in std_logic;
            nCE     : in std_logic;
            nCE2    : in std_logic;
            CE2     : in std_logic;
            nOE     : in std_logic;
            DQ      : inout std_logic_vector(31 downto 0);
            MODE    : in std_logic;
            ZZ      : in std_logic
        );
    end component;

begin

end behavioral;
