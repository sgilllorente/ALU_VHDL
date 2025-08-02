----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/02/2025 01:28:42 PM
-- Design Name: 
-- Module Name: mux41 - Behavioral
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

entity mux4a1 is
    Port ( a : in STD_LOGIC_VECTOR(4 downto 0);
           b : in STD_LOGIC_VECTOR(4 downto 0);
           c : in STD_LOGIC_VECTOR(4 downto 0);
           d : in STD_LOGIC_VECTOR(4 downto 0);
           s1 : in STD_LOGIC;
           s2 : in STD_LOGIC;
           z : out STD_LOGIC_VECTOR(4 downto 0));
end mux4a1;

architecture Behavioral of mux4a1 is
signal ab, cd : STD_LOGIC_VECTOR(4 downto 0);

component mux2a1
  Port ( a : in STD_LOGIC_VECTOR(4 downto 0);
           b : in STD_LOGIC_VECTOR(4 downto 0);
           s : in STD_LOGIC;
           z : out STD_LOGIC_VECTOR(4 downto 0));
end component;

begin

    inst1:mux2a1
        port map ( 
            a => a,
            b =>b,
            s => s2,
            z => ab);
    inst2:mux2a1
        port map ( 
            a => c,
            b =>d,
            s => s2,
            z => cd);
     inst3:mux2a1
        port map ( 
            a => ab,
            b =>cd,
            s => s1,
            z => z);
    


end Behavioral;
