----------------------------------------------------------------------------------
--  Author: Liam Carter
-- 
-- Create Date: 06/03/2026 09:38:28 PM
-- Design Name: 
-- Module Name: lab2_top - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity lab2_top is
    Port (
           -- Push Buttons
           BTNC : in STD_LOGIC;
           BTND : in STD_LOGIC;
           BTNU : in STD_LOGIC;
           
           -- Switches
           SW : in STD_LOGIC_VECTOR (15 downto 0);
           
           -- LEDs
           LED : out STD_LOGIC_VECTOR (15 downto 0);
           
           -- Seg7 Display Signals anodes and cathodes
           SEG7_CATH : out STD_LOGIC_VECTOR (7 downto 0);
           AN : out STD_LOGIC_VECTOR (7 downto 0));
end lab2_top;

architecture Behavioral of lab2_top is
signal digit_sel : STD_LOGIC_VECTOR (3 downto 0 );
begin
    -- Mux select input to 7 segment hex
    -- Override to zeros when center button pressed
    process(BTNC, SW)
    begin
        if (BTNC = '1') then
            digit_sel <= "0000";
        else
            digit_sel <= SW(3 downto 0);
        end if;
    end process;
    
    -- Instantiate 7 seg hex
    seg7_hex_disp : entity work.seg7_hex port map (
            digit => digit_sel,
            seg7 => SEG7_CATH
        );

    -- Nexys4 DDR uses transistors to drive anodes, so they are inverted
    -- To illuminate a segment, the both anode and cathode are driven low
    process(BTNC, BTNU, BTND, SW)
    begin
        if (BTNC = '1') then
            -- all displays active
            AN <= "00000000";
        elsif (BTNU = '1') then
            -- upper four displays active
            AN <= "00001111";
        elsif (BTND = '1') then
            -- bottom four displays active
            AN <= "11110000";
        else
            -- default to switches
            AN <= not SW(11 downto 4);
        end if;
    end process;

    -- Light LEDs to match switches
    LED <= SW;
end Behavioral;
