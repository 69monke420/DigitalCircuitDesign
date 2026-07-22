module comb_cont_bool(input A, input B, input C, output Y);
	wire D, E, F;

	assign D = A & !B;
	assign E = A & C;
	assign F = !A & B & !C;
	assign Y = D | E | F;

	endmodule

