module ssd_driver (input enable, input [3:0] binary_in, output reg [6:0] ssd_out);
	wire [(16*7) - 1:0] mux_in = 112'b1111110011000011011011111001011001110110111011111111000011111111111011111011100111110001101011110110011110000001; 


	always @ (*)
		begin
			ssd_out = {7{enable}} & mux_in[binary_in * 7 +: 7];
		end
endmodule