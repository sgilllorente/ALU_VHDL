----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/02/2025 01:17:52 PM
-- Design Name: 
-- Module Name: mux2a1 - Behavioral
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

entity mux2a1 is
    Port ( a : in  STD_LOGIC_VECTOR(4 downto 0);
           b : in  STD_LOGIC_VECTOR(4 downto 0);
           s : in STD_LOGIC;
           z : out  STD_LOGIC_VECTOR(4 downto 0));
end mux2a1;

architecture Behavioral of mux2a1 is

begin
    process (a,b,s)
    begin 
        case s is
            when '0' => z <= a;
            when '1' => z <= b;
            when others => z<= "00000";
        end case;
     end process;

end Behavioral;