library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity multiplicador_Shift_and_Add is

    Port (
        A        : in  STD_LOGIC_VECTOR (4 downto 0);  -- Número con signo
        B        : in  STD_LOGIC_VECTOR (4 downto 0);  -- Número con signo
        S        : out STD_LOGIC_VECTOR (4 downto 0);  -- Resultado truncado
        overflow : out STD_LOGIC
    );
end multiplicador_Shift_and_Add;

architecture Behavioral of multiplicador_Shift_and_Add is

    component sumador_4bits_BrentKung is
        Port (
            A     : in  STD_LOGIC_VECTOR (4 downto 0);
            B     : in  STD_LOGIC_VECTOR (4 downto 0);
            C_in  : in  STD_LOGIC;
            S     : out STD_LOGIC_VECTOR (4 downto 0);
            C_out : out STD_LOGIC
        );
    end component;

    signal PP0, PP1, PP2, PP3, PP4 : STD_LOGIC_VECTOR(4 downto 0);
    signal sum0, sum1, sum2, sum3  : STD_LOGIC_VECTOR(4 downto 0);
    signal carry0, carry1, carry2, carry3 : STD_LOGIC;

    -- Detectar si hay pérdida significativa en los bits altos
    signal overflow_bits : STD_LOGIC_VECTOR(3 downto 0);

begin

    -- Producto parcial A * B(0) (sin desplazamiento)
    PP0 <= (4 => A(4) and B(0),
            3 => A(3) and B(0),
            2 => A(2) and B(0),
            1 => A(1) and B(0),
            0 => A(0) and B(0));

    -- A * B(1) << 1
    PP1 <= (4 => A(3) and B(1),  -- desplazado a la izquierda 1 vez
            3 => A(2) and B(1),
            2 => A(1) and B(1),
            1 => A(0) and B(1),
            0 => '0');

    SUM32 : sumador_4bits_BrentKung
        port map (A => PP0, B => PP1, C_in => '0', S => sum0, C_out => carry0);

    -- A * B(2) << 2
    PP2 <= (4 => A(2) and B(2),
            3 => A(1) and B(2),
            2 => A(0) and B(2),
            1 => '0',
            0 => '0');

    SUM43 : sumador_4bits_BrentKung
        port map (A => sum0, B => PP2, C_in => '0', S => sum1, C_out => carry1);

    -- A * B(3) << 3
    PP3 <= (4 => A(1) and B(3),
            3 => A(0) and B(3),
            2 => '0',
            1 => '0',
            0 => '0');

    SUM23 : sumador_4bits_BrentKung
        port map (A => sum1, B => PP3, C_in => '0', S => sum2, C_out => carry2);

    -- A * B(4) << 4
    PP4 <= (4 => A(0) and B(4),
            3 => '0',
            2 => '0',
            1 => '0',
            0 => '0');

    SUM45 : sumador_4bits_BrentKung
        port map (A => sum2, B => PP4, C_in => '0', S => sum3, C_out => carry3);

    -- Salida final: solo 5 bits menos significativos
    S <= sum3;

    -- Overflow: si algún acarreo es '1' o el resultado no cabe en 5 bits con signo
    overflow <= carry0 or carry1 or carry2 or carry3;

end Behavioral;
