library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_multiplicador_Shift_and_Add is
end tb_multiplicador_Shift_and_Add;

architecture Behavioral of tb_multiplicador_Shift_and_Add is

    -- Componente a probar
    component multiplicador_Shift_and_Add is
        Port (
            A        : in  STD_LOGIC_VECTOR (4 downto 0);
            B        : in  STD_LOGIC_VECTOR (4 downto 0);
            S        : out STD_LOGIC_VECTOR (4 downto 0);
            overflow : out STD_LOGIC
        );
    end component;

    -- Se�ales internas para conectar al DUT (Device Under Test)
    signal A        : STD_LOGIC_VECTOR (4 downto 0) := (others => '0');
    signal B        : STD_LOGIC_VECTOR (4 downto 0) := (others => '0');
    signal S        : STD_LOGIC_VECTOR (4 downto 0);
    signal overflow : STD_LOGIC;

begin

    -- Instanciaci�n del DUT
    uut: multiplicador_Shift_and_Add
        port map (
            A        => A,
            B        => B,
            S        => S,
            overflow => overflow
        );

    -- Proceso de estimulaci�n
    stim_proc: process
    begin
        -- Prueba 1: 3 x 2
        A <= "10011"; -- 3
        B <= "10010"; -- 2
        wait for 10 ns;

        -- Prueba 2: 5 x 4
        A <= "00101"; -- 5
        B <= "00100"; -- 4
        wait for 10 ns;

        -- Prueba 3: 15 x 1
        A <= "01111"; -- 15
        B <= "00001"; -- 1
        wait for 10 ns;

        -- Prueba 4: 31 x 31 (m�ximo 5 bits)
        A <= "11111"; -- 31
        B <= "11111"; -- 31
        wait for 10 ns;

        -- Prueba 5: 0 x 5
        A <= "00000"; -- 0
        B <= "00101"; -- 5
        wait for 10 ns;

        -- Finaliza simulaci�n
        wait;
    end process;

end Behavioral;
