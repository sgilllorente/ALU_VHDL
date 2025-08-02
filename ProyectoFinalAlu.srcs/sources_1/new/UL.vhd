library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity UL is
    port (
        A     : in  STD_LOGIC_VECTOR(4 downto 0);
        B     : in  STD_LOGIC_VECTOR(4 downto 0);
        S     : in  STD_LOGIC_VECTOR(2 downto 0);  -- Selector general (3 bits)
        Z     : out STD_LOGIC_VECTOR(4 downto 0)
    );
end UL;

architecture Behavioral of UL is

begin
    process(A, B, S)
    begin
        case S(1 downto 0) is  -- Sólo se usan los bits menos significativos
            when "00" =>
                Z <= A and B;
            when "01" =>
                Z <= A or B;
            when "10" =>
                Z <= A xor B;
            when "11" =>
                Z <= not A;
            when others =>
                Z <= (others => '0');
        end case;
    end process;
end Behavioral;
