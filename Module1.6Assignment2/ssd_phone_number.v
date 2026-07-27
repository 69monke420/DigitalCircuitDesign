
module ssd_phone_number (
input [2:0] selector_in, //3-bit input to select the digit to display
output [3:0] phone_digit, 
output [6:0] ssd_out);

	wire [(4*8) - 1:0] mux_in = 8'h408F1290;
	
	always(*)
		begin
			phone_digit = wire[selector_in * 4 +: 4];
			ssd_driver (.enable(1), .binary_in(phone_digit), .ssd_out(ssd_out));
		end
endmodule