----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/08/2025 12:46:29 PM
-- Design Name: 
-- Module Name: overflows - Behavioral
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

entity overflows is
    Port ( ovSumador : in STD_LOGIC;
           ovMultiplicador : in STD_LOGIC;
           S : in STD_LOGIC;
           Z : out STD_LOGIC
           );
end overflows;

architecture Behavioral of overflows is

begin
    process (S)
    begin 
        case S is
            when '0' => z <= ovSumador;
            when '1' => z <= ovMultiplicador;
            when others => z<= '0';
        end case;
     end process;

end Behavioral;
