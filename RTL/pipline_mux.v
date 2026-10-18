module pipline_mux (in1,out,e,clk,rst );
    parameter WIDTH =1;
    parameter RSTTYPE = "SNYC"; //OR "ASYNC"
    parameter PIPLINE = 1;
    input clk,rst,e;
    input [WIDTH-1:0] in1;
    output [WIDTH-1:0] out;
    wire [WIDTH-1:0] in1_pip_mux;
    register #(.WIDTH(WIDTH),.RSTTYPE(RSTTYPE)) reg_pip (in1,in1_pip_mux,e,clk,rst);
    assign out = (PIPLINE==1) ? in1_pip_mux : in1;
endmodule //pipline_mux