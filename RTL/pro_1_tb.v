module pro_1_tb #(
    parameter WIDTH_ABD = 18,
    parameter WIDTH_C = 48,
    parameter WIDTH_OP = 8,
    parameter WIDTH_P = 48,
    parameter WIDTH_M = 36
)();
    reg [WIDTH_ABD-1:0] A,B,D,BCIN;
    reg [WIDTH_C-1:0] C,PCIN;
    reg [WIDTH_OP-1:0] OPMODE;
    reg CARRYIN;
    reg CEA,CEB,CEC,CED,CEOPMODE,CEP,CECARRYIN,CEM,clk,
    RSTA,RSTB,RSTC,RSTD,RSTOPMODE,RSTP,RSTCARRYIN,RSTM;
    wire [WIDTH_ABD-1:0] BCOUT;
    wire [WIDTH_M-1:0] M;
    wire [WIDTH_P-1:0] P,PCOUT;
    wire CARRYOUT,CARRYOUTF;
    pro_1 dut(
        A,B,D,BCIN,
        C,PCIN,
        OPMODE,CARRYIN,
        CEA,CEB,CEC,CED,CEOPMODE,CEP,CECARRYIN,CEM,clk,
        RSTA,RSTB,RSTC,RSTD,RSTOPMODE,RSTP,RSTCARRYIN,RSTM,
        BCOUT,M,P,PCOUT,
        CARRYOUT,CARRYOUTF
    );
    initial begin
        clk = 0 ;
        forever begin
            #1 clk = ~clk;
        end
    end
    initial begin
        //2.1
        RSTA=1;
        RSTB=1;
        RSTC=1;
        RSTD=1;
        RSTOPMODE=1;
        RSTP=1;
        RSTCARRYIN=1;
        RSTM=1;
        repeat(7) begin
            A=$random;
            B=$random;
            D=$random;
            BCIN=$random;
            C=$random;
            PCIN=$random;
            OPMODE=$random;
            CARRYIN=$random;
            CEA=$random;
            CEB=$random;
            CEC=$random;
            CED=$random;
            CEOPMODE=$random;
            CEP=$random;
            CECARRYIN=$random;
            CEM=$random;
            @(negedge clk);
            if (BCOUT != 'b0) begin
                $display(" the  BCOUT expected is %b but the output is %b " , 'b0,BCOUT);
            end
            if (M != 'b0) begin
                $display(" the  M expected is %b but the output is %b " , 'b0,M);
            end
            if (P != 'b0) begin
                $display(" the  P expected is %b but the output is %b " , 'b0,P);
            end
            if (PCOUT != 'b0) begin
                $display(" the  PCOUT expected is %b but the output is %b " , 'b0,PCOUT);
            end
            if (CARRYOUT != 'b0) begin
                $display(" the  CARRYOUT expected is %b but the output is %b " , 'b0,CARRYOUT);
            end
            if (CARRYOUTF != 'b0) begin
                $display(" the  CARRYOUTF expected is %b but the output is %b " , 'b0,CARRYOUTF);
            end
        end
        RSTA=0;
        RSTB=0;
        RSTC=0;
        RSTD=0;
        RSTOPMODE=0;
        RSTP=0;
        RSTCARRYIN=0;
        RSTM=0;
        CEA=1;
        CEB=1;
        CEC=1;
        CED=1;
        CEOPMODE=1;
        CEP=1;
        CECARRYIN=1;
        CEM=1;
        //2.2
        OPMODE=8'b11011101;
        A = 20;
        B = 10;
        C = 350;
        D = 25;
        repeat(7) begin
            BCIN=$random;
            PCIN=$random;
            CARRYIN=$random;
            @(negedge clk);
            @(negedge clk);
            @(negedge clk);
            @(negedge clk);
            if (BCOUT != 'hf) begin
                $display(" the  BCOUT expected is %h but the output is %h " , 'hf,BCOUT);
            end
            if (M != 'h12c) begin
                $display(" the  M expected is %h but the output is %h " , 'h12c,M);
            end
            if (P != 'h32) begin
                $display(" the  P expected is %h but the output is %h " , 'h32,P);
            end
            if (PCOUT != P) begin
                $display(" the  PCOUT & P expected is %h but the PCOUT & P is %h  , %h ",'h32 , PCOUT,P);
            end
            if (CARRYOUT != 'b0) begin
                $display(" the  CARRYOUT expected is %b but the output is %b " , 'b0,CARRYOUT);
            end
            if (CARRYOUTF != CARRYOUT) begin
                $display(" the  CARRYOUTF & CARRYOUT expected is %b but the CARRYOUTF & CARRYOUT is %b  , %b ",'b0 , CARRYOUTF,CARRYOUT);
            end
        end
        //2.3
        OPMODE=8'b00010000;
        repeat(7) begin
            BCIN=$random;
            PCIN=$random;
            CARRYIN=$random;
            @(negedge clk);
            @(negedge clk);
            @(negedge clk);
            if (BCOUT != 'h23) begin
                $display(" the  BCOUT expected is %h but the output is %h " , 'h23,BCOUT);
            end
            if (M != 'h2bc) begin
                $display(" the  M expected is %h but the output is %h " , 'h2bc,M);
            end
            if (P != 'b0) begin
                $display(" the  P expected is %b but the output is %b " , 'b0,P);
            end
            if (PCOUT != P) begin
                $display(" the  PCOUT & P expected is %b but the PCOUT & P is %b  , %b ",'b0, PCOUT,P);
            end
            if (CARRYOUT != 'b0) begin
                $display(" the  CARRYOUT expected is %b but the output is %b " , 'b0,CARRYOUT);
            end
            if (CARRYOUTF != CARRYOUT) begin
                $display(" the  CARRYOUTF & CARRYOUT expected is %b but the CARRYOUTF & CARRYOUT is %b  , %b ",'b0 , CARRYOUTF,CARRYOUT);
            end
        end
        //2.4
        OPMODE=8'b00001010;
        repeat(7) begin
            BCIN=$random;
            PCIN=$random;
            CARRYIN=$random;
            @(negedge clk);
            @(negedge clk);
            @(negedge clk);
            if (BCOUT != 'ha) begin
                $display(" the  BCOUT expected is %h but the output is %h " , 'ha,BCOUT);
            end
            if (M != 'hc8) begin
                $display(" the  M expected is %h but the output is %h " , 'hc8,M);
            end
            if (PCOUT != P) begin
                $display(" the  PCOUT & P expected is %h but the PCOUT & P is %h  , %h ",P, PCOUT,P);
            end
            if (CARRYOUTF != CARRYOUT) begin
                $display(" the  CARRYOUTF & CARRYOUT expected is %h but the CARRYOUTF & CARRYOUT is %h  , %h ",CARRYOUT, CARRYOUTF,CARRYOUT);
            end
        end
        //2.5
        OPMODE=8'b10100111;
        A = 5;
        B = 6;
        C = 350;
        D = 25 ;
        PCIN = 3000;
        repeat(7) begin
            BCIN=$random;
            CARRYIN=$random;
            @(negedge clk);
            @(negedge clk);
            @(negedge clk);
            if (BCOUT != 'h6) begin
                $display(" the  BCOUT expected is %h but the output is %h " , 'h6,BCOUT);
            end
            if (M != 'h1e) begin
                $display(" the  M expected is %h but the output is %h " , 'h1e,M);
            end
            if (P != 'hfe6fffec0bb1) begin
                $display(" the  P expected is %h but the output is %h " , 'hfe6fffec0bb1,P);
            end
            if (PCOUT != P) begin
                $display(" the  PCOUT & P expected is %h but the PCOUT & P is %h  , %h ",'hfe6fffec0bb1, PCOUT,P);
            end
            if (CARRYOUT != 1) begin
                $display(" the  CARRYOUT expected is %b but the output is %b " , 1,CARRYOUT);
            end
            if (CARRYOUTF != CARRYOUT) begin
                $display(" the  CARRYOUTF & CARRYOUT expected is %b but the CARRYOUTF & CARRYOUT is %b  , %b ",1 , CARRYOUTF,CARRYOUT);
            end
        end
        $stop;
    end
endmodule //pro_1_tb