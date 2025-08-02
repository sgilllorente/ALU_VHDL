library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity UC is
    Port (
        S        : in  STD_LOGIC_VECTOR(2 downto 0);
        operacion        : out STD_LOGIC_VECTOR(1 downto 0);
        overflow : out STD_LOGIC
    );
end UC;

architecture Behavioral of UC is
begin
    process(S)
    begin
        if S(2) = '0' then
            operacion <= "00";           -- Operación lógica
            overflow <= '0';     -- overflow en operaciones lógicas
        elsif S = "111" then
            operacion <= "01";           -- Suma/resta
            overflow <= '1';     -- overflow en operaciones aritméticas
        else
            operacion <= "10";           -- Multiplicación u otras aritméticas
            overflow <= '1';     -- overflow en operaciones aritméticas
        end if;
    end process;
end Behavioral;
