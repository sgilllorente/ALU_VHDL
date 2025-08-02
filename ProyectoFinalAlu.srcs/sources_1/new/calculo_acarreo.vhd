----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/04/2025 01:15:22 PM
-- Design Name: 
-- Module Name: calculo_acarreo - Behavioral
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

entity calculo_acarreo is
    Generic ( N : integer := 3);
    Port ( G   : in  STD_LOGIC_VECTOR(N downto 0);
           P   : in  STD_LOGIC_VECTOR(N downto 0);
           Cin : in  STD_LOGIC;
           Cout: out STD_LOGIC_VECTOR(N downto 0));
end calculo_acarreo;

architecture Behavioral of calculo_acarreo is
begin
    process(G, P, Cin)
        variable v_Cout : STD_LOGIC_VECTOR(N downto 0);
    begin
        for i in 0 to N loop
            if i = 0 then
                v_Cout(i) := G(i) or (P(i) and Cin);
            else
                v_Cout(i) := G(i) or (P(i) and v_Cout(i - 1));
            end if;
            Cout(i) <= v_Cout(i);
        end loop;
    end process;
end Behavioral;
