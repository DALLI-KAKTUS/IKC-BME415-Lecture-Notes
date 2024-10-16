LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY tutorial1_test IS
END tutorial1_test;
 
ARCHITECTURE behavior OF tutorial1_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT tutorial1
    PORT(
         enable : IN  std_logic;
         reset : IN  std_logic;
         clock : IN  std_logic;
         counterValue : OUT  std_logic_vector(2 downto 0)
        );
    END COMPONENT;

   --Inputs
   signal enable : std_logic := '0';
   signal reset : std_logic := '0';
   signal clock : std_logic := '0';

 	--Outputs
   signal counterValue : std_logic_vector(2 downto 0);

   -- Clock period definitions
   constant clock_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: tutorial1 PORT MAP (
          enable => enable,
          reset => reset,
          clock => clock,
          counterValue => counterValue
        );

   -- Clock process definitions
   clock_process: process
   begin
		clock <= '0';
		wait for clock_period/2;
		clock <= '1';
		wait for clock_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
		reset <= '1'; --set reset 1
      wait for clock_period*5; -- wait 5 clock pulses for initialization
		reset <= '0'; --set reset to 0 so program can start to count.
		wait for clock_period*10; -- wait for 2^3=8 clock cycles and 2 more for see what was going to happen
		enable <= '1'; -- set enable to 1 so we can see what gonna happen. we are expecting program gonna count down on every clock pulse
		wait for clock_period*10; -- wait for 2^3=8 clock cycles and 2 more for see what was going to happen
   end process;

END;
