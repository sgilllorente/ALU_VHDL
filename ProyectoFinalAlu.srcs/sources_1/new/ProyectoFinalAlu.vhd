----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/08/2025 10:43:39 AM
-- Design Name: 
-- Module Name: ProyectoFinalAlu - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ProyectoFinalAlu is
    Port ( A : in STD_LOGIC_VECTOR (4 downto 0);
           B : in STD_LOGIC_VECTOR (4 downto 0);
           S : in STD_LOGIC_VECTOR (2 downto 0);
           Z : out STD_LOGIC_VECTOR (4 downto 0);
           over : out STD_LOGIC);
end ProyectoFinalAlu;

architecture Behavioral of ProyectoFinalAlu is

 -- Declaracion de componentes
 -- componente UL
    component UL
        port (
            A : in  STD_LOGIC_VECTOR(4 downto 0);
            B : in  STD_LOGIC_VECTOR(4 downto 0);
            S : in  STD_LOGIC_VECTOR(2 downto 0);
            Z : out STD_LOGIC_VECTOR(4 downto 0)
        );
    end component;
    
    -- componente  UC
   component UC is
    Port (
        S        : in  STD_LOGIC_VECTOR(2 downto 0);
        operacion        : out STD_LOGIC_VECTOR(1 downto 0);
        overflow : out STD_LOGIC
    );
    end component UC;
    
    -- componente  Sumador/Restador
    component  sumador_restador_enteros_overflow is
    generic ( N : integer := 4 );  -- Operación sobre N+1 bits
    Port (
        A : in  STD_LOGIC_VECTOR(N downto 0);
        B : in  STD_LOGIC_VECTOR(N downto 0);
        S_R : in STD_LOGIC; -- '0' = suma, '1' = resta
        S : out STD_LOGIC_VECTOR(N downto 0);
        C_out : out STD_LOGIC;
        overflow_signed : out STD_LOGIC
    );
    end component sumador_restador_enteros_overflow;
    
    -- componente  Multiplicador
    component multiplicador_Shift_and_Add is

    Port (
        A        : in  STD_LOGIC_VECTOR (4 downto 0);  
        B        : in  STD_LOGIC_VECTOR (4 downto 0);   
        S        : out STD_LOGIC_VECTOR (4 downto 0);  
        overflow : out STD_LOGIC
    );
    end component multiplicador_Shift_and_Add;
    
    --componente  Multiplicador segunda opción
    component multiplicador_ca2 is
    Port (
        A        : in  STD_LOGIC_VECTOR (4 downto 0);  -- Número con signo (complemento a 2)
        B        : in  STD_LOGIC_VECTOR (4 downto 0);  -- Número con signo (complemento a 2)
        S        : out STD_LOGIC_VECTOR (4 downto 0);  -- Resultado truncado
        overflow : out STD_LOGIC
    );
    end component multiplicador_ca2;
    
    -- componente  Salidas intermedias
    component salidas_intermedias is
    Port ( salida_logica : in STD_LOGIC_VECTOR (4 downto 0);
           salida_mult : in STD_LOGIC_VECTOR (4 downto 0);
           salida_suma_resta : in STD_LOGIC_VECTOR (4 downto 0);
           S : in STD_LOGIC_VECTOR (1 downto 0);
           salida_final : out STD_LOGIC_VECTOR (4 downto 0));
    end component salidas_intermedias;
    
    -- componente  overflows
    component overflows is
    Port ( ovSumador : in STD_LOGIC;
           ovMultiplicador : in STD_LOGIC;
           S : in STD_LOGIC;
           Z : out STD_LOGIC
           );
    end component overflows;
    
    -- Signals
    
    signal ovSumador : STD_LOGIC;
    signal ovMultiplicador : STD_LOGIC;
    signal selector_overflows: STD_LOGIC;
    signal selector_salidas_intermedias: STD_LOGIC_VECTOR(1 downto 0);
    
    signal salida_logica :  STD_LOGIC_VECTOR (4 downto 0);
    signal salida_mult :  STD_LOGIC_VECTOR (4 downto 0);
    signal salida_suma_resta : STD_LOGIC_VECTOR (4 downto 0);

begin

    -- Instancia del componente UL
    UL_inst: UL
        port map (
            A => A,
            B => B,
            S => S,
            Z => salida_logica
        );
    UC_inst: UC
        port map (
            S => S,
            operacion => selector_salidas_intermedias,
            overflow => selector_overflows
        );
    SumadorRestador_inst: sumador_restador_enteros_overflow
        port map (
            A => A,
            B => B,
            S_R => S(0),
            S => salida_suma_resta,
            overflow_signed => ovSumador
        );
--    multiplicador_Shift_and_Add_inst: multiplicador_Shift_and_Add
--        port map (
--            A => A,
--            B => B,
--            S => salida_mult,
--            overflow =>ovMultiplicador
--        );
       multiplicador_ca2_inst: multiplicador_ca2
        port map (
            A => A,
            B => B,
            S => salida_mult,
            overflow =>ovMultiplicador
        );
    salidas_intermedias_inst: salidas_intermedias
        port map (
            salida_logica => salida_logica,
            salida_mult => salida_mult,
            salida_suma_resta => salida_suma_resta,
            S => selector_salidas_intermedias,
            salida_final => Z
        );
     overflows_ins: overflows
        port map (
            ovSumador => ovSumador,
            ovMultiplicador => ovMultiplicador,
            S => selector_overflows,
            Z => over
        );
      


end Behavioral;
