module input_data #(   
    parameter WIDTH_ABD = 18,
    parameter WIDTH_C = 48,
    parameter WIDTH_OP = 8,
    parameter RSTTYPE = "SNYC", //OR "ASYNC"
    parameter A0_REG = 0,
    parameter B0_REG = 0,
    parameter C_REG = 1,
    parameter D_REG = 1,
    parameter A1_REG = 1,
    parameter B1_REG = 1,
    parameter OPMODE_REG = 1,
    parameter B_INPUT = "DIRECT" //OR "CASCADE" 
    )(
    input [WIDTH_ABD-1:0] A,B,D,BCIN,
    input [WIDTH_C-1:0] C,
    input [WIDTH_OP-1:0] OPMODE,
    input CEA,CEB,CEC,CED,CEOPMODE,clk,RSTA,RSTB,RSTC,RSTD,RSTOPMODE,
    output [WIDTH_ABD-1:0] out_d,out_b1,out_a1,
    output [WIDTH_C-1:0] out_c,
    output [WIDTH_OP -1 :0]  out_op
    );
    wire [WIDTH_ABD-1:0] in_b0,out_b0,out_a0,out_as,in_b1;
    assign in_b0 = (B_INPUT =="DIRECT") ? B : (B_INPUT =="CASCADE") ? BCIN : 'b0;
    pipline_mux #(.WIDTH(WIDTH_ABD),.RSTTYPE(RSTTYPE),.PIPLINE(D_REG)) d_reg_mux (D,out_d,CED,clk,RSTD);
    pipline_mux #(.WIDTH(WIDTH_ABD),.RSTTYPE(RSTTYPE),.PIPLINE(B0_REG)) b0_reg_mux (in_b0,out_b0,CEB,clk,RSTB);
    pipline_mux #(.WIDTH(WIDTH_ABD),.RSTTYPE(RSTTYPE),.PIPLINE(A0_REG)) a0_reg_mux (A,out_a0,CEA,clk,RSTA);
    pipline_mux #(.WIDTH(WIDTH_C),.RSTTYPE(RSTTYPE),.PIPLINE(C_REG)) c_reg_mux (C,out_c,CEC,clk,RSTC);
    pipline_mux #(.WIDTH(WIDTH_OP),.RSTTYPE(RSTTYPE),.PIPLINE(OPMODE_REG)) op_reg_mux (OPMODE,out_op,CEOPMODE,clk,RSTOPMODE);
    add_sub #(.WIDTH(WIDTH_ABD)) add_sub_1(.in1(out_d),.in2(out_b0),.cin(1'b0),.sel(out_op[6]),.out(out_as),.cout());
    assign  in_b1 = (out_op[4])?out_as:out_b0;
    pipline_mux #(.WIDTH(WIDTH_ABD),.RSTTYPE(RSTTYPE),.PIPLINE(B1_REG)) b1_reg_mux (in_b1,out_b1,CEB,clk,RSTB);
    pipline_mux #(.WIDTH(WIDTH_ABD),.RSTTYPE(RSTTYPE),.PIPLINE(A1_REG)) a1_reg_mux (out_a0,out_a1,CEA,clk,RSTA);
endmodule //input_data