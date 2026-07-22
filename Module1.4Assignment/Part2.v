module comb_struct_bool_nand(input A, input B, input C, output Y);
	wire D, E, F;

	nand(An, A, A);
	nand(Bn, B, B);
	nand(Cn, C, C);
	nand(D, A, Bn);
	nand(E, A, C);
	nand(F, An, B, Cn);
	nand(Y, D, E, F);
	
	endmodule
