library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity double_dabbler is
    Port ( BIN : in  STD_LOGIC_VECTOR(15 downto 0);
           BCD : out  STD_LOGIC_VECTOR(19 downto 0));
end double_dabbler;

architecture Behavioral of double_dabbler is
begin

bcd_proc: process(BIN)
	variable scratch : UNSIGNED(35 downto 0) := (others => '0');
begin
	scratch(35 downto 0) := (others => '0');
	scratch(15 downto 0) := unsigned(BIN);
	for i in 0 to 15 loop
		if scratch(34 downto 31) > 4 then
			scratch(35 downto 31) := scratch(35 downto 31) + 3;
		end if;
		if scratch(31 downto 28) > 4 then
			scratch(35 downto 28) := scratch(35 downto 28) + 3;
		end if;
		if scratch(27 downto 24) > 4 then
			scratch(35 downto 24) := scratch(35 downto 24) + 3;
		end if;
		if scratch(23 downto 20) > 4 then
			scratch(35 downto 20) := scratch(35 downto 20) + 3;
		end if;
		if scratch(19 downto 16) > 4 then
			scratch(35 downto 16) := scratch(35 downto 16) + 3;
		end if;
		scratch(35 downto 1) := scratch(34 downto 0);
		scratch(0) := '0';
	end loop;
	BCD <= STD_LOGIC_VECTOR(scratch(35 downto 16));
end process;

end Behavioral;