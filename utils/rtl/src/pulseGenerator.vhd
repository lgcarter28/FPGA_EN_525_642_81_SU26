----------------------------------------------------------------------------------
--  Author: Liam Carter
-- 
-- Design Name: 
-- Module Name: pulseGenerator - Behavioral
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

entity pulseGenerator is
    Port ( 
           clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           maxCount : in unsigned (26 downto 0);
           pulseOut : out STD_LOGIC
           );
end pulseGenerator;

architecture Behavioral of pulseGenerator is

    signal pulseCnt : unsigned(26 downto 0);

begin

    process(clk, reset)
    begin
        if reset = '1' then
            pulseCnt <= (others => '0');
            pulseOut <= '0';
        elsif rising_edge(clk) then
            if pulseCnt = maxCount then
                pulseCnt <= (others => '0');
                pulseOut <= '1';
            else
                pulseCnt <= pulseCnt + 1;
                pulseOut <= '0';
            end if;
        end if;
    end process;

end Behavioral;
