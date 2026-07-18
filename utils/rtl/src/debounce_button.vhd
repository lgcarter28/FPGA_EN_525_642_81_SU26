----------------------------------------------------------------------------------
--  Author: Liam Carter
--
-- Design Name:
-- Module Name: debounce_button - Behavioral
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

entity debounce_button is
    Generic (
           DEBOUNCE_COUNT_MAX : integer := 10000000
           );
    Port (
           clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           button_in : in STD_LOGIC;
           button_db : out STD_LOGIC;
           button_pressed : out STD_LOGIC
           );
end debounce_button;

architecture Behavioral of debounce_button is
    signal button_meta : STD_LOGIC := '0';
    signal button_sync : STD_LOGIC := '0';
    signal button_db_reg : STD_LOGIC := '0';
    signal button_db_q : STD_LOGIC := '0';
    signal db_counter : integer range 0 to DEBOUNCE_COUNT_MAX := 0;
begin

    process(clk, reset)
    begin
        if reset = '1' then
            button_meta <= '0';
            button_sync <= '0';
            button_db_reg <= '0';
            button_db_q <= '0';
            button_pressed <= '0';
            db_counter <= 0;
        elsif rising_edge(clk) then
            button_meta <= button_in;
            button_sync <= button_meta;

            button_db_q <= button_db_reg;
            button_pressed <= button_db_reg and (not button_db_q);

            if button_sync = '1' then
                if db_counter < DEBOUNCE_COUNT_MAX then
                    db_counter <= db_counter + 1;
                    button_db_reg <= '0';
                else
                    button_db_reg <= '1';
                end if;
            else
                db_counter <= 0;
                button_db_reg <= '0';
            end if;
        end if;
    end process;

    button_db <= button_db_reg;

end Behavioral;
