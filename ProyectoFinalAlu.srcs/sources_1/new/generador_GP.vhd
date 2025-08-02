----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/04/2025 12:56:42 PM
-- Design Name: 
-- Module Name: generador_GP - Behavioral
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

entity generador_GP is
    
    Generic ( N : integer :=3);
    Port ( A : in STD_LOGIC_VECTOR (N downto 0);
           B : in STD_LOGIC_VECTOR (N downto 0);
           G : out STD_LOGIC_VECTOR (N downto 0);
           P : out STD_LOGIC_VECTOR (N downto 0));
end generador_GP;

architecture Behavioral of generador_GP is

begin
    process(A, B)
    begin
        for i in 0 to N loop
            G(i) <= A(i) and B(i); -- Generar (G)
            P(i) <= A(i) xor B(i); -- Propagar (P)
        end loop;
    end process;

end Behavioral;
