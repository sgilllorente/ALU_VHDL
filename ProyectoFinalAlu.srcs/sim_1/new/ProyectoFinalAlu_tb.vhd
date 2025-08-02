library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ProyectoFinalAlu_tb is
end ProyectoFinalAlu_tb;

architecture Behavioral of ProyectoFinalAlu_tb is

    -- Señales internas
    signal A     : STD_LOGIC_VECTOR (4 downto 0) := (others => '0');
    signal B     : STD_LOGIC_VECTOR (4 downto 0) := (others => '0');
    signal S     : STD_LOGIC_VECTOR (2 downto 0) := (others => '0');
    signal Z     : STD_LOGIC_VECTOR (4 downto 0);
    signal over  : STD_LOGIC;

    -- Componente a probar
    component ProyectoFinalAlu
        Port (
            A : in STD_LOGIC_VECTOR (4 downto 0);
            B : in STD_LOGIC_VECTOR (4 downto 0);
            S : in STD_LOGIC_VECTOR (2 downto 0);
            Z : out STD_LOGIC_VECTOR (4 downto 0);
            over : out STD_LOGIC
        );
    end component;

    
begin

    -- Instancia de la ALU
    uut: ProyectoFinalAlu
        port map (
            A => A,
            B => B,
            S => S,
            Z => Z,
            over => over
        );

    -- Proceso de estimulación
    stim_proc: process
    begin
        A <= "01000";  -- 6
        B <= "00101";  -- 3

        -- 000: A AND B
        S <= "000";
        wait for 10 ns;

        -- 001: A OR B
        S <= "001";
        wait for 10 ns;

        -- 010: A XOR B
        S <= "010";
        wait for 10 ns;

        -- 011: NOT A
        S <= "011";
        wait for 10 ns;

        -- 100: A + B
        S <= "100";
        wait for 10 ns;

        -- 101: A - B
        S <= "101";
        wait for 10 ns;

        -- 110: A + 1
        S <= "110";
        wait for 10 ns;

        -- 111: A * B
        S <= "111";
        wait for 10 ns;

        -- Otra prueba con posibles overflows
        A <= "11111";  -- -1 en complemento a 2 con 5 bits
        B <= "11111";  -- -1

        S <= "100"; -- A + B => -2
        wait for 10 ns;

        S <= "101"; -- A - B => 0
        wait for 10 ns;

        S <= "111"; -- A * B => 1 (porque -1 * -1)
        wait for 10 ns;
        
        
        -- Otra prueba con posibles overflows
        A <= "01111";  -- -1 en complemento a 2 con 5 bits
        B <= "00001";  -- -1

        S <= "100"; -- A + B => -2
        wait for 10 ns;

        S <= "101"; -- A - B => 0
        wait for 10 ns;

        S <= "111"; -- A * B => 1 (porque -1 * -1)
        wait for 10 ns;
        wait;
    end process;

end Behavioral;
