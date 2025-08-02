library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity multiplicador_ca2 is
    Port (
        A        : in  STD_LOGIC_VECTOR (4 downto 0);  -- Entrada A en CA2
        B        : in  STD_LOGIC_VECTOR (4 downto 0);  -- Entrada B en CA2
        S        : out STD_LOGIC_VECTOR (4 downto 0);  -- Resultado truncado
        overflow : out STD_LOGIC                       -- Overflow
    );
end multiplicador_ca2;

architecture Behavioral of multiplicador_ca2 is

    signal A_abs, B_abs        : STD_LOGIC_VECTOR(4 downto 0);
    signal sign_a, sign_b      : STD_LOGIC;
    signal product_unsigned    : unsigned(9 downto 0); -- 10 bits sin signo
    signal product_signed      : signed(9 downto 0);   -- 10 bits con signo
    signal result_5bit         : signed(4 downto 0);
    signal result_full         : signed(9 downto 0);
    signal sign_result         : STD_LOGIC;

    -- Función para obtener el complemento a 2
    function complemento2(input : STD_LOGIC_VECTOR(4 downto 0)) return STD_LOGIC_VECTOR is
        variable temp : STD_LOGIC_VECTOR(4 downto 0);
    begin
        temp := std_logic_vector(unsigned(not input) + 1);
        return temp;
    end;

begin

    process(A, B)
        variable acc  : unsigned(9 downto 0);
        variable Aext : unsigned(5 downto 0);
        variable Bext : unsigned(4 downto 0);
    begin
        -- Obtener signos
        sign_a <= A(4);
        sign_b <= B(4);
        sign_result <= sign_a xor sign_b;

        -- Obtener valor absoluto en CA2 (con proceso explícito)
        if sign_a = '0' then
            A_abs <= A;
        else
            A_abs <= complemento2(A);
        end if;

        if sign_b = '0' then
            B_abs <= B;
        else
            B_abs <= complemento2(B);
        end if;

        -- Preparar variables locales
        Aext := unsigned("0" & A_abs);  -- 6 bits
        Bext := unsigned(B_abs);        -- 5 bits
        acc  := (others => '0');

        -- Suma parcial estilo multiplicación binaria
        for i in 0 to 4 loop
            if Bext(i) = '1' then
                acc := acc + shift_left(Aext, i);
            end if;
        end loop;

        product_unsigned <= acc;

        -- Ajuste del signo del resultado
        if sign_result = '1' then
            product_signed <= -signed(product_unsigned);
        else
            product_signed <= signed(product_unsigned);
        end if;

        result_full <= product_signed;
        result_5bit <= result_full(4 downto 0);
        S <= std_logic_vector(result_5bit);

        -- Detección de overflow
        if (result_full(9) /= result_full(4) or
            result_full(8) /= result_full(4) or
            result_full(7) /= result_full(4) or
            result_full(6) /= result_full(4) or
            result_full(5) /= result_full(4)) then
            overflow <= '1';
        else
            overflow <= '0';
        end if;

    end process;

end Behavioral;
