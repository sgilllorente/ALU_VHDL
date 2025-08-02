library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_mux2a1 is
end tb_mux2a1;

architecture Behavioral of tb_mux2a1 is

    -- Declaración del componente a testear
    component mux2a1
        Port (
            a : in  STD_LOGIC_VECTOR(4 downto 0);
            b : in  STD_LOGIC_VECTOR(4 downto 0);
            s : in  STD_LOGIC;
            z : out STD_LOGIC_VECTOR(4 downto 0)
        );
    end component;

    -- Señales internas para el DUT
    signal a, b, z : STD_LOGIC_VECTOR(4 downto 0);
    signal s       : STD_LOGIC;

begin

    -- Instancia del DUT
    uut: mux2a1
        port map (
            a => a,
            b => b,
            s => s,
            z => z
        );

    -- Proceso de estímulo
    stim_proc: process
    begin
        -- Asignar valores a y b
        a <= "10101";
        b <= "01010";

        -- s = 0 → debe salir z = a
        s <= '0';
        wait for 10 ns;

        -- s = 1 → debe salir z = b
        s <= '1';
        wait for 10 ns;

        -- Finalizar simulación
        wait;
    end process;

end Behavioral;
