-- demo.vhd
--
-- Sabbir Ahmed
-- 2018-03-30
--
-- Package for the GFAU demo containing all global vectors and constants
--

library ieee;
    use ieee.std_logic_1164.all;
    use ieee.std_logic_unsigned.all;

package demo is

    -------- demo constants --------

    -- maximum degree of polynomial
    constant DEGREE : positive := 8;

    -- ceil(log2(degree))
    constant CEILLGN : positive := 3;

    -- ceil(log2(degree - 1))
    constant CEILLGN1 : positive := 2;

    -------- demo constants --------

    -- vector of all don't care bits
    constant DCAREVEC : std_logic_vector(DEGREE downto 0) := (others => '-');

    constant NDCAREVEC : std_logic_vector(DEGREE downto 0) := (others => '-');

    -- vector of all low bits
    constant ZEROVEC : std_logic_vector(DEGREE downto 0) := (others => '0');

    -- vector of all high bits
    constant HIVEC : std_logic_vector(DEGREE downto 0) := (others => '1');

    -- vector of all high impedance bits
    constant HIIMPVEC : std_logic_vector(DEGREE downto 0) := (others => 'Z');

    -- vector of representing the DEGREE-bits binary 1
    constant ONEVEC: std_logic_vector(DEGREE downto 0) := (0 => '1',
                                                        others => '0');

    -------- state types --------

    type op_state_type is (op1_state, op2_state);
    type gen_state_type is (auto_elem_state, gen_elem_state);
    type debounce_state_type is (rst_state, en_state);

    -- memory states
    type rd_state_type is (send_addr, get_data);
    type wr_state_type is (wr_mem1, wr_mem2, wr_mem3);
    type setup_type is (addr_setup, wr);

end demo;
