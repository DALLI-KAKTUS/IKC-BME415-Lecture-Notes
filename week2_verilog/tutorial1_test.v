`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   18:51:00 10/16/2024
// Design Name:   tutorial1
// Module Name:   /mnt/hgfs/shared/week2_verilog/tutorial1_test.v
// Project Name:  week2_verilog
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: tutorial1
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tutorial1_test;

	// Inputs
	reg reset;
	reg clock;
	reg enable;

	// Outputs
	wire [2:0] counterValue;

	// Instantiate the Unit Under Test (UUT)
	tutorial1 uut (
		.counterValue(counterValue), 
		.reset(reset), 
		.clock(clock), 
		.enable(enable)
	);
	
	initial clock = 0; // set clock to 0
	always #20 clock = ~clock; //generating clock
	initial begin
		// Initialize Inputs
		reset = 1; // set reset to 1
		enable = 0; // set enable to 0
		#100; //wait 5 clock pulses
		reset = 0; //set reset to 0 so program can start to count
		#200; //wait 10 clock pulses
		enable = 1; // set enable to 1
		#200; //wait 10 clock pulses
	end
      
endmodule

