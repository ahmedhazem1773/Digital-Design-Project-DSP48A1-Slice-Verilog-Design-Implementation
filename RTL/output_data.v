module output_data #( 
    parameter WIDTH_P = 48,
    parameter RSTTYPE = "SNYC", //OR "ASYNC"
    parameter CARRYOUT_REG = 1,
    parameter P_REG = 1 
    )(
    input [WIDTH_P-1:0] out_z,out_x,
    input sel,cin,CEP,CECARRYIN,clk,RSTP,RSTCARRYIN,
    output [WIDTH_P-1:0] P,
    output CARRYOUT,CARRYOUTF
    );
    wire [WIDTH_P-1:0] in_p;
    wire in_cyo;
    assign CARRYOUTF = CARRYOUT;
    add_sub #(.WIDTH(WIDTH_P)) add_sub_2(.in1(out_z),.in2(out_x),.cin(cin),.sel(sel),.out(in_p),.cout(in_cyo));
    pipline_mux #(.WIDTH(WIDTH_P),.RSTTYPE(RSTTYPE),.PIPLINE(P_REG)) p_reg_mux (in_p,P,CEP,clk,RSTP);
    pipline_mux #(.RSTTYPE(RSTTYPE),.PIPLINE(CARRYOUT_REG)) cyo_reg_mux (in_cyo,CARRYOUT,CECARRYIN,clk,RSTCARRYIN);
endmodule //output_data