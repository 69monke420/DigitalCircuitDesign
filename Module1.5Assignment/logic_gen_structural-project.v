/* logic_gen_structural.v
*     Verify the bitwise logic functions:
*     (A and B), (A or B), (A xor B), (A xnor B)
*     Map 00:and, 01:or, 10:xor, 11:xnor
*     Use structural Verilog and
*     constrain the inputs and outputs to 4 bits.
*/    
    
//Your module design must use the assignment API definition:
module logic_gen_structural (input [3:0] A, input [3:0] B, input [1:0] logic_func, output reg [3:0] logic_out);


    //Define 4-bit wire outputs for each of the logic functions called:
    wire [3:0] logic_out_and; 
    wire [3:0] logic_out_or; 
    wire [3:0] logic_out_xor; 
    wire [3:0] logic_out_xnor;
    
    //Hint: define as wires
    wire [3:0] sel0, sel1, sel2, sel3;
    wire [3:0] mux_out;

    wire s1_n, s0_n;

    not g_not1 (s1_n, logic_func[1]);
    not g_not0 (s0_n, logic_func[0]);

    //Create bitwise AND using primitives (you must use primitive components).
    //Call the output: 'logic_out_and".
    //Hint: implement the AND function for each bit then concatonate 
    //      and assign to the signal 'logic_out_and'
    and(logic_out_and[0], A[0], B[0]);
    and(logic_out_and[1], A[1], B[1]);
    and(logic_out_and[2], A[2], B[2]);
    and(logic_out_and[3], A[3], B[3]);
    
    //Create bitwise OR using primitives (you must use primitive components).
    //Call the output: 'logic_out_or".
    //Hint: implement the OR function for each bit then concatonate 
    //      and assign to the signal 'logic_out_or'
    or(logic_out_or[0], A[0], B[0]);
    or(logic_out_or[1], A[1], B[1]);
    or(logic_out_or[2], A[2], B[2]);
    or(logic_out_or[3], A[3], B[3]);

    //Create bitwise XOR using primitives (you must use primitive components).
    //Call the output: 'logic_out_xor".
    //Hint: implement the XOR function for each bit then concatonate 
    //      and assign to the signal 'logic_out_xor'
    xor(logic_out_xor[0], A[0], B[0]);
    xor(logic_out_xor[1], A[1], B[1]);
    xor(logic_out_xor[2], A[2], B[2]);
    xor(logic_out_xor[3], A[3], B[3]);
  
    //Create bitwise XNOR using primitives (you must use primitive components).
    //Call the output: 'logic_out_xnor".
    //Hint: implement the XNOR function for each bit then concatonate 
    //      and assign to the signal 'logic_out_xnor'
    xnor(logic_out_xnor[0], A[0], B[0]);
    xnor(logic_out_xnor[1], A[1], B[1]);
    xnor(logic_out_xnor[2], A[2], B[2]);
    xnor(logic_out_xnor[3], A[3], B[3]);

    //Create the logic_out signal based on the logic_function
    // Verify (A and B), (A or B), (A xor B), (A xnor B)
    // 00: AND, 01: OR, 10: XOR, 11: XNOR
    and(sel0[0], logic_out_and[0], s1_n, s0_n);
    and(sel1[0], logic_out_or[0], s1_n, logic_func[0]);
    and(sel2[0], logic_out_xor[0], logic_func[1], s0_n);
    and(sel3[0], logic_out_xnor[0], logic_func[1], logic_func[0]);
    or(mux_out[0], sel0[0], sel1[0], sel2[0], sel3[0]);

    and(sel0[1], logic_out_and[1], s1_n, s0_n);
    and(sel1[1], logic_out_or[1], s1_n, logic_func[0]);
    and(sel2[1], logic_out_xor[1], logic_func[1], s0_n);
    and(sel3[1], logic_out_xnor[1], logic_func[1], logic_func[0]);
    or(mux_out[1], sel0[1], sel1[1], sel2[1], sel3[1]);

    and(sel0[2], logic_out_and[2], s1_n, s0_n);
    and(sel1[2], logic_out_or[2], s1_n, logic_func[0]);
    and(sel2[2], logic_out_xor[2], logic_func[1], s0_n);
    and(sel3[2], logic_out_xnor[2], logic_func[1], logic_func[0]);
    or(mux_out[2], sel0[2], sel1[2], sel2[2], sel3[2]);

    and(sel0[3], logic_out_and[3], s1_n, s0_n);
    and(sel1[3], logic_out_or[3], s1_n, logic_func[0]);
    and(sel2[3], logic_out_xor[3], logic_func[1], s0_n);
    and(sel3[3], logic_out_xnor[3], logic_func[1], logic_func[0]);
    or(mux_out[3], sel0[3], sel1[3], sel2[3], sel3[3]);

    always @(A, B, logic_func) begin
        //Evaluate logic_func using conditional statements
        //   logic_func: 00 --> logic_out = logic_out_and
        //   logic_func: 01 --> logic_out = logic_out_or
        //   logic_func: 10 --> logic_out = logic_out_xor
        //   logic_func: 11 --> logic_out = logic_out_xnor
	logic_out = mux_out;
    end

endmodule //logic_gen structural
