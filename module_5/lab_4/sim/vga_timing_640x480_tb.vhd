----------------------------------------------------------------------------------
--  Author: Liam Carter
--
-- Design Name:
-- Module Name: vga_timing_640x480_tb - Behavioral
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

entity vga_timing_640x480_tb is
end vga_timing_640x480_tb;

architecture Behavioral of vga_timing_640x480_tb is
    constant CLK_PERIOD : time := 10 ns;

    signal clk : STD_LOGIC := '0';
    signal reset : STD_LOGIC := '1';
    signal en25 : STD_LOGIC;
    signal horizontal_counter : unsigned(9 downto 0);
    signal vertical_counter : unsigned(9 downto 0);
    signal active_video : STD_LOGIC;
    signal VGA_HS : STD_LOGIC;
    signal VGA_VS : STD_LOGIC;
begin

    clk <= not clk after CLK_PERIOD / 2;

    uut : entity work.vga_timing_640x480
        port map (
            clk => clk,
            reset => reset,
            en25 => en25,
            horizontal_counter => horizontal_counter,
            vertical_counter => vertical_counter,
            active_video => active_video,
            VGA_HS => VGA_HS,
            VGA_VS => VGA_VS
        );

    stimulus : process
        variable en25_count : integer := 0;
    begin
        wait for 3 * CLK_PERIOD;
        reset <= '0';

        wait until rising_edge(clk);
        assert horizontal_counter = to_unsigned(0, horizontal_counter'length)
            report "Horizontal counter did not start at 0"
            severity error;
        assert vertical_counter = to_unsigned(0, vertical_counter'length)
            report "Vertical counter did not start at 0"
            severity error;

        while en25_count < 4 loop
            wait until rising_edge(clk);
            wait for 1 ns;
            if en25 = '1' then
                en25_count := en25_count + 1;
            end if;
        end loop;

        assert horizontal_counter = to_unsigned(4, horizontal_counter'length)
            report "Horizontal counter did not advance once per 25 MHz enable"
            severity error;

        while horizontal_counter /= to_unsigned(639, horizontal_counter'length) loop
            wait until rising_edge(clk);
            wait for 1 ns;
        end loop;

        assert active_video = '1'
            report "active_video should be high at h=639, v=0"
            severity error;

        while horizontal_counter /= to_unsigned(640, horizontal_counter'length) loop
            wait until rising_edge(clk);
            wait for 1 ns;
        end loop;

        assert active_video = '0'
            report "active_video should be low at h=640"
            severity error;

        while horizontal_counter /= to_unsigned(656, horizontal_counter'length) loop
            wait until rising_edge(clk);
            wait for 1 ns;
        end loop;

        assert VGA_HS = '0'
            report "VGA_HS should be active low at h=656"
            severity error;

        while horizontal_counter /= to_unsigned(752, horizontal_counter'length) loop
            wait until rising_edge(clk);
            wait for 1 ns;
        end loop;

        assert VGA_HS = '1'
            report "VGA_HS should return high at h=752"
            severity error;

        while vertical_counter /= to_unsigned(490, vertical_counter'length) loop
            wait until rising_edge(clk);
            wait for 1 ns;
        end loop;

        assert VGA_VS = '0'
            report "VGA_VS should be active low at v=490"
            severity error;

        while vertical_counter /= to_unsigned(492, vertical_counter'length) loop
            wait until rising_edge(clk);
            wait for 1 ns;
        end loop;

        assert VGA_VS = '1'
            report "VGA_VS should return high at v=492"
            severity error;

        while not (horizontal_counter = to_unsigned(799, horizontal_counter'length) and
                   vertical_counter = to_unsigned(520, vertical_counter'length)) loop
            wait until rising_edge(clk);
            wait for 1 ns;
        end loop;

        while not (horizontal_counter = to_unsigned(0, horizontal_counter'length) and
                   vertical_counter = to_unsigned(0, vertical_counter'length)) loop
            wait until rising_edge(clk);
            wait for 1 ns;
        end loop;

        assert active_video = '1'
            report "active_video should be high after full frame wrap"
            severity error;

        assert false
            report "vga_timing_640x480_tb completed"
            severity note;
        wait;
    end process;

end Behavioral;
