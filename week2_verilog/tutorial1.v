module tutorial1( counterValue, reset, clock, enable);
input enable; // Increment our counter on rising edge of 'count'
input reset; // Reset our counter on rising edge of 'reset'
input clock; // Synchronize outputs to clock
output counterValue; // Internally store the counter value
reg [2:0] counterValue;
// This takes care of synchronously driving the outputs
always @ ( posedge clock) begin //at the positive edge of the clock
	if( reset == 1'b1 ) begin //if reset is high
	counterValue <= 3'b000; //then set the counter to 0000
	end
	else if( enable == 1'b0) begin //if enable is low and reset is high
	counterValue <= counterValue + 1'b1; //count up
	end
	else if( enable == 1'b1) begin //if enable is high and reset is high
	counterValue <= counterValue - 1'b1; //count down
	end
end
endmodule