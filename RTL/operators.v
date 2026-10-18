module add_sub (in1,in2,cin,sel,out,cout);
    parameter WIDTH =1;
    input [WIDTH-1:0] in1,in2;
    input cin,sel;
    output reg [WIDTH-1:0] out;
    output reg cout;
    always @(*) begin
        if (sel) begin
            {cout,out}=in1-(in2+cin);
        end else begin
            {cout,out}=in1+in2+cin;
        end
    end
endmodule //add_sub
module multiplier (in1,in2,out);
    parameter WIDTH =1;
    localparam OUT_W = WIDTH * 2 ;
    input [WIDTH-1:0] in1,in2;
    output [OUT_W-1 : 0] out;
    assign out = in1 * in2 ;
endmodule //multiplier