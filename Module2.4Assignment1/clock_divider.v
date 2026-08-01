/*
* clock_divider.v
* Divide master clock by:
* terminal count - load + 1
* Where terminal count = all 1's count output.
* Generate rco_enable (ripple carry out) for use
* as 1 clock wide enable signal.
*/

module clock_divider #(parameter CLK_DIV_INT = 10)(
    input clk,
    input pause,
    output reg rco_enable
);
    //simulation outputs
    wire [$clog2(CLK_DIV_INT)-1:0] count;

    //Instantiate the counter module
    counter_nbit #(.WIDTH($clog2(CLK_DIV_INT)))
    cntr (.clk(clk), .enable(~pause),
    .data(2**$clog2(CLK_DIV_INT) - CLK_DIV_INT),
    .load(rco_enable), .count(count));
    initial rco_enable = 0;

    //Generate rco_enable on terminal count
    always @(count) begin
	rco_enable = (count == 2**$clog2(CLK_DIV_INT)-1) ? 1 : 0;
    end
endmodule