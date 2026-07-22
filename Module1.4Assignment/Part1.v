module comb_struct_bool(input A, input B, input C, output Y);
	wire D, E, F;

	not(An, A);
	not(Bn, B, B);
	not(Cn, C, C);
	and(D, A, Bn);
	and(E, A, B, C);
	and(F, An, B, Cn);
	or(Y, D, E, F);
	
	endmodule