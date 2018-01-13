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
        m           : in std_logic_vector(3 downto 0);
        n           : in std_logic_vector(3 downto 0);

        -- memory signals
        write_en    : out std_logic;
        rdy         : out std_logic;
        addr        : out std_logic_vector(15 downto 0);
        sym1        : out std_logic_vector(15 downto 0);
        sym2        : out std_logic_vector(15 downto 0)
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
            en      : in std_logic;
            sym     : out std_logic_vector(15 downto 0)
        );
    end component;

    component gen_sym
        port(
            clk     : in std_logic;
            rst     : in std_logic;
            m       : in std_logic_vector(3 downto 0);  -- n of element
            nth_sym : in std_logic_vector(15 downto 0);
            sym     : out std_logic_vector(15 downto 0)
        );
    end component;

    signal sum : std_logic_vector(15 downto 0);

    signal rst_auto : std_logic := '1';
    signal en_auto : std_logic := '1';
    signal temp_auto : std_logic_vector(15 downto 0);

    signal rdy_gen : std_logic := '1';
    signal rst_gen : std_logic := '1';
    signal temp_gen : std_logic_vector(15 downto 0);

    signal nth_sym : std_logic_vector(15 downto 0);
    signal counter : std_logic_vector(15 downto 0);

    type state_type is (auto_sym_state, gen_sym_state);  -- define the states
    signal state: state_type;

begin

    auto : auto_sym port map(
        clk => clk,
        rst => rst_auto,
        en => en_auto,
        sym => temp_auto
    );

    gen : gen_sym port map(
        clk => clk,
        rst => rst_gen,
        m => m,
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

        nth_sym <= poly_bcd and mask;

        if (en = '1') then

            if (rst = '1') then

                counter <= "0000000000000000";
                addr <= "0000000000000000";
                sym1 <= "0000000000000000";
                state <= auto_sym_state;

            elsif rising_edge(clk) then  -- if there is a rising edge

                case state is

                    when auto_sym_state =>

                        rst_auto <= '0';
                        counter <= sum;
                        rdy <= '0';

                        if (rst_gen = '1' and temp_auto(to_integer(unsigned(m))) = '1') then

                            rst_gen <= '0';

                        end if;

                        if (rst_gen = '1' and temp_auto(to_integer(unsigned(n))) = '0') then

                            sym1 <= temp_auto and mask;
                            state <= auto_sym_state;

                        else

                            sym1 <= nth_sym and mask;
                            state <= gen_sym_state;
                            en_auto <= '0';

                        end if;

                        write_en <= '1';
                        addr <= counter;

                    when gen_sym_state =>

                        counter <= sum;

                        if (((temp_gen and mask) xnor "0000000000000001") = "1111111111111111") then

                            sym1 <= "XXXXXXXXXXXXXXXX";
                            addr <= "XXXXXXXXXXXXXXXX";
                            rdy <= '1';
                            write_en <= '0';

                        else

                            sym1 <= temp_gen and mask;
                            addr <= counter;
                            rdy <= '0';
                            write_en <= '1';

                        end if;

                        state <= gen_sym_state;

                    when others =>

                        state <= auto_sym_state;

                end case;

            end if;  -- rst

        else

            counter <= "0000000000000000";
            addr <= "XXXXXXXXXXXXXXXX";
            sym1 <= "XXXXXXXXXXXXXXXX";

        end if;  -- en

    end process;

end fsm;
