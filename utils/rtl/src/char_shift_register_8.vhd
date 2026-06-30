----------------------------------------------------------------------------------
--  Author: Liam Carter
-- 
-- Design Name: 
-- Module Name: char_shift_register_8 - Behavioral
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

entity char_shift_register_8 is
    Port ( 
           clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           shift_en : in STD_LOGIC;
           char_in : in STD_LOGIC_VECTOR (3 downto 0);

           char0 : out STD_LOGIC_VECTOR (3 downto 0);
           char1 : out STD_LOGIC_VECTOR (3 downto 0);
           char2 : out STD_LOGIC_VECTOR (3 downto 0);
           char3 : out STD_LOGIC_VECTOR (3 downto 0);
           char4 : out STD_LOGIC_VECTOR (3 downto 0);
           char5 : out STD_LOGIC_VECTOR (3 downto 0);
           char6 : out STD_LOGIC_VECTOR (3 downto 0);
           char7 : out STD_LOGIC_VECTOR (3 downto 0)
           );
end char_shift_register_8;

architecture Behavioral of char_shift_register_8 is
    signal r0, r1, r2, r3, r4, r5, r6, r7 : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
begin

    -- char0 is rightmost digit
    -- char7 is leftmost digit
    process(clk, reset)
    begin
        if reset = '1' then
            r0 <= "0000";
            r1 <= "0000";
            r2 <= "0000";
            r3 <= "0000";
            r4 <= "0000";
            r5 <= "0000";
            r6 <= "0000";
            r7 <= "0000";
        elsif rising_edge(clk) then
            if shift_en = '1' then
                r7 <= r6;
                r6 <= r5;
                r5 <= r4;
                r4 <= r3;
                r3 <= r2;
                r2 <= r1;
                r1 <= r0;
                r0 <= char_in;
            end if;
        end if;
    end process;

    char0 <= r0;
    char1 <= r1;
    char2 <= r2;
    char3 <= r3;
    char4 <= r4;
    char5 <= r5;
    char6 <= r6;
    char7 <= r7;

end Behavioral;
