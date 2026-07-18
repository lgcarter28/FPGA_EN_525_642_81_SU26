----------------------------------------------------------------------------------
--  Author: Liam Carter
--
-- Design Name:
-- Module Name: lab4_top - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity lab4_top is
    Port (
           CLK100MHZ : in STD_LOGIC;

           SW : in STD_LOGIC_VECTOR (0 downto 0);

           BTNU : in STD_LOGIC;
           BTND : in STD_LOGIC;
           BTNL : in STD_LOGIC;
           BTNR : in STD_LOGIC;

           VGA_R : out STD_LOGIC_VECTOR (3 downto 0);
           VGA_G : out STD_LOGIC_VECTOR (3 downto 0);
           VGA_B : out STD_LOGIC_VECTOR (3 downto 0);
           VGA_HS : out STD_LOGIC;
           VGA_VS : out STD_LOGIC;

           SEG7_CATH : out STD_LOGIC_VECTOR (7 downto 0);
           AN : out STD_LOGIC_VECTOR (7 downto 0)
           );
end lab4_top;

architecture Behavioral of lab4_top is
    signal reset : STD_LOGIC;

    signal en25 : STD_LOGIC;
    signal horizontal_counter : unsigned(9 downto 0);
    signal vertical_counter : unsigned(9 downto 0);
    signal active_video : STD_LOGIC;

    signal up_pulse : STD_LOGIC;
    signal down_pulse : STD_LOGIC;
    signal left_pulse : STD_LOGIC;
    signal right_pulse : STD_LOGIC;

    signal square_x : unsigned(4 downto 0);
    signal square_y : unsigned(3 downto 0);
    signal square_x_high_char : STD_LOGIC_VECTOR(3 downto 0);

begin

    reset <= SW(0);

    vga_timing_inst : entity work.vga_timing_640x480
        port map (
            clk => CLK100MHZ,
            reset => reset,
            en25 => en25,
            horizontal_counter => horizontal_counter,
            vertical_counter => vertical_counter,
            active_video => active_video,
            VGA_HS => VGA_HS,
            VGA_VS => VGA_VS
        );

    debounce_up_inst : entity work.debounce_button
        port map (
            clk => CLK100MHZ,
            reset => reset,
            button_in => BTNU,
            button_db => open,
            button_pressed => up_pulse
        );

    debounce_down_inst : entity work.debounce_button
        port map (
            clk => CLK100MHZ,
            reset => reset,
            button_in => BTND,
            button_db => open,
            button_pressed => down_pulse
        );

    debounce_left_inst : entity work.debounce_button
        port map (
            clk => CLK100MHZ,
            reset => reset,
            button_in => BTNL,
            button_db => open,
            button_pressed => left_pulse
        );

    debounce_right_inst : entity work.debounce_button
        port map (
            clk => CLK100MHZ,
            reset => reset,
            button_in => BTNR,
            button_db => open,
            button_pressed => right_pulse
        );

    square_position_inst : entity work.square_position_controller
        port map (
            clk => CLK100MHZ,
            reset => reset,
            up_pulse => up_pulse,
            down_pulse => down_pulse,
            left_pulse => left_pulse,
            right_pulse => right_pulse,
            square_x => square_x,
            square_y => square_y
        );

    vga_color_renderer_inst : entity work.vga_color_renderer
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

    square_x_high_char <= "000" & square_x(4);

    seg7_controller_inst : entity work.seg7_controller
        port map (
            clk => CLK100MHZ,
            reset => reset,

            char0 => std_logic_vector(resize(square_y, 4)),
            char1 => x"0",
            char2 => std_logic_vector(square_x(3 downto 0)),
            char3 => square_x_high_char,
            char4 => x"0",
            char5 => x"0",
            char6 => x"0",
            char7 => x"0",

            SEG7_CATH => SEG7_CATH,
            AN => AN
        );

end Behavioral;
