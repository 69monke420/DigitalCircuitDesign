/* logic_gen_behavioral.v
*     Verify the bitwise logic functions:
*     (A and B), (A or B), (A xor B), (A xnor B)
*     Map 00:and, 01:or, 10:xor, 11:xnor
*     Use behavioral Verilog and
*     with parameterized input bit widths
*     defaulted to 8-bits.
*/    


//Your module design must use the assignment API definition:
module logic_gen_behavioral #(parameter n=8) (input [n-1:0] A, input [n-1:0] B, input [1:0] logic_func, output reg [n-1:0] logic_out);

    //Create the logic_out signal based on the logic_function
    // Verify (A and B), (A or B), (A xor B), (A xnor B)
    // 00: AND, 01: OR, 10: XOR, 11: XNOR
    

    always @(A, B, logic_func) begin
        //Generate the output logic_out signal.
        //Evaluate logic_func using conditional statements.
        //Use procedural statements to implement logic function.
	logic_out = ((A & B)  & {n{~logic_func[1] & ~logic_func[0]}}) |
                    ((A | B)  & {n{~logic_func[1] &  logic_func[0]}}) |
                    ((A ^ B)  & {n{ logic_func[1] & ~logic_func[0]}}) |
                    ((A ~^ B) & {n{ logic_func[1] &  logic_func[0]}});    
    end


endmodule //logic_gen behavioral
