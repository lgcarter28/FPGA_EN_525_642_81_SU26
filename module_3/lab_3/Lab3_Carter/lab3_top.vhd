----------------------------------------------------------------------------------
--  Author: Liam Carter
-- 
-- Design Name: 
-- Module Name: lab3_top - Behavioral
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

entity lab3_top is
    Port (
           --Clock
           CLK100MHZ : in STD_LOGIC;
           
           --Push Buttons
           BTNC : in STD_LOGIC;
           
           --Switches (16 Switches)
           SW : in STD_LOGIC_VECTOR (15 downto 0);
           
           --LEDs (16 LEDs)
           LED : out STD_LOGIC_VECTOR (15 downto 0);
           
           --Seg7 Display Signals
           SEG7_CATH : out STD_LOGIC_VECTOR (7 downto 0);
           AN : out STD_LOGIC_VECTOR (7 downto 0));
end lab3_top;

architecture Behavioral of lab3_top is

    signal pulse_1hz : STD_LOGIC;

    signal char0 : STD_LOGIC_VECTOR(3 downto 0);
    signal char1 : STD_LOGIC_VECTOR(3 downto 0);
    signal char2 : STD_LOGIC_VECTOR(3 downto 0);
    signal char3 : STD_LOGIC_VECTOR(3 downto 0);
    signal char4 : STD_LOGIC_VECTOR(3 downto 0);
    signal char5 : STD_LOGIC_VECTOR(3 downto 0);
    signal char6 : STD_LOGIC_VECTOR(3 downto 0);
    signal char7 : STD_LOGIC_VECTOR(3 downto 0);

begin

    -- LEDs mirror switches
    LED <= SW;

    pulse_1hz_gen : entity work.pulseGenerator
        port map (
            clk => CLK100MHZ,
            reset => BTNC,
            maxCount => to_unsigned(99999999, 27), -- 100 MHz / 100000000 = 1 Hz
            pulseOut => pulse_1hz
        );

    shift_reg_inst : entity work.char_shift_register_8
        port map (
            clk => CLK100MHZ,
            reset => BTNC,
            shift_en => pulse_1hz,
            char_in  => SW(3 downto 0),

            char0 => char0,
            char1 => char1,
            char2 => char2,
            char3 => char3,
            char4 => char4,
            char5 => char5,
            char6 => char6,
            char7 => char7
        );

    seg7_controller_inst : entity work.seg7_controller
        port map (
            clk => CLK100MHZ,
            reset => BTNC,

            char0 => char0,
            char1 => char1,
            char2 => char2,
            char3 => char3,
            char4 => char4,
            char5 => char5,
            char6 => char6,
            char7 => char7,

            SEG7_CATH => SEG7_CATH,
            AN => AN
        );

end Behavioral;
