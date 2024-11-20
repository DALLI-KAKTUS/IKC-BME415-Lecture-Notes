library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity clock_divider is
	generic (
		divide_by : integer := 25000000
	);
	port ( 
		clk,rst: in std_logic;
		clock_out: out std_logic
		);
end clock_divider;

architecture Behavioral of clock_divider is
	signal count: integer := 1;
	signal tmp : std_logic := '0';
begin
	process(clk,rst,tmp)
	begin
		if(rst='1') then
			count<=1;
			tmp<='0';
		elsif(clk'event and clk='1') then
			count <=count+1;
			if (count = divide_by) then
			tmp <= NOT tmp;
			count <= 1;
		end if;
		end if;
		clock_out <= tmp;
	end process;

end Behavioral;

