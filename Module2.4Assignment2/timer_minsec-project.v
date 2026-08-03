/* timer_minsec.v
*    Generate the count sequence to support a 3rd (minutes) 
*    digit in addition to the 60-second digits from the timer_60 module.
*    Timer module also supports a count direction (up/down) control.
*    Assemble from counter_nbit_updown blocks, 
*    4-bits for the seconds low digit (sec_low_digit), 
*    3 bits for the seconds high digit (sec_high_digit),
*    4-bits for the minutes low digit (min_low_digit).
*/

//Part 1:  Implement the design with behavioral Verilog.  
//         Your module design must use the assignment API definition:
module timer_minsec(
    input clk,
    input enable,
    input up_down,
    output [3:0] sec_low_digit,
    output [2:0] sec_high_digit,
    output [3:0] min_low_digit
);


    //Internal variables
    reg sec_low_load = 1'b0;
    reg sec_high_load = 1'b0;
    reg min_low_load = 1'b0;
    reg sec_high_enable = 1'b0;
    reg min_low_enable = 1'b0;

    integer sec_low_data = 4'b0000;
    integer sec_high_data = 3'b000;
    integer min_low_data = 4'b0000;

    //Instantiate 3 counter_nbit_updown instances representing
    //seconds low and high digit counters and minutes low digit counter.
    //   Set WIDTH to the appropriate bit width for each digit counter.
    //   Set clk, enable, up_down as this module's clk, enable, up_down input signals.
    //   Set data as the appropriate digit rollover value for each digit counter.
    //   Set load to the appropriate digit load signal qualified with the input enable.
    //   Generate sec_low_digit, sec_high_digit, min_low_digit.
    counter_nbit_updown #(.WIDTH(4)) LD (.clk(clk), .enable(enable), .data(sec_low_data), .load(sec_low_load & 	enable), .up_down(up_down), .count(sec_low_digit));
    counter_nbit_updown #(.WIDTH(3)) HD (.clk(clk), .enable(enable & sec_high_enable), .data(sec_high_data), .load(sec_high_load 	& enable), .up_down(up_down), .count(sec_high_digit));
    counter_nbit_updown #(.WIDTH(4)) MD (.clk(clk), .enable(enable & min_low_enable), .data(min_low_data), .load(min_low_load & 	enable), .up_down(up_down), .count(min_low_digit));


    //Activate always block on changes with sec_low_digit or   
    //sec_high_digit or min_low_digits from counter blocks to count 
    //from 000 to 959 then roll back to 00 and count again.
    //Forward count:
    //Reset the load and enable signals then check:
    //   if sec_low_digit is 9 then enable sec_high_digit
    //        and roll sec_low_digit to 0.
    //   if sec_low_digit is 9 and sec_high_digit is 5 then enable min_low_digit and
    //        roll sec_high_digit to 0.
    //   if sec_low_digit is 9 and sec_high_digit is 5 and min_low_digit is 9 then 
    //        roll min_low_digit to 0.
    //Backward count:
    //Reset the load and enable signals then check appropriate values for 
    //sec_low_digit, sec_high_digit, and min_low_digit for load and digit updates. 
    always @ (sec_low_digit or sec_high_digit or min_low_digit) begin
	sec_low_load = 1'b0;
	sec_high_enable = 1'b0;
	sec_high_load = 1'b0;
	min_low_enable = 1'b0;
	min_low_load = 1'b0;

	if (sec_low_digit==9) begin
	    sec_low_load = 1'b1;
	    sec_high_enable = 1'b1;
	end

	if (sec_low_digit==9 & sec_high_digit == 5) begin
	    sec_high_load = 1'b1;
	    min_low_enable = 1'b1;
	end
	
	if (sec_low_digit==9 & sec_high_digit == 5 & min_low_digit == 9) begin
	    min_low_load = 1'b1;
	end
    end

endmodule

