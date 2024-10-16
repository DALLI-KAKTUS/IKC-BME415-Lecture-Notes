library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
entity tutorial1 is
    Port ( enable : in  STD_LOGIC; -- define enable as input
           reset : in  STD_LOGIC; -- define reset as input
           clock : in  STD_LOGIC; -- define clock as input
           counterValue : out  STD_LOGIC_VECTOR (2 downto 0) -- define output as 3 bit vector output
	  ); 
end tutorial1;

architecture Behavioral of tutorial1 is 
	signal output:  unsigned( 2 downto 0 ) ; -- define counter value as output signal
begin --begin the module
	counterValue <= std_logic_vector(output); -- turn unsigned to vector
	process(clock, reset) -- Process sensitive to clock and reset signals
	begin
		if reset = '1' then -- if reset is one then do the following
			output <= (others => '0'); -- '<=' means assign, other means all bits inside q, => '0' means map to 0.
														-- its a bit confusing when to use '=>' or '<= 'or ':=' etc. We will cover that later.
														-- so this line says define 0 to all bits inside q
														
			elsif(rising_edge(clock))then -- when clock pulses then do the following
													-- we dont include reset inside here so reset will be async interupt.
				if enable = '0' then
				output <= output + 1; 
				else
				output <= output - 1;
				end if;
			end if;
	end process;

end Behavioral; --end the module

