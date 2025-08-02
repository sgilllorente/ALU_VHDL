----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.07.2025 11:58:52
-- Design Name: 
-- Module Name: sumador_restador_enteros_overflow - Behavioral
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

entity sumador_restador_enteros_overflow is
    generic ( N : integer := 4 );  -- Operación sobre N+1 bits
    Port (
        A : in  STD_LOGIC_VECTOR(N downto 0);
        B : in  STD_LOGIC_VECTOR(N downto 0);
        S_R : in STD_LOGIC; -- '0' = suma, '1' = resta
        S : out STD_LOGIC_VECTOR(N downto 0);
        C_out : out STD_LOGIC;
        overflow_signed : out STD_LOGIC
    );
end sumador_restador_enteros_overflow;

architecture Behavioral of sumador_restador_enteros_overflow is

    component complemento_a_1_generico is
        generic (N : integer);
        Port ( A : in STD_LOGIC_VECTOR(N downto 0);
               Z : out STD_LOGIC_VECTOR(N downto 0));
    end component;
    
    component sumador_4bits_BrentKung is
        generic ( N : integer := 4 );
        Port (
            A     : in  STD_LOGIC_VECTOR(N downto 0);
            B     : in  STD_LOGIC_VECTOR(N downto 0);
            C_in  : in  STD_LOGIC;
            S     : out STD_LOGIC_VECTOR(N downto 0);
            C_out : out STD_LOGIC
        );
    end component;
    
    signal B_comp : STD_LOGIC_VECTOR(N downto 0);
    signal B_mux  : STD_LOGIC_VECTOR(N downto 0);
    signal A_int, B_int : STD_LOGIC_VECTOR(N downto 0);
    signal S_int : STD_LOGIC_VECTOR(N downto 0);
    begin
    -- Hacemos el complemento a 1 de B y guardamos en uno B y en otro not B
    complemento: complemento_a_1_generico
        generic map (N => N)
        port map (A => B, Z => B_comp);
        
        
    sumador: sumador_4bits_BrentKung
        generic map (N => N)
        port map (
            A     => A_int,
            B     => B_int,
            C_in  => S_R,      -- Carry-in = 0 para suma, 1 para resta (complemento a 2)
            S     => S_int,
            C_out => C_out
        );
        
     -- Sumador Brent-Kung
    
    
    -- Selección de B: si S_R = '0' (suma) => B; si S_R = '1' (resta) => not B
    Suma_o_Resta: process(B, B_comp, S_R)
    begin
        for i in 0 to N loop
            if S_R = '1' then
                B_mux(i) <= B_comp(i);
            else
                B_mux(i) <= B(i);
            end if;
        end loop;
    end process Suma_o_Resta;

    A_int <= A;
    B_int <= B_mux;
        
    S <= S_int;

    -- Detección de overflow con signo
    process(A_int, B_int, S_int, S_R)
    begin
        if S_R = '0' then -- Suma
            if (A_int(N) = B_int(N)) and (S_int(N) /= A_int(N)) then
                overflow_signed <= '1';
            else
                overflow_signed <= '0';
            end if;
        else -- Resta
            if (A_int(N) /= B_int(N)) and (S_int(N) /= A_int(N)) then
                overflow_signed <= '1';
            else
                overflow_signed <= '0';
            end if;
        end if;
    end process;



end Behavioral;
