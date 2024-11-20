library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;  -- Numeric_std kullanımı

entity counter_0_to_9999 is
    Port (
        clk    : in  STD_LOGIC;             -- Saat sinyali
        rst    : in  STD_LOGIC;             -- Sıfırlama sinyali
        dir    : in  STD_LOGIC;             -- Yön sinyali (1: yukarı, 0: aşağı)
		  manual : in STD_LOGIC_VECTOR(6 downto 0);
		  set : in STD_LOGIC; 
        countOut : out STD_LOGIC_VECTOR(15 downto 0) -- 14bite sığıyor ancak standart olması için 16 bit tanımlandı
    );
end counter_0_to_9999;

architecture Behavioral of counter_0_to_9999 is
    signal count : unsigned(15 downto 0) := (others => '0');  -- 14-bit unsigned, 0'dan 9999'a kadar
begin
	
    process(clk, rst, manual, set)
    begin
        if rst = '1' then
            count <= (others => '0');  -- Sıfırlama durumunda sayacı sıfırla
        elsif rising_edge(clk) then
				if unsigned(manual) /= 0 and set = '1' then
					count <= resize(unsigned(manual),count'length);
				else
					if dir = '1' then
						 if count = 9999 then
							  count <= (others => '0');  -- 9999'a ulaştığında sayacı sıfırla
						 else
							  count <= count + 1;  -- Yukarı sayma
						 end if;
					else
						 if count = 0 then
							  count <= to_unsigned(9999, count'length);  -- 0'a geldiğinde 9999'a ayarla
						 else
							  count <= count - 1;  -- Aşağı sayma
						 end if;
					end if;
				end if;
        end if;
    end process;
	 
	countOut <= std_logic_vector(count);
		
end Behavioral;