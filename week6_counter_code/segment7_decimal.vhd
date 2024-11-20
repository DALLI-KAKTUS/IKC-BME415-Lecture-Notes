library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;  -- Numeric_std kullanımı

entity segment7_decimal is
	port(
		BCDin : in std_logic_vector(3 downto 0);
		Op_Active_high : out std_logic_vector(6 downto 0)
	);

end segment7_decimal;

architecture Dataflow of segment7_decimal is
	signal seven_segment : std_logic_vector(6 downto 0);
begin
	with BCDin select
		seven_segment <= "1000000" when "0000",
							  "1111001" when "0001",
							  "0100100" when "0010",
							  "0110000" when "0011",
							  "0011001" when "0100",
							  "0010010" when "0101",
							  "0000010" when "0110",
							  "1111000" when "0111",
							  "0000000" when "1000",
							  "0010000" when "1001",
							  "0001000" when "1010",
							  "0000011" when "1011",
							  "1000110" when "1100",
							  "0100001" when "1101",
							  "0000110" when "1110",
							  "0001110" when others;
Op_Active_high(0) <= seven_segment(0);
Op_Active_high(1) <= seven_segment(1);
Op_Active_high(2) <= seven_segment(2);
Op_Active_high(3) <= seven_segment(3);
Op_Active_high(4) <= seven_segment(4);
Op_Active_high(5) <= seven_segment(5);
Op_Active_high(6) <= seven_segment(6);
end Dataflow;

