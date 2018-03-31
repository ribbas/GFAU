
library ieee;
    use ieee.std_logic_1164.all;
    use ieee.std_logic_unsigned.all;

package demo is

    -- demo constants
    constant DEGREE : positive := 8;
    constant CEILLGN : positive := 3;
    constant CEILLGN1 : positive := 2;

    -- demo vectors
    constant DCAREVEC : std_logic_vector(DEGREE downto 0) := (others => '-');
    constant ZEROVEC : std_logic_vector(DEGREE downto 0) := (others => '0');
    constant HIVEC : std_logic_vector(DEGREE downto 0) := (others => '1');
    constant HIIMPVEC : std_logic_vector(DEGREE downto 0) := (others => 'Z');
    constant ONEVEC: std_logic_vector(DEGREE downto 0) := (0 => '1',
                                                        others => '0');

end demo;
