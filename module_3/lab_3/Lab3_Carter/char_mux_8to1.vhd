----------------------------------------------------------------------------------
--  Author: Liam Carter
-- 
-- Design Name: 
-- Module Name: char_mux_8to1 - Behavioral
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

entity char_mux_8to1 is
    Port ( 
           digit_sel : in STD_LOGIC_VECTOR (2 downto 0);
    
           char0 : in STD_LOGIC_VECTOR (3 downto 0);
           char1 : in STD_LOGIC_VECTOR (3 downto 0);
           char2 : in STD_LOGIC_VECTOR (3 downto 0);
           char3 : in STD_LOGIC_VECTOR (3 downto 0);
           char4 : in STD_LOGIC_VECTOR (3 downto 0);
           char5 : in STD_LOGIC_VECTOR (3 downto 0);
           char6 : in STD_LOGIC_VECTOR (3 downto 0);
           char7 : in STD_LOGIC_VECTOR (3 downto 0);
           
           char_out : out STD_LOGIC_VECTOR (3 downto 0)
           );
end char_mux_8to1;

architecture Behavioral of char_mux_8to1 is

begin

    process(digit_sel, char0, char1, char2, char3, char4, char5, char6, char7)
    begin
        case digit_sel is
            when "000" => char_out <= char0;
            when "001" => char_out <= char1;
            when "010" => char_out <= char2;
            when "011" => char_out <= char3;
            when "100" => char_out <= char4;
            when "101" => char_out <= char5;
            when "110" => char_out <= char6;
            when others => char_out <= char7;
        end case;
    end process;

end Behavioral;
