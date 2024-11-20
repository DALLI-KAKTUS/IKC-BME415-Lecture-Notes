library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity main is
    Port (
        clk_main     : in  STD_LOGIC;          -- Saat sinyali
        rst     : in  STD_LOGIC;               -- Sıfırlama sinyali
		  -- sayaç modülü portları
        dir     : in  STD_LOGIC;               -- Sayma yönü (1: yukarı, 0: aşağı)
		  manual : in STD_LOGIC_VECTOR(6 downto 0); -- el ile sayı girme
		  set : in STD_LOGIC; -- manuel set butonu
        -- 7 Segment ekran çıkışları
		  digit_7seg_main : out STD_LOGIC_VECTOR(6 downto 0);  -- BASAMAK
		  digit_sel_main  : out STD_LOGIC_VECTOR(3 downto 0)  -- Basamak seçici
			
    );
end main;

architecture Behavioral of main is
	  -- Sayıcı modülüne ait sinyal
	 signal count_main : STD_LOGIC_VECTOR(15 downto 0);
	 signal clk_counter : STD_LOGIC;
	 signal clk_display : STD_LOGIC;
begin
	
	-- saat bölücü modülünü çağırma ve ekran için ayarlama
	 clock_divider_diplay_inst : entity work.clock_divider
	 	generic map(divide_by => 50000)
		port map(
			clk => clk_main,
			rst => rst,
			clock_out => clk_display
		);
		
	-- saat bölücü modülünü çağırma ve sayaç için ayarlama
	 clock_divider_counter_inst : entity work.clock_divider
	   generic map(divide_by => 25000000)
		port map(
			clk => clk_main,
			rst => rst,
			clock_out => clk_counter
		);
		

	-- sayaç modülünü çağırma
    counter_inst : entity work.counter_0_to_9999
        port map (
            clk => clk_counter,
            rst => rst,
            dir => dir,
				set => set,
				manual => manual,
				countOut => count_main
        );
	-- display modülünü çağırma
	 display_inst : entity work.display_driver
        port map (
            clk => clk_display,
            rst => rst,
				BIN => count_main,
				digit_7seg => digit_7seg_main, -- BASAMAK
				digit_sel  => digit_sel_main -- Basamak seçici
        );


end Behavioral;

