----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/03/2026 09:49:21 PM
-- Design Name: 
-- Module Name: seg7_hex - Behavioral
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

entity seg7_hex is
    Port ( digit : in STD_LOGIC_VECTOR (3 downto 0);
           seg7 : out STD_LOGIC_VECTOR (7 downto 0));
end seg7_hex;

architecture Behavioral of seg7_hex is

begin
    -- 7 segment display: [DP G F E D C B A]
    --: - A -
    --: |   |
    --: F   B
    --: |   |
    --: - G -
    --: |   |
    --: E   C
    --: |   |
    --: - D - DP
    
    -- Active low for 7 segment cathodes
    process (digit)
    begin
        case digit is
             when x"0" => seg7 <= "11000000";
             when x"1" => seg7 <= "11111001";
             when x"2" => seg7 <= "10100100";
             when x"3" => seg7 <= "10110000";
             when x"4" => seg7 <= "10011001";
             when x"5" => seg7 <= "10010010";
             when x"6" => seg7 <= "10000010";
             when x"7" => seg7 <= "11111000";
             when x"8" => seg7 <= "10000000";
             when x"9" => seg7 <= "10010000";
             when x"A" => seg7 <= "10001000";
             when x"B" => seg7 <= "10000011";
             when x"C" => seg7 <= "11000110";
             when x"D" => seg7 <= "10100001";
             when x"E" => seg7 <= "10000110";
             when others => seg7 <= "10001110";
        end case;
    end process;
end Behavioral;
