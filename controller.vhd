LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD_UNSIGNED.ALL;

ENTITY controller IS
    PORT(clk, RW0, RW1, RW2, RW3 : IN STD_LOGIC;
         request : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
         addr0, addr1, addr2, addr3 : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
         data0, data1, data2, data3 : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
         en, RW : OUT STD_LOGIC;
         granted : OUT STD_LOGIC_VECTOR (3 DOWNTO 0) := (OTHERS => '0');
         addr : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
         data : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
        );
END ENTITY;

ARCHITECTURE behavior OF controller IS

SIGNAL queue : STD_LOGIC_VECTOR (15 DOWNTO 0) := (OTHERS => '0');
SIGNAL inQueue : STD_LOGIC_VECTOR (3 DOWNTO 0) := (OTHERS => '0');
SIGNAL nextIndex : STD_LOGIC_VECTOR (1 DOWNTO 0) := (OTHERS => '0');
SIGNAL currIndex : STD_LOGIC_VECTOR (1 DOWNTO 0) := (OTHERS => '0');

SIGNAL notIn : STD_LOGIC_VECTOR (3 DOWNTO 0);
SIGNAL nextIn : STD_LOGIC_VECTOR (3 DOWNTO 0);

BEGIN

    PROCESS(ALL)
    BEGIN
        IF RISING_EDGE(clk) THEN
            notIn <= request AND NOT inQueue;
            nextIn <= "1" WHEN notIn(0) ELSE d"2" WHEN notIn(1) ELSE d"3" WHEN notIn(2) ELSE d"4";
            en <= granted(0) OR granted(1) OR granted(2) OR granted(3);

            IF notIn /= 0 THEN
                queue((nextIndex * 4) + TO_STDLOGICVECTOR(3, 4) DOWNTO (nextIn * 4)) <= nextIn(3 DOWNTO 0);
                inQueue <= inQueue OR nextIn;
                nextIndex <= nextIndex + '1';
            END IF;
        END IF;
    END PROCESS;
END ARCHITECTURE;