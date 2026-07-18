----------------------------------------------------------------------------------
--  Author: Liam Carter
--
-- Design Name:
-- Module Name: vga_color_renderer_tb - Behavioral
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

entity vga_color_renderer_tb is
end vga_color_renderer_tb;

architecture Behavioral of vga_color_renderer_tb is
    signal horizontal_counter : unsigned(9 downto 0) := (others => '0');
    signal vertical_counter : unsigned(9 downto 0) := (others => '0');
    signal active_video : STD_LOGIC := '0';
    signal square_x : unsigned(4 downto 0) := (others => '0');
    signal square_y : unsigned(3 downto 0) := (others => '0');
    signal VGA_R : STD_LOGIC_VECTOR(3 downto 0);
    signal VGA_G : STD_LOGIC_VECTOR(3 downto 0);
    signal VGA_B : STD_LOGIC_VECTOR(3 downto 0);
begin

    uut : entity work.vga_color_renderer
        port map (
            horizontal_counter => horizontal_counter,
            vertical_counter => vertical_counter,
            active_video => active_video,
            square_x => square_x,
            square_y => square_y,
            VGA_R => VGA_R,
            VGA_G => VGA_G,
            VGA_B => VGA_B
        );

    stimulus : process
    begin
        active_video <= '0';
        horizontal_counter <= to_unsigned(0, horizontal_counter'length);
        vertical_counter <= to_unsigned(0, vertical_counter'length);
        square_x <= to_unsigned(0, square_x'length);
        square_y <= to_unsigned(0, square_y'length);
        wait for 10 ns;

        assert VGA_R = x"0" and VGA_G = x"0" and VGA_B = x"0"
            report "Inactive video should drive black"
            severity error;

        active_video <= '1';
        wait for 10 ns;

        assert VGA_R = x"F" and VGA_G = x"0" and VGA_B = x"0"
            report "Selected square should drive red"
            severity error;

        square_x <= to_unsigned(1, square_x'length);
        wait for 10 ns;

        assert VGA_R = x"0" and VGA_G = x"F" and VGA_B = x"0"
            report "Checker square with select 0 should drive green"
            severity error;

        horizontal_counter <= to_unsigned(32, horizontal_counter'length);
        wait for 10 ns;

        assert VGA_R = x"F" and VGA_G = x"0" and VGA_B = x"0"
            report "Moved selected square should drive red"
            severity error;

        square_x <= to_unsigned(0, square_x'length);
        wait for 10 ns;

        assert VGA_R = x"0" and VGA_G = x"0" and VGA_B = x"F"
            report "Checker square with select 1 should drive blue"
            severity error;

        assert false
            report "vga_color_renderer_tb completed"
            severity note;
        wait;
    end process;

end Behavioral;
