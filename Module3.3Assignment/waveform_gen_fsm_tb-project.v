`timescale 1ns / 1ns

/* waveform_gen_fsm_tb.v 
*    Waveform generator testbench.
*    Test a waveform generator
*    constructed from a state graph. 
*    
*/

//Your module design must use the assignment API definition:
module waveform_gen_fsm_tb(
    output wire waveform_out //output signal
);

    //Simulation signals
    reg clk;            //input clock
    reg en =1'b0;       //initial disable circuit
    reg sig_in = 1'b0;  //initial signal level


    //Generate the clock waveform
    //   Set 10ns period and 50% duty cycle
    initial begin
	clk = 0;
	forever
	    begin
		#5 clk = ~clk;
	    end
    end



   //Instantiate the Unit Under Test (UUT)  
   //    Set clk, enable, and sig_in to this module's simulation signals.
   //    Generate sig_out.
   waveform_gen_struct UUT (.clk(clk), .enable(en), .sig_in(sig_in), .sig_out(waveform_out));  



   //Simulate 
   initial begin
     #20
        en = 1'b1; //Enable circuit
     #32           //Signal input on
        sig_in = 1'b1;
     #30           //Signal input off
        sig_in = 1'b0; 
     #20           //Signal input on
        sig_in = 1'b1;    
     #20           //Spurious signal off
        sig_in = 1'b0;   
   end

endmodule //waveform_gen_fsm_tb
