/* Dff.v
*    Simple D flip-flop with the following features:
*      positive edge triggered,
*      write enabled (active high),
*      asynchronous reset (active low).
*/


module Dff(
   input clk,
   input D,
   input enable,
   input reset,
   output reg Q
   );

   //Initialize Q to 0
   initial begin 
      Q = 1'b0;
   end

   //Activate on clk rising edge or reset negative edge
   //Update Q if enabled and not reset.

   always @(posedge clk or negedge reset) 
      begin
         if(reset==1'b0)
            Q <= 1'b0;
         else if (enable==1'b1)
            Q <= D;
      end

   //Alternative approach - NOT PREFERRED
   //Update Q if enabled and not reset.
   //Note
   //This is not preferred since will result in being detected as a changed and execute when reset transitions from low-high 
   //which will result in the else statement being executed and raising the output.  
   //Typical implementation of D-FF's is to wait for the next positive clock each to update Q which is accomplished with the first method.
/*
   always @(posedge clk or reset==1'b0) 
      begin
         if(reset==1'b0)
            Q <= 1'b0;
         else if (enable==1'b1)
            Q <= D;
      end
*/
endmodule //Dff

