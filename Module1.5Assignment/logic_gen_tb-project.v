`timescale 1ns/1ns

/* logic_gen_tb.v
* Test the bitwise logic functions:
* (A and B), (A or B), (A xor B), (A xnor B)
* Map 00:and, 01:or, 10:xor, 11:xnor
*/ 

module logic_gen_tb (
    output wire [3:0] out1, 
    output wire [3:0] out2, 
    output wire [7:0] out3 
);

    // Simulation signals
    reg clk;
    reg [1:0] cnt;
    
    // Registers for input vectors to support additional combination testing
    reg [3:0] A_4bit;
    reg [3:0] B_4bit;
    reg [7:0] A_8bit;
    reg [7:0] B_8bit;

    // Clock generator: 10ns period (50% duty cycle: 5ns HIGH, 5ns LOW)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Counter generation and stimulus sequence
    initial begin
        cnt = 2'b00;
        
        // -------------------------------------------------------------
        // Test Set 1: Required combinations
        // 4-bit: A = 0110, B = 1100
        // 8-bit: A = 01101100, B = 11001110
        // -------------------------------------------------------------
        A_4bit = 4'b0110;
        B_4bit = 4'b1100;
        A_8bit = 8'b01101100;
        B_8bit = 8'b11001110;

        // Run through all 4 logic combinations (00:AND, 01:OR, 10:XOR, 11:XNOR)
        repeat (4) begin
            #10 cnt = cnt + 1'b1;
        end

        // -------------------------------------------------------------
        // Test Set 2: Additional combinations (Requirement iv)
        // 4-bit: A = 1010, B = 0101
        // 8-bit: A = 11110000, B = 10101010
        // -------------------------------------------------------------
        A_4bit = 4'b1010;
        B_4bit = 4'b0101;
        A_8bit = 8'b11110000;
        B_8bit = 8'b10101010;

        // Run through all 4 logic combinations again
        repeat (4) begin
            #10 cnt = cnt + 1'b1;
        end

        // Run simulation beyond 300ns requirement total duration
        #250 $finish;
    end

    // Structural Unit Under Test (4-bit)
    logic_gen_structural UUT1 (
        .A(A_4bit),
        .B(B_4bit),
        .logic_func(cnt),
        .logic_out(out1)
    );

    // Behavioral Unit Under Test (4-bit)
    logic_gen_behavioral #( .n(4) ) UUT2 (
        .A(A_4bit),
        .B(B_4bit),
        .logic_func(cnt),
        .logic_out(out2)
    );

    // Behavioral Unit Under Test (8-bit)
    logic_gen_behavioral #( .n(8) ) UUT3 (
        .A(A_8bit),
        .B(B_8bit),
        .logic_func(cnt),
        .logic_out(out3)
    );

endmodule // logic_gen_tb