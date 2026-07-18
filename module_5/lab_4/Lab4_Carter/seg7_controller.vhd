----------------------------------------------------------------------------------
--  Author: Liam Carter
-- 
-- Design Name: 
-- Module Name: seg7_controller - Behavioral
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

entity seg7_controller is
    Port ( 
           clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           char0 : in STD_LOGIC_VECTOR (3 downto 0);
           char1 : in STD_LOGIC_VECTOR (3 downto 0);
           char2 : in STD_LOGIC_VECTOR (3 downto 0);
           char3 : in STD_LOGIC_VECTOR (3 downto 0);
           char4 : in STD_LOGIC_VECTOR (3 downto 0);
           char5 : in STD_LOGIC_VECTOR (3 downto 0);
           char6 : in STD_LOGIC_VECTOR (3 downto 0);
           char7 : in STD_LOGIC_VECTOR (3 downto 0);

           SEG7_CATH : out STD_LOGIC_VECTOR (7 downto 0);
           AN : out STD_LOGIC_VECTOR (7 downto 0)
            );
end seg7_controller;

architecture Behavioral of seg7_controller is
    signal pulse_1khz : STD_LOGIC;
    signal digit_sel : unsigned(2 downto 0) := (others => '0');
    signal active_char : STD_LOGIC_VECTOR(3 downto 0);
begin

    pulse_1khz_gen : entity work.pulseGenerator
        port map (
            clk => clk,
            reset => reset,
            maxCount => to_unsigned(99999, 27), -- 100 MHz / 100000 = 1 kHz
            pulseOut => pulse_1khz
        );

    -- Current anode counter
    process(clk, reset)
    begin
        if reset = '1' then
            digit_sel <= (others => '0');
        elsif rising_edge(clk) then
            if pulse_1khz = '1' then
                digit_sel <= digit_sel + 1;
            end if;
        end if;
    end process;

    anode_decode_inst : entity work.seg7_anode_decode
        port map (
            digit_sel => std_logic_vector(digit_sel),
            AN => AN
        );

    char_mux_inst : entity work.char_mux_8to1
        port map (
            digit_sel => std_logic_vector(digit_sel),

            char0 => char0,
            char1 => char1,
            char2 => char2,
            char3 => char3,
            char4 => char4,
            char5 => char5,
            char6 => char6,
            char7 => char7,

            char_out => active_char
        );

    seg7_hex_inst : entity work.seg7_hex
        port map (
            digit => active_char,
            seg7 => SEG7_CATH
        );

end Behavioral;
