/* top_60.v
*      Yashas Prasad
*      7/29/2026
*      197311 Digital Circuit Design with HDL for High Schoolers
*/

//Part 1:  Implement the design with behavioral Verilog.  
//         Your module design must use the assignment API definition:
module top_60 #(parameter CLK_DIV_INT=10) (
    input clk,
    input pause,
    output [3:0] low_digit, //60 second low digit counter
    output [2:0] high_digit, //60 second high digit counter
    output [3:0] muxed_digits, //multiplex the digits onto a 4-bit data stream
    output en_high_digit, //‘1’ when high_digit is output in muxed_digits (0 otherwise)
    output en_low_digit //‘1’ when low_digit is output in muxed_digits (0 otherwise)
);


    //Part 2, Part 3:  Create "enable" to enable a low_digit timer to count.
    //   (a) Declare low_digit enable signal called "enable" as wire.
    //   (b) Instantiate a clock_divider instance called "clk_divider". (see Clock Dividers lecture unit)
    //          Set clock divide ratio as CLK_DIV_INT.
    //          Set clk and pause as this module's clk and pause input signals.
    //          Generate "enable".
    wire enable;
    clock_divider #(.CLK_DIV_INT(CLK_DIV_INT)) clk_divider (.clk(clk), .pause(pause), .rco_enable(enable));



    //Part 4, Part 5:  Create "low_digit" and "high_digit" from timer_60.
    //   Instantiate a timer_60 instance called "timer". (see Digital Timers lecture unit)
    //       Set clk as this module's clk input signal.
    //       Set enable as the "enable" signal generated in Part 2.
    //       Generate "low_digit" and "high_digit".
    timer_60 timer(.clk(clk), .enable(enable), .low_digit(low_digit), .high_digit(high_digit));


    //Part 6:  Generate a multiplexed output 4-bit data stream called "muxed_digits" and enable 
    //         signal called "data_en" for low_digit and high_digit.
    //   (a) Declare 8-bit signal vector called "digits" comprised of logic-0, high_digit, low_digit.
    //       Note, the multiplexer in data_plexer_en assumes the same width inputs so pad the high digit.
    //   (b) Instantiate a data_plexer_en instance called "mux_en".
    //          Set input width as 4.
    //          Set number of select bits as 1 (to select between high_digit and low_digit).
    //          Set data_in as the input signal vector "digits" from part (a).
    //          Set sel_ctrl as this module's clk input signal.
    //          Generate "muxed_digits".
    wire[7:0] digits = {1'b0, high_digit, low_digit};
    wire[1:0] data_en;
    data_plexer_en #(.INPUT_WIDTH(4), .SEL(1)) mux_en (.data_in(digits), .sel_ctrl(clk), .data_out(muxed_digits), .data_en(data_en));


    //Part 7: Generate 2 enable signals, called "en_high_digit" and "en_low_digit" for the multiplexed output 
    //        (muxed_digits) which is logic 1 when the active digit is output on the muxed_digits signal.  
    assign en_high_digit = data_en[1];
    assign en_low_digit = data_en[0];

endmodule
