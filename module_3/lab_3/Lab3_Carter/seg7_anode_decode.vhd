----------------------------------------------------------------------------------
--  Author: Liam Carter
-- 
-- Design Name: 
-- Module Name: seg7_anode_decode - Behavioral
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

entity seg7_anode_decode is
    Port (
           digit_sel : in STD_LOGIC_VECTOR (2 downto 0);
           AN : out STD_LOGIC_VECTOR (7 downto 0)
           );
end seg7_anode_decode;

architecture Behavioral of seg7_anode_decode is

begin

    process(digit_sel)
    begin
        case digit_sel is
            when "000" => AN <= "11111110"; -- digit 0, rightmost
            when "001" => AN <= "11111101";
            when "010" => AN <= "11111011";
            when "011" => AN <= "11110111";
            when "100" => AN <= "11101111";
            when "101" => AN <= "11011111";
            when "110" => AN <= "10111111";
            when others => AN <= "01111111"; -- digit 7, leftmost
        end case;
    end process;

end Behavioral;
