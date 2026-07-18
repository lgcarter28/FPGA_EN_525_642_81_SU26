----------------------------------------------------------------------------------
--  Author: Liam Carter
--
-- Design Name:
-- Module Name: square_position_controller - Behavioral
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

entity square_position_controller is
    Port (
           clk : in STD_LOGIC;
           reset : in STD_LOGIC;

           up_pulse : in STD_LOGIC;
           down_pulse : in STD_LOGIC;
           left_pulse : in STD_LOGIC;
           right_pulse : in STD_LOGIC;

           square_x : out unsigned (4 downto 0);
           square_y : out unsigned (3 downto 0)
           );
end square_position_controller;

architecture Behavioral of square_position_controller is
    signal square_x_reg : unsigned(4 downto 0) := (others => '0');
    signal square_y_reg : unsigned(3 downto 0) := (others => '0');
begin

    process(clk, reset)
    begin
        if reset = '1' then
            square_x_reg <= (others => '0');
            square_y_reg <= (others => '0');
        elsif rising_edge(clk) then
            if up_pulse = '1' then
                if square_y_reg = to_unsigned(0, square_y_reg'length) then
                    square_y_reg <= to_unsigned(14, square_y_reg'length);
                else
                    square_y_reg <= square_y_reg - 1;
                end if;
            elsif down_pulse = '1' then
                if square_y_reg = to_unsigned(14, square_y_reg'length) then
                    square_y_reg <= (others => '0');
                else
                    square_y_reg <= square_y_reg + 1;
                end if;
            elsif left_pulse = '1' then
                if square_x_reg = to_unsigned(0, square_x_reg'length) then
                    square_x_reg <= to_unsigned(19, square_x_reg'length);
                else
                    square_x_reg <= square_x_reg - 1;
                end if;
            elsif right_pulse = '1' then
                if square_x_reg = to_unsigned(19, square_x_reg'length) then
                    square_x_reg <= (others => '0');
                else
                    square_x_reg <= square_x_reg + 1;
                end if;
            end if;
        end if;
    end process;

    square_x <= square_x_reg;
    square_y <= square_y_reg;

end Behavioral;
