----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.07.2025 10:47:43
-- Design Name: 
-- Module Name: complemento_a_1_generico - Behavioral
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

entity complemento_a_1_generico is
    generic (N : integer :=3);
    Port ( A : in STD_LOGIC_VECTOR (N downto 0);
           Z : out STD_LOGIC_VECTOR (N downto 0));
end complemento_a_1_generico;

architecture Behavioral of complemento_a_1_generico is

begin
    process(A) begin
        for i in N downto 0 loop
            Z(i) <= not A(i);
        end loop;
    end process;


end Behavioral;
