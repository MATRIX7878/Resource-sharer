LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD_UNSIGNED.ALL;

ENTITY memory IS
    PORT(clk, RW, en : IN STD_LOGIC;
         addr : IN INTEGER RANGE 0 TO 255;
         dataIn : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
         dataOut : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
        );
END ENTITY;

ARCHITECTURE behavior OF memory IS
TYPE mem IS ARRAY (255 DOWNTO 0) OF STD_LOGIC_VECTOR (31 DOWNTO 0);
SIGNAL storage : mem := (OTHERS => (OTHERS => '0'));


BEGIN

    PROCESS (ALL)
    BEGIN
        IF RISING_EDGE(clk) THEN
            IF en THEN
                IF RW THEN
                    dataOut <= storage(addr);
                ELSE
                    storage(addr) <= dataIn;
                END IF;
            END IF;
        END IF;
    END PROCESS;
END ARCHITECTURE;