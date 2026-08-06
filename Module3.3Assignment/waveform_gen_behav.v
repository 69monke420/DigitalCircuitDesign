module waveform_gen_behav(
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

    DFF S2(.clk(clk), .D(S2_D), .enable(enable), .reset(clr), .Q(S2_Q));
    DFF S1(.clk(clk), .D(S1_D), .enable(enable), .reset(clr), .Q(S1_Q));
    DFF S0(.clk(clk), .D(S0_D), .enable(enable), .reset(clr), .Q(S0_Q));

    always @(sig_in or S1_Q or S0_Q)
	begin
	     S2_D = (~S2_Q & S1_Q & S0_Q & sig_in) | (S2_Q & ~S1_Q & ~S0_Q & sig_in);
	     S1_D = (~S2_Q & ~S1_Q & S0_Q) | (~S2_Q & S1_Q & ~S0_Q) | (~S2_Q & S1_Q & S0_Q & ~sig_in);
	     S0_D = (~S0_Q & ~S1_Q & ~S0_Q & sig_in) | (~S0_Q & S1_Q & ~S0_Q & ~sig_in) | (~S2_Q & S1_Q & S0_Q & ~sig_in);
	end

    assign sig_out = S0_Q;

endmodule