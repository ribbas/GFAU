library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity generator is
    port(
        clk         : in std_logic;
        en          : in std_logic;
        rst         : in std_logic;

        -- polynomial data
        poly_bcd    : in std_logic_vector(15 downto 0);
        mask        : in std_logic_vector(15 downto 0);
        msb         : in std_logic_vector(3 downto 0);
        size        : in std_logic_vector(3 downto 0);

        -- memory signals
        write_en    : out std_logic;
        addr        : out std_logic_vector(15 downto 0);
        data        : out std_logic_vector(15 downto 0)
    );
end generator;

architecture fsm of generator is

    component claadder16
        port(
            a   : in std_logic_vector(15 downto 0);
            b   : in std_logic_vector(15 downto 0);
            s   : out std_logic_vector(15 downto 0)
        );
    end component;

    component auto_sym
        port(
            clk     : in std_logic;
            rst     : in std_logic;
            sym     : out std_logic_vector(15 downto 0)
        );
    end component;

    component gen_sym
        port(
            clk     : in std_logic;
            rst     : in std_logic;
            msb     : in std_logic_vector(3 downto 0);  -- size of element
            nth_sym : in std_logic_vector(15 downto 0);
            sym     : out std_logic_vector(15 downto 0)
        );
    end component;

    signal sum : std_logic_vector(15 downto 0);

    signal rst_auto : std_logic := '1';
    signal rst_gen : std_logic := '1';
    signal init_gen : std_logic;

    signal nth_sym : std_logic_vector(15 downto 0);
    signal temp_auto : std_logic_vector(15 downto 0);
    signal temp_gen : std_logic_vector(15 downto 0);
    signal counter : std_logic_vector(15 downto 0);
    type state_type is (init, init1, ready);  -- define the states
    signal state: state_type;

begin

    auto : auto_sym port map(
        clk => clk,
        rst => rst_auto,
        sym => temp_auto
    );

    gen : gen_sym port map(
        clk => clk,
        rst => rst_gen,
        msb => msb,
        nth_sym => nth_sym,
        sym => temp_gen
    );

    cla : claadder16 port map(
        a => counter,
        b => "0000000000000001",
        s => sum
    );

    process (clk, en, rst, poly_bcd, mask)
    begin

        if (en = '1') then

            if (rst = '1') then

                counter <= "0000000000000000";
                nth_sym <= poly_bcd and mask;
                addr <= "0000000000000000";
                data <= "0000000000000000";

            elsif rising_edge(clk) then  -- if there is a rising edge

                rst_auto <= '0';
                counter <= sum;

                if (rst_gen = '1' and temp_auto(to_integer(unsigned(size))) = '0') then

                    data <= temp_auto and mask;

                else

                    report "on " & std_logic'image(rst_gen)& std_logic'image(rst_auto);
                    data <= temp_gen and mask;
                    rst_gen <= '0';

                end if;

                addr <= counter;

            end if;

        end if;

    end process;

end fsm;
