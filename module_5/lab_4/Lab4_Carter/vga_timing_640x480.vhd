----------------------------------------------------------------------------------
--  Author: Liam Carter
--
-- Design Name:
-- Module Name: vga_timing_640x480 - Behavioral
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

entity vga_timing_640x480 is
    Port (
           clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           en25 : out STD_LOGIC;
           horizontal_counter : out unsigned (9 downto 0);
           vertical_counter : out unsigned (9 downto 0);
           active_video : out STD_LOGIC;
           VGA_HS : out STD_LOGIC;
           VGA_VS : out STD_LOGIC
           );
end vga_timing_640x480;

architecture Behavioral of vga_timing_640x480 is
    signal clk_div_count : unsigned(1 downto 0) := (others => '0');
    signal en25_reg : STD_LOGIC := '0';
    signal h_count : unsigned(9 downto 0) := (others => '0');
    signal v_count : unsigned(9 downto 0) := (others => '0');
begin

    process(clk, reset)
    begin
        if reset = '1' then
            clk_div_count <= (others => '0');
            en25_reg <= '0';
            h_count <= (others => '0');
            v_count <= (others => '0');
        elsif rising_edge(clk) then
            if clk_div_count = "11" then
                clk_div_count <= (others => '0');
                en25_reg <= '1';
                if h_count = to_unsigned(799, h_count'length) then
                    h_count <= (others => '0');

                    if v_count = to_unsigned(520, v_count'length) then
                        v_count <= (others => '0');
                    else
                        v_count <= v_count + 1;
                    end if;
                else
                    h_count <= h_count + 1;
                end if;
            else
                clk_div_count <= clk_div_count + 1;
                en25_reg <= '0';
            end if;
        end if;
    end process;

    en25 <= en25_reg;
    horizontal_counter <= h_count;
    vertical_counter <= v_count;

    VGA_HS <= '0' when (h_count >= to_unsigned(656, h_count'length) and
                        h_count < to_unsigned(752, h_count'length)) else '1';

    VGA_VS <= '0' when (v_count >= to_unsigned(490, v_count'length) and
                        v_count < to_unsigned(492, v_count'length)) else '1';

    active_video <= '1' when (h_count < to_unsigned(640, h_count'length) and
                              v_count < to_unsigned(480, v_count'length)) else '0';

end Behavioral;
