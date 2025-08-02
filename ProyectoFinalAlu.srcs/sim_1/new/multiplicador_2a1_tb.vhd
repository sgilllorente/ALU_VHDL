library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_multiplicador_ca2 is
end tb_multiplicador_ca2;

architecture Behavioral of tb_multiplicador_ca2 is

    -- Componente a probar
    component multiplicador_ca2 is
        Port (
            A        : in  STD_LOGIC_VECTOR (4 downto 0);
            B        : in  STD_LOGIC_VECTOR (4 downto 0);
            S        : out STD_LOGIC_VECTOR (4 downto 0);
            overflow : out STD_LOGIC
        );
    end component;

    -- Señales internas
    signal A        : STD_LOGIC_VECTOR (4 downto 0) := (others => '0');
    signal B        : STD_LOGIC_VECTOR (4 downto 0) := (others => '0');
    signal S        : STD_LOGIC_VECTOR (4 downto 0);
    signal overflow : STD_LOGIC;

begin

    -- Instanciación del DUT
    uut: multiplicador_ca2
        port map (
            A        => A,
            B        => B,
            S        => S,
            overflow => overflow
        );

    -- Proceso de estímulo (con binarios directamente)
    stim_proc: process
    begin
        -- Prueba 1:  3 x  2 =   6  -> "00011" x "00010"
        A <= "00011";
        B <= "00010";
        wait for 10 ns;

        -- Prueba 2:  5 x  4 =  20
        A <= "00101";
        B <= "00100";
        wait for 10 ns;

        -- Prueba 3: 15 x  1 =  15
        A <= "01111";
        B <= "00001";
        wait for 10 ns;

        -- Prueba 4: -3 x  2 =  -6
        A <= "11101";  -- -3 en CA2
        B <= "00010";  -- 2
        wait for 10 ns;

        -- Prueba 5: -4 x -2 =   8
        A <= "11100";  -- -4
        B <= "11110";  -- -2
        wait for 10 ns;

        -- Prueba 6:  7 x -3 = -21
        A <= "00111";
        B <= "11101";  -- -3
        wait for 10 ns;

        -- Prueba 7: -7 x -4 =  28
        A <= "11001";  -- -7
        B <= "11100";  -- -4
        wait for 10 ns;

        -- Prueba 8: 16 x 2 = 32 -> overflow esperado
        A <= "10000";  -- -16 en CA2 (esperado overflow por truncado)
        B <= "00010";
        wait for 10 ns;

        -- Prueba 9: 0 x 5 = 0
        A <= "00000";
        B <= "00101";
        wait for 10 ns;

        wait;  -- Finaliza simulación
    end process;

end Behavioral;
