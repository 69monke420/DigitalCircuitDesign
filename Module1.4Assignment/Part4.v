`timescale 1ns/1ns

module comb_bool_tb(struct_out_bool, struct_out_bool_nand, struct_cont_bool);
	output wire struct_out_bool;
	output wire struct_out_bool_nand;
	output wire struct_cont_bool;

	reg clk;
	reg[2:0] cnt;

	initial begin
		clk = 1;
		cnt = -1;
	end
	always #5 clk = ~clk;
	always @(posedge clk) cnt = cnt + 1;
	
	comb_struct_bool S_UUT(.A(cnt[2]), .B(cnt[1]), .C(cnt[0]), .Y(struct_out_bool));
	comb_struct_bool_nand S_UUTN(.A(cnt[2]), .B(cnt[1]), .C(cnt[0]), .Y(struct_out_bool_nand));
	comb_cont_bool C_UUT (.A(cnt[2]), .B(cnt[1]), .C(cnt[0]), .Y(struct_cont_bool));

	endmodule