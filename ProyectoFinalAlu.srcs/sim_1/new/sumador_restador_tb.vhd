----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.07.2025 12:41:18
-- Design Name: 
-- Module Name: sumador_restador_tb - Behavioral
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

entity sumador_restador_tb is
--  Port ( );
end sumador_restador_tb;

architecture Behavioral of sumador_restador_tb is
    constant N : integer := 4;

    signal A, B          : STD_LOGIC_VECTOR(N downto 0);
    signal S_R           : STD_LOGIC;
    signal S             : STD_LOGIC_VECTOR(N downto 0);
    signal C_out         : STD_LOGIC;
    signal overflow_signed : STD_LOGIC;

    component sumador_restador_enteros_overflow is
        generic ( N : integer := 4);
        Port (
            A : in  STD_LOGIC_VECTOR(N downto 0);
            B : in  STD_LOGIC_VECTOR(N downto 0);
            S_R : in STD_LOGIC;
            S : out STD_LOGIC_VECTOR(N downto 0);
            C_out : out STD_LOGIC;
            overflow_signed : out STD_LOGIC
        );
    end component;
begin
     uut: sumador_restador_enteros_overflow
        generic map (N => N)
        port map (
            A => A,
            B => B,
            S_R => S_R,
            S => S,
            C_out => C_out,
            overflow_signed => overflow_signed
        );

    process
    begin
        -- Suma: 0100 + 0011 = 0111
        A <= "01000"; B <= "00011"; S_R <= '0';
        wait for 50 ns;

        -- Resta: 0100 - 0011 = 0001
        A <= "01000"; B <= "00011"; S_R <= '1';
        wait for 50 ns;

        -- Suma con overflow: 0100 + 0100 = 1000
        A <= "01000"; B <= "01000"; S_R <= '0';
        wait for 50 ns;

        -- Resta con overflow: 1000 - 0100 = 0100 (overflow negativo)
        A <= "10000"; B <= "01000"; S_R <= '1';
        wait for 50 ns;

        -- Ceros: 0000 + 0000 = 0000
        A <= "00000"; B <= "00000"; S_R <= '0';
        wait for 50 ns;

        wait;
    end process;

end Behavioral;
