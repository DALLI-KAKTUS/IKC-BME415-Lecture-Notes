library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;  -- Numeric_std kullanımı
-- 7 segment display driver
entity display_driver is
    Port (
		  rst : in  STD_LOGIC; -- senkronizasyon için reset
        clk     : in  STD_LOGIC;               -- Saat sinyali
		  BIN		 : in  STD_LOGIC_VECTOR(15 downto 0);-- binary giriş
        -- 7 Segment ekran çıkışları
        digit_7seg : out STD_LOGIC_VECTOR(6 downto 0);  -- BASAMAK
		  digit_sel  : out STD_LOGIC_VECTOR(3 downto 0)  -- Basamak seçici
    );
end display_driver;

architecture Behavioral of display_driver is
	 signal digit_7seg_bin : STD_LOGIC_VECTOR(3 downto 0);
	 signal digit_sel_count : unsigned(1 downto 0);
	 signal BCD_sig : STD_LOGIC_VECTOR(19 downto 0);
	 signal BIN_sig : STD_LOGIC_VECTOR(15 downto 0);
begin
		 -- double dabbler
	  double_dabbler_inst : entity work.double_dabbler
		  port map (
				BIN => BIN_sig,
				BCD => BCD_sig
		  );
	process(clk, BIN, BCD_sig, rst) -- her saat vuruşunda veya herhangi bir değişiklikte
   begin
		if rising_edge(clk) then
			BIN_sig <= BIN;
			digit_sel_count <= "00";
			if rst = '0' then
				
				-- basamak değerini değiştir
				if digit_sel_count = "00" then
					digit_7seg_bin <= BCD_sig(3 downto 0);
					digit_sel <= "1110";
				elsif digit_sel_count = "01" then
					digit_7seg_bin <= BCD_sig(7 downto 4);
					digit_sel <= "1101";
				elsif digit_sel_count = "10" then
					digit_7seg_bin <= BCD_sig(11 downto 8);
					digit_sel <= "1011";
				elsif digit_sel_count = "11" then
					digit_7seg_bin <= BCD_sig(15 downto 12);
					digit_sel <= "0111";
				else
					digit_7seg_bin <= "1111";
					digit_sel <= "1111";
				end if;
				digit_sel_count <= digit_sel_count + 1;
			else
					digit_7seg_bin <= "1111";
					digit_sel <= "1111";
			end if;
		end if;
   end process;
		
	    -- 7 segmentli ekranları bağlama
    segment_inst : entity work.segment7_decimal
        port map (
            BCDin => digit_7seg_bin,
            Op_Active_high => digit_7seg
        );
end Behavioral;

