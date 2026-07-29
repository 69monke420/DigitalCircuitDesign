/* counter_nbit_updown-project.v
*      Yashas Prasad
*      7/28/2026
*      197311: Digital Circuit Design with HDL for High Schoolers
*/

`define N_BITS_3 3
`define N_BITS_4 4


//Part 2:  Your testbench design must use the assignment API definition:
module counter_nbit_updown_tb(
    output wire[`N_BITS_3-1:0] count_3bit,
    output wire[`N_BITS_4-1:0] count_4bit
);

    //Simulation signals
    reg clk;
    reg en = 1'b0;
    reg ld = 1'b0;
    reg [`N_BITS_3-1:0] dat_3;
    reg [`N_BITS_4-1:0] dat_4;
    reg up_down = 1'b1;
    
    //Generate the clock waveform
    //   Set 10ns period and 50% duty cycle
    initial begin
	clk = 0;
	forever
	    begin
		#5 clk = ~clk;
	    end
    end


    //Instantiate 2 counter_nbit_updown modules, UUT1 and UUT2.
    //   Set WIDTH to defined constant N_BITS_3 (UUT1) and N_BITS_4 (UUT2).
    //   Set clk, enable, data, load, up_down to this module's simulation signals.
    //   Generate count_3bit (UUT1) and count_4bit (UUT2).
    counter_nbit_updown #(.WIDTH(`N_BITS_3)) UUT1 (.clk(clk), .enable(en), .data(dat_3), .load(ld), .up_down(up_down), .count(count_3bit));
    counter_nbit_updown #(.WIDTH(`N_BITS_4)) UUT2 (.clk(clk), .enable(en), .data(dat_4), .load(ld), .up_down(up_down), .count(count_4bit));


   //Simulate 
   initial begin

     //data load value
     dat_3 = 3'b001;
     dat_4 = 4'b1010;

     #20            //Enable up count
        en = 1'b1;
     #30            //Load count 
        ld = 1'b1;
     #20
        ld = 1'b0; 
     #20            //Enable count
        en = 1'b1;
     #30            //Disable count
        en = 1'b0;
     #20            //Enable count
        en = 1'b1; 
     #40            //Load count 
        ld = 1'b1;
     #30
        ld = 1'b0;   
     #20           //Enable down count
        up_down = 1'b0;            
   end
endmodule //counter_nbit_updown_tb