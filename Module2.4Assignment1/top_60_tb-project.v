/* top_60_tb.v
*      Yashas Prasad
*      7/29/2026
*      197311 Digital Circuit Design with HDL for High Schoolers
*/


`timescale 1ns/1ns
`define CLK_DIV 5

//Your module design must use the assignment API definition:
module top_60_tb (
    output wire [3:0] low_digit,
    output wire [2:0] high_digit,
    output wire [3:0] muxed_digits,
    output wire en_high_digit,
    output wire en_low_digit
);


    //Simulation signals
    reg clk;
    reg pause = 1'b1;

    //Generate the clock waveform
    //   Set 10ns period and 50% duty cycle
    initial begin
	clk = 0;
	forever
	begin
	    #5 clk = ~clk;
	end
    end


    //Instantiate top_60 module
    //   Set CLK_DIV_INT to defined constant CLK_DIV
    //   Set clk and pause to this module's generated clk and pause signals.
    //   Generate low_digit, high_digit, muxed_digits, en_high_digit, en_low_digit.
    top_60 #(.CLK_DIV_INT(`CLK_DIV)) UUT (.clk(clk), .pause(pause), .low_digit(low_digit), .high_digit(high_digit), .muxed_digits(muxed_digits), .en_high_digit(en_high_digit), .en_low_digit(en_low_digit));


    //Simulate 
    initial begin
       #100           //Enable timer
          pause = 1'b0;           
    end

endmodule
