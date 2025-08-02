library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity UL_tb is
end UL_tb;

architecture Behavioral of UL_tb is

    -- Componente bajo prueba
    component UL is
        port (
            A : in  STD_LOGIC_VECTOR(4 downto 0);
            B : in  STD_LOGIC_VECTOR(4 downto 0);
            S : in  STD_LOGIC_VECTOR(2 downto 0);
            Z : out STD_LOGIC_VECTOR(4 downto 0)
        );
    end component;

    -- Señales internas
    signal A : STD_LOGIC_VECTOR(4 downto 0) := (others => '0');
    signal B : STD_LOGIC_VECTOR(4 downto 0) := (others => '0');
    signal S : STD_LOGIC_VECTOR(2 downto 0) := "000";
    signal Z : STD_LOGIC_VECTOR(4 downto 0);

begin

    -- Instancia del DUT
    DUT: UL
        port map (
            A => A,
            B => B,
            S => S,
            Z => Z
        );

    -- Estímulos
    stim_proc : process
    begin
        -- Caso 1: AND
        A <= "10101"; B <= "11011"; S <= "000";  -- S(1 downto 0) = "00"
        wait for 10 ns;

        -- Caso 2: OR
        A <= "10101"; B <= "11011"; S <= "001";  -- S(1 downto 0) = "01"
        wait for 10 ns;

        -- Caso 3: XOR
        A <= "10101"; B <= "11011"; S <= "010";  -- S(1 downto 0) = "10"
        wait for 10 ns;

        -- Caso 4: NOT A
        A <= "10101"; B <= "11011"; S <= "011";  -- S(1 downto 0) = "11"
        wait for 10 ns;

        -- Caso extra: otros (no debería pasar, pero por si acaso)
        A <= "00000"; B <= "00000"; S <= "111";  -- S(1 downto 0) = "11", pero S(2) activo
        wait for 10 ns;

        wait;
    end process;

end Behavioral;
