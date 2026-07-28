module JKff(
input clk,
input J, K,
input enable,
input reset,
output reg Q);

	initial begin
		Q = 1'b0;
	end

	always @(posedge clk or negedge reset)
		begin
			if(reset == 1'b0)
				Q <= 1'b0;
			else if (enable == 1'b1) begin
				if(J == 1'b0) begin
					if(K == 1'b0)
						Q <= Q;
					else
						Q <= 1'b0;
				end
				else begin
					if(K == 1'b0)
						Q <= 1'b1;
					else
						Q <= ~Q;
				end
			end
		end
endmodule
