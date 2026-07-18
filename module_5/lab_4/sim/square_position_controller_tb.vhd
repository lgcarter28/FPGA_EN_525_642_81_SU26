----------------------------------------------------------------------------------
--  Author: Liam Carter
--
-- Design Name:
-- Module Name: square_position_controller_tb - Behavioral
-- Project Name:
-- Target Devices:
-- Tool Versions:
-- Description:
--
-- Dependencies:
--
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity square_position_controller_tb is
end square_position_controller_tb;

architecture Behavioral of square_position_controller_tb is
    constant CLK_PERIOD : time := 10 ns;

    signal clk : STD_LOGIC := '0';
    signal reset : STD_LOGIC := '1';
    signal up_pulse : STD_LOGIC := '0';
    signal down_pulse : STD_LOGIC := '0';
    signal left_pulse : STD_LOGIC := '0';
    signal right_pulse : STD_LOGIC := '0';
    signal square_x : unsigned(4 downto 0);
    signal square_y : unsigned(3 downto 0);

    procedure pulse_button(signal button_pulse : out STD_LOGIC) is
    begin
        button_pulse <= '1';
        wait for CLK_PERIOD;
        button_pulse <= '0';
        wait for CLK_PERIOD;
    end procedure;
begin

    clk <= not clk after CLK_PERIOD / 2;

    uut : entity work.square_position_controller
        port map (
            clk => clk,
            reset => reset,
            up_pulse => up_pulse,
            down_pulse => down_pulse,
            left_pulse => left_pulse,
            right_pulse => right_pulse,
            square_x => square_x,
            square_y => square_y
        );

    stimulus : process
    begin
        wait for 3 * CLK_PERIOD;
        reset <= '0';
        wait for CLK_PERIOD;

        assert square_x = to_unsigned(0, square_x'length)
            report "Reset did not initialize square_x to 0"
            severity error;
        assert square_y = to_unsigned(0, square_y'length)
            report "Reset did not initialize square_y to 0"
            severity error;

        pulse_button(right_pulse);
        assert square_x = to_unsigned(1, square_x'length)
            report "Right pulse did not increment square_x"
            severity error;
        assert square_y = to_unsigned(0, square_y'length)
            report "Right pulse changed square_y"
            severity error;

        pulse_button(left_pulse);
        assert square_x = to_unsigned(0, square_x'length)
            report "Left pulse did not decrement square_x"
            severity error;

        pulse_button(left_pulse);
        assert square_x = to_unsigned(19, square_x'length)
            report "Left pulse did not wrap square_x from 0 to 19"
            severity error;

        reset <= '1';
        wait for CLK_PERIOD;
        reset <= '0';
        wait for CLK_PERIOD;

        pulse_button(up_pulse);
        assert square_y = to_unsigned(14, square_y'length)
            report "Up pulse did not wrap square_y from 0 to 14"
            severity error;

        pulse_button(down_pulse);
        assert square_y = to_unsigned(0, square_y'length)
            report "Down pulse did not wrap square_y from 14 to 0"
            severity error;

        pulse_button(down_pulse);
        assert square_y = to_unsigned(1, square_y'length)
            report "Down pulse did not increment square_y"
            severity error;

        assert false
            report "square_position_controller_tb completed"
            severity note;
        wait;
    end process;

end Behavioral;
