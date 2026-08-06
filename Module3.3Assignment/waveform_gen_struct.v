module waveform_gen_struct(
    input clk,
    input enable,
    input sig_in, //input signal
    output sig_out //output signal
);

    wire S2_Q;
    wire S1_Q;
    wire S0_Q;

    reg S2_D = 1'b0;
    reg S1_D = 1'b0;
    reg S0_D = 1'b0;

    reg clr = 1'b1;

    Dff S2(.clk(clk), .D(S2_D), .enable(enable), .reset(clr), .Q(S2_Q));
    Dff S1(.clk(clk), .D(S1_D), .enable(enable), .reset(clr), .Q(S1_Q));
    Dff S0(.clk(clk), .D(S0_D), .enable(enable), .reset(clr), .Q(S0_Q));

    //Next state equation for S2 flip-flop.
    // Q2* = (~Q2 & Q1 & Q0 & sig_in) + (Q2 & ~Q1 & ~Q0 & sig_in)
    and(S2_a1, ~S2_Q, S1_Q, S0_Q, sig_in);
    and(S2_a2, S2_Q, ~S1_Q, ~S0_Q, sig_in);
    or(S2_or, S2_a1,S2_a2);
    always @(*) S2_D = S2_or;

    //Next state equation for S1 flip-flop.
    // Q1* = (~Q2 & ~Q1 & Q0) + (~Q2 & Q1 & ~Q0) + (~Q2 & Q1 & Q0 & ~sig_in)
    and(S1_a1, ~S2_Q, ~S1_Q, S0_Q);
    and(S1_a2, ~S2_Q, S1_Q, ~S0_Q);
    and(S1_a3, ~S2_Q, S1_Q, S0_Q, ~sig_in);
    or(S1_or, S1_a1, S1_a2, S1_a3);
    always @(*) S1_D = S1_or;

    //Next state equation for S0 flip-flop.
    // Q0* = (~Q2 & ~Q1 & ~Q0 & sig_in) + (~Q2 & Q1 & ~Q0 & ~sig_in) + (~Q2 & Q1 & Q0 & ~sig_in)
    and(S0_a1, ~S2_Q, ~S1_Q, ~S0_q, sig_in);
    and(S0_a2, ~S2_Q, S1_Q, ~S0_q, ~sig_in);
    and(S0_a3, ~S2_Q, S1_Q, S0_q, ~sig_in);
    or(S0_or, S0_a1, S0_a2, S0_a3);
    always @(*) S0_D = S0_or;

    // output
    buf (sig_out, S0_Q);
    

endmodule