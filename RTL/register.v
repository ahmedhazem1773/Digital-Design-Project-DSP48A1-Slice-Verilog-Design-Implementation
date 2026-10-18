module register (in,out,e,clk,rst );
    parameter WIDTH =1;
    parameter RSTTYPE = "SNYC"; //OR "ASYNC"
    input clk,rst,e;
    input [WIDTH-1:0] in ;
    output reg [WIDTH-1:0] out;
    generate
        if (RSTTYPE == "SNYC") begin
            always @(posedge clk) begin
                if (rst) begin
                    out <= 'b0;
                end else if(e) begin
                    out <= in;
                end
            end
        end else begin
            always @(posedge clk or posedge rst) begin
                if (rst) begin
                    out <= 'b0;
                end else if(e) begin
                    out <= in;
                end
            end
        end
    endgenerate
endmodule //register