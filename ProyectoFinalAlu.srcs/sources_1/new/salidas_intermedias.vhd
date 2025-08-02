----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/08/2025 01:04:21 PM
-- Design Name: 
-- Module Name: salidas_intermedias - Behavioral
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

entity salidas_intermedias is
    Port ( salida_logica : in STD_LOGIC_VECTOR (4 downto 0);
           salida_mult : in STD_LOGIC_VECTOR (4 downto 0);
           salida_suma_resta : in STD_LOGIC_VECTOR (4 downto 0);
           S : in STD_LOGIC_VECTOR (1 downto 0);
           salida_final : out STD_LOGIC_VECTOR (4 downto 0));
end salidas_intermedias;

architecture Behavioral of salidas_intermedias is

    component  mux4a1 is
    Port ( a : in STD_LOGIC_VECTOR(4 downto 0);
           b : in STD_LOGIC_VECTOR(4 downto 0);
           c : in STD_LOGIC_VECTOR(4 downto 0);
           d : in STD_LOGIC_VECTOR(4 downto 0);
           s1 : in STD_LOGIC;
           s2 : in STD_LOGIC;
           z : out STD_LOGIC_VECTOR(4 downto 0));
    end component mux4a1;

begin
     mux4a1_inst:mux4a1
        port map ( 
            a => salida_logica,
            b => salida_mult,
            c => salida_suma_resta,
            d => "00000",
            s1 =>S(1),
            s2 => S(0),
            z => salida_final);

end Behavioral;
