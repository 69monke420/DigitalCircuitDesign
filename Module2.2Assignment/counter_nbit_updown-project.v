/* counter_nbit_updown-project.v
*      Yashas Prasad
*      7/28/2026
*      197311: Digital Circuit Design with HDL for High Schoolers
*/

//Part 1:  Implement the design with behavioral Verilog.  
//         Your module design must use the assignment API definition:
module counter_nbit_updown #(parameter WIDTH = 4)(
    input clk,
    input enable, //allow counter to count when enabled
    input [WIDTH-1:0] data, //data to be loaded when load is active
    input load, //synchronous data load control signal
    input up_down, //async count direction: up (1), down (0), default up
    output reg[WIDTH-1:0] count //output count value
);


    //Initialize this modules output "count" to 0
    initial count = 0;

    //Use an always block to increment or decrement "count" output.
    //on the positive edge of this module's "clk" input.
    //Load the counter with this module's "data" input if load is active.
    //Update the count with a non-blocking statement.

    always @(posedge clk) begin
	if(load)
	    count <= data;
	else if (enable) begin
	    if (up_down)
		count <= count + 1'b1;
	    else
		count <= count - 1'b1;
	end
    end

endmodule //counter_nbit_updown
