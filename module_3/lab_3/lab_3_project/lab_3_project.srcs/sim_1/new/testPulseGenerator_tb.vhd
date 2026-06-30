----------------------------------------------------------------------------------
--  Author: Liam Carter
-- 
-- Design Name: 
-- Module Name: testPulseGenerator_tb - Behavioral
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

entity testPulseGenerator_tb is
--  Port ( );
end testPulseGenerator_tb;

architecture Behavioral of testPulseGenerator_tb is

    signal clock       : STD_LOGIC := '0';
    signal reset       : STD_LOGIC := '0';
    signal MaxCounter1 : unsigned(26 downto 0);
    signal Pulse1KHz   : STD_LOGIC;

begin

    pulseGenerator_cut : entity work.pulseGenerator
        port map (
            clk      => clock,
            reset    => reset,
            maxCount => MaxCounter1,
            pulseOut => Pulse1KHz
        );

    -- Reset stimulus
    reset <= '0',
             '1' after 20 ns,
             '0' after 100 ns;

    -- Use a tiny count first.
    -- Pulse should occur every 10 clock cycles.
    MaxCounter1 <= to_unsigned(9, 27);

    -- 100 MHz clock: 10 ns period
    process
    begin
        clock <= '1';
        wait for 5 ns;
        clock <= '0';
        wait for 5 ns;
    end process;

end Behavioral;
