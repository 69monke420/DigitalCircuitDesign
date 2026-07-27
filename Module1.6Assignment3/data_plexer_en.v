/* data_plexer_en.v
*     Generic multiplexer consolidates 2^SEL
*     data signals each of width INPUT_WIDTH 
*     to output of width INPUT_WIDTH.
*     Control line demultiplexer distributes 
*     logic '1' enable signal to 2^SEL outputs.
*/

module data_plexer_en #(parameter INPUT_WIDTH=4, 
                        parameter SEL=1) (

    input wire [(INPUT_WIDTH * (2**SEL) )-1:0] data_in,
    input wire [SEL-1:0] sel_ctrl,
    output reg [INPUT_WIDTH-1:0] data_out,
    output reg [(2**SEL)-1:0] data_en
    );

    wire [(2**SEL)-1:0] demux_mask = 1;

    //always @ (*)
    always @ (sel_ctrl or data_in)
       begin
           //part select:  
           //    [start index (var*width), 
           //      +: (increase from start index), width of slice]
           data_out = data_in[sel_ctrl*INPUT_WIDTH +: INPUT_WIDTH];
           data_en = demux_mask << sel_ctrl;
       end
    
endmodule
