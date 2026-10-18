module pro_1 #(
    parameter WIDTH_ABD = 18,
    parameter WIDTH_C = 48,
    parameter WIDTH_OP = 8,
    parameter WIDTH_P = 48,
    parameter WIDTH_M = 36,
    parameter RSTTYPE = "SNYC", //OR "ASYNC"
    parameter A0_REG = 0,
    parameter B0_REG = 0,
    parameter C_REG = 1,
    parameter D_REG = 1,
    parameter A1_REG = 1,
    parameter B1_REG = 1,
    parameter OPMODE_REG = 1,
    parameter M_REG = 1,
    parameter CARRYIN_REG = 1,
    parameter CARRYOUT_REG = 1,
    parameter P_REG = 1 ,
    parameter B_INPUT = "DIRECT" ,//OR "CASCADE" 
    parameter CARRYINSEL= "OPMODE5" //OR "CARRYIN"
    )(
    input [WIDTH_ABD-1:0] A,B,D,BCIN,
    input [WIDTH_C-1:0] C,PCIN,
    input [WIDTH_OP-1:0] OPMODE,
    input CARRYIN,
    input CEA,CEB,CEC,CED,CEOPMODE,CEP,CECARRYIN,CEM,clk,
    RSTA,RSTB,RSTC,RSTD,RSTOPMODE,RSTP,RSTCARRYIN,RSTM,
    output [WIDTH_ABD-1:0] BCOUT,
    output [WIDTH_M-1:0] M,
    output [WIDTH_P-1:0] P,PCOUT,
    output CARRYOUT,CARRYOUTF
    );
    wire [WIDTH_ABD-1:0]out_d,out_a1;
    wire [WIDTH_C-1:0] out_c;
    wire [WIDTH_M-1:0] in_m,out_m;
    wire [WIDTH_OP-1:0] out_op;
    reg [WIDTH_P-1:0] out_z,out_x;
    wire in_cyi , out_cyi;
    input_data #(
        .WIDTH_ABD(WIDTH_ABD),
        .WIDTH_C(WIDTH_C),
        .WIDTH_OP(WIDTH_OP),
        .RSTTYPE(RSTTYPE),
        .A0_REG(A0_REG),
        .B0_REG(B0_REG),
        .C_REG(C_REG),
        .D_REG(D_REG),
        .A1_REG(A1_REG),
        .B1_REG(B1_REG),
        .OPMODE_REG(OPMODE_REG),
        .B_INPUT(B_INPUT)
        ) p_1 (
        A,B,D,BCIN,C,OPMODE,
        CEA,CEB,CEC,CED,CEOPMODE,clk,RSTA,RSTB,RSTC,RSTD,RSTOPMODE,
        out_d,BCOUT,out_a1,out_c,out_op
        );
    multiplier #(.WIDTH(WIDTH_ABD)) multi1 (BCOUT,out_a1,in_m);
    assign in_cyi = (CARRYINSEL == "OPMODE5")? out_op[5]:(CARRYINSEL == "CARRYIN")? CARRYIN :'b0;
    pipline_mux #(.RSTTYPE(RSTTYPE),.PIPLINE(CARRYIN_REG)) cyi_reg_mux (in_cyi,out_cyi,CECARRYIN,clk,RSTCARRYIN);
    pipline_mux #(.WIDTH(WIDTH_M),.RSTTYPE(RSTTYPE),.PIPLINE(M_REG)) m_reg_mux (in_m,out_m,CEM,clk,RSTM);
    //x
    always @(*) begin
        case (out_op[1:0])
            2'b00: out_x= 'b0;
            2'b01: out_x={12'b0,out_m};
            2'b10: out_x=P;
            2'b11: out_x= {out_d[11:0],out_a1[17:0],BCOUT[17:0]};
        endcase
    end
    //z
    always @( *) begin
        case (out_op[3:2])
            2'b00: out_z= 'b0;
            2'b01: out_z=PCIN;
            2'b10: out_z=P;
            2'b11: out_z=out_c;
        endcase
    end
    output_data #( 
    .WIDTH_P (WIDTH_P),
    .RSTTYPE (RSTTYPE),
    .CARRYOUT_REG(CARRYOUT_REG),
    .P_REG(P_REG)
    )p_2(
    out_z,out_x,
    out_op[7],out_cyi,CEP,CECARRYIN,clk,RSTP,RSTCARRYIN,
    P,CARRYOUT,CARRYOUTF
    );
    assign M =out_m;
    assign PCOUT = P;
endmodule //pro_1