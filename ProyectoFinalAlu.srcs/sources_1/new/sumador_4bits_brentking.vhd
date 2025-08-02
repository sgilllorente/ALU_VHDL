----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/04/2025 01:19:03 PM
-- Design Name: 
-- Module Name: sumador_4bits_brentking - Behavioral
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

entity sumador_4bits_BrentKung is
    Generic ( N : integer := 4);
    Port ( A     : in  STD_LOGIC_VECTOR(N downto 0);
           B     : in  STD_LOGIC_VECTOR(N downto 0);
           C_in  : in  STD_LOGIC;
           S     : out STD_LOGIC_VECTOR(N downto 0);
           C_out : out STD_LOGIC );
end sumador_4bits_BrentKung;

architecture Behavioral of sumador_4bits_BrentKung is

    component generador_GP
        Generic ( N : integer);
        Port ( A : in STD_LOGIC_VECTOR (N downto 0);
               B : in STD_LOGIC_VECTOR (N downto 0);
               G : out STD_LOGIC_VECTOR (N downto 0);
               P : out STD_LOGIC_VECTOR (N downto 0));
    end component;

    component calculo_acarreo
       Generic ( N : integer);
        Port ( G   : in  STD_LOGIC_VECTOR(N downto 0);
               P   : in  STD_LOGIC_VECTOR(N downto 0);
               Cin : in  STD_LOGIC;
               Cout: out STD_LOGIC_VECTOR(N downto 0));
    end component;

    signal G, P, C : STD_LOGIC_VECTOR(N downto 0);

begin

    Gen_GP: generador_GP
        generic map (N =>4)
        port map (A => A, B => B, G => G, P => P);

    Cal_Aca: calculo_acarreo
        generic map (N =>4)
        port map (G=> G, P => P, Cin => C_in, Cout => C);


    process(A, B, C_in, C, P)
    begin
        S(0) <= P(0) xor C_in;
        for i in 1 to N loop
            S(i) <= P(i) xor C(i - 1);
        end loop;
        --S(N+1) <= C(N);
        C_out <= C(N);
    end process;

end Behavioral;
