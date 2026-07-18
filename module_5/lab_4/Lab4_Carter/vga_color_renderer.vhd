----------------------------------------------------------------------------------
--  Author: Liam Carter
--
-- Design Name:
-- Module Name: vga_color_renderer - Behavioral
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

entity vga_color_renderer is
    Port (
           horizontal_counter : in unsigned (9 downto 0);
           vertical_counter : in unsigned (9 downto 0);
           active_video : in STD_LOGIC;

           square_x : in unsigned (4 downto 0);
           square_y : in unsigned (3 downto 0);

           VGA_R : out STD_LOGIC_VECTOR (3 downto 0);
           VGA_G : out STD_LOGIC_VECTOR (3 downto 0);
           VGA_B : out STD_LOGIC_VECTOR (3 downto 0)
           );
end vga_color_renderer;

architecture Behavioral of vga_color_renderer is
    signal pixel_square_x : unsigned(4 downto 0);
    signal pixel_square_y : unsigned(3 downto 0);

    signal red_square_on : STD_LOGIC;
    signal checker_select : STD_LOGIC;
    signal red_t : STD_LOGIC;
    signal green_t : STD_LOGIC;
    signal blue_t : STD_LOGIC;
begin

    pixel_square_x <= horizontal_counter(9 downto 5);
    pixel_square_y <= vertical_counter(8 downto 5);

    red_square_on <= '1' when (active_video = '1' and
                               pixel_square_x = square_x and
                               pixel_square_y = square_y) else '0';

    checker_select <= horizontal_counter(5) xor vertical_counter(5);

    red_t <= '1' when red_square_on = '1' else '0';

    green_t <= '1' when (active_video = '1' and
                         red_square_on = '0' and
                         checker_select = '0') else '0';

    blue_t <= '1' when (active_video = '1' and
                        red_square_on = '0' and
                        checker_select = '1') else '0';

    VGA_R <= (others => red_t);
    VGA_G <= (others => green_t);
    VGA_B <= (others => blue_t);

end Behavioral;
