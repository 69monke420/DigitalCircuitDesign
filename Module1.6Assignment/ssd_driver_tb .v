`timescale 1ns/1ns

module ssd_driver_tb (output wire[6:0] ssd_out);
    reg enable;
    reg [3:0] binary_in;

    ssd_driver uut (.enable(enable), .binary_in(binary_in), .ssd_out(ssd_out));

    integer en, i;

    initial begin
        for (en = 0; en < 2; en = en + 1) begin
            enable = en;
            
            for (i = 0; i < 16; i = i + 1) begin
                binary_in = i;
                #10;
            end
        end
    end

endmodule