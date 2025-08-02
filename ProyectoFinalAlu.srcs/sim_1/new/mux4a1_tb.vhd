library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_mux4a1 is
end tb_mux4a1;

architecture Behavioral of tb_mux4a1 is

    -- Declaración del componente a testear
    component mux4a1
        Port (
            a  : in  STD_LOGIC_VECTOR(4 downto 0);
            b  : in  STD_LOGIC_VECTOR(4 downto 0);
            c  : in  STD_LOGIC_VECTOR(4 downto 0);
            d  : in  STD_LOGIC_VECTOR(4 downto 0);
            s1 : in  STD_LOGIC;
            s2 : in  STD_LOGIC;
            z  : out STD_LOGIC_VECTOR(4 downto 0)
        );
    end component;

    -- Señales para conectar al DUT
    signal a, b, c, d, z : STD_LOGIC_VECTOR(4 downto 0);
    signal s1, s2        : STD_LOGIC;

begin

    -- Instancia del DUT
    uut: mux4a1
        port map (
            a  => a,
            b  => b,
            c  => c,
            d  => d,
            s1 => s1,
            s2 => s2,
            z  => z
        );

    -- Proceso de estímulo
    stim_proc: process
    begin
        -- Asignar valores conocidos a entradas
        a <= "00111";
        b <= "01010";
        c <= "01101";
        d <= "11111";

        -- s2s1 = 00 → debe salir a = "00001"
        s2 <= '0'; s1 <= '0';
        wait for 10 ns;

        -- s2s1 = 01 → debe salir b = "00010"
        s2 <= '1'; s1 <= '0';
        wait for 10 ns;

        -- s2s1 = 10 → debe salir c = "00100"
        s2 <= '0'; s1 <= '1';
        wait for 10 ns;

        -- s2s1 = 11 → debe salir d = "01000"
        s2 <= '1'; s1 <= '1';
        wait for 10 ns;

        wait;
    end process;

end Behavioral;
