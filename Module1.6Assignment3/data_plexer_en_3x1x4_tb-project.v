`timescale 1ns/1ns

/* data_plexer_en_3x1x4_tb.v
*    Tests a 4-bit data x 3-channel multiplexer and enable module.
*/


//Your testbench design must use the assignment API definition:
module data_plexer_en_3x1x4_tb (
output wire [3:0] data_out,
output wire [3:0] data_en);

    //Define 'data' to be 4-bit x 3 channels vector
    wire [11:0] data;            //4-bit data x 3 channels = 12

    //Simulation signals
    reg clk;
    reg [1:0] cnt;

    //3:1 mux x 4bits
    reg [3:0] dig2 = 4'h2;
    reg [3:0] dig1 = 4'h1;
    reg [3:0] dig0 = 4'h0;
    assign data = {dig2,dig1,dig0};


    //Generate a 2-bit synchronous counter called 'cnt' which counts 00-01-10 then repeats (skips 11)
    //Generate a clk to run the counter with period 10ns and 50% duty cycle
    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    initial begin
        cnt = 2'b00;
    end

    always @(posedge clk) begin
        if (cnt == 2'b10)
            cnt <= 2'b00;
        else
            cnt <= cnt + 1'b1;
    end

    //Instantiate a data_plexer_en called UUT.
    //   Set INPUT_WIDTH to the input data width defined in the assignment.
    //   Set SEL to the number of select lines needed for the number of channels defined in the assignment.
    //   Set data_in to the assigned data register (above).
    //   Set sec_ctrl to the 2-bit synchronous counter created above.
    //   Set data_out to this modules data_out output.
    //   Set data_en to this module's data_en output.
    data_plexer_en #(.INPUT_WIDTH(4), .SEL(2)) UUT (.data_in(data), .sel_ctrl(cnt), .data_out(data_out), .data_en(data_en));


    //Run the following simulation stimulus
    //Run the Modelsim simulator for at least 200ns
    initial begin
        //Test 4:1 mux, 3-bit inputs
        #85
        dig0 = 4'hA;
        dig1 = 4'hB;
        dig2 = 4'hC;
        #80
        dig0 = 4'h5;
        dig1 = 4'h6;
        dig2 = 4'h7;
       
    end
endmodule
