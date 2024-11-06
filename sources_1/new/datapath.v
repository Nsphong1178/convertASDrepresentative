`timescale 1ns / 1ps

module datapath(
    input clk, reset, start,
    input weCsd, reCsd, weK, reK, Zk, ZCsdK,
    input [7:0] dataIn,
    input [3:0] address,
    input Load, enable, enCnt, loadCnt,
    output [7:0] dataOut,
    output [3:0] dataOutK,
    output Zi, Zcsd, Zcnt,
    output [3:0] sel_i,
    output kSel, selSaveK
);

    wire [3:0] add, i, cnti;
 
    wire enRegk0, enRegK1, enRegK2, enRegK3;

    // wire weCsdAfter, weCsdMain;
    // assign weCsdMain = (sel_i != 4'h0) ? 1'b1 : weCsd;
    // Instantiate counter
   // wire [3:0] preDataIn;
    assign add = (start == 0) ? address : 
                (sel_i == 4'h0) ? i :
                (sel_i == 4'h1) ? outRegK0 :
                (sel_i == 4'h2) ? outRegK1 :
                (sel_i == 4'h3) ? outRegK2 :
                (sel_i == 4'h4) ? outRegK3 : 4'h0;

    counter cnt(
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .Load(Load),
        .count(i)
    );

    wire [3:0] preCounterCnt;

    counter counterCnt(
        .clk(clk),
        .reset(reset),
        .enable(enCnt),
        .Load(loadCnt),
        .count(cnti)
    );

    // Instantiate memory
    memory mem (
        .clk(clk),
        .reset(reset),
        .we(weCsd),
        .re(reCsd),
        .dataIn(dataIn),
        .dataOut(dataOut),
        .address(add)
    );
    
    wire [3:0] cntiAdd, preAddMemK;
    assign cntiAdd = cnti - 4'h01;
    
    wire [3:0] preMemK;
    assign preMemK = (selSaveK == 0) ? i : outRegK1;
    assign preAddMemK = (kSel == 0) ? cntiAdd : 4'h1;
    
    memoryK memK(
        .clk(clk),
        .reset(reset),
        .we(weK),
        .re(reK),
        .dataIn(preMemK),
        .dataOut(dataOutK),
        .address(cntiAdd)
    );

    // Gán giá trị cho Zi và Zcsd
    assign Zcnt = (cnti == 4'h04);
    assign Zi = (i <= 4'hF);
    //assign Zi = 1;
    assign Zcsd = (dataOut == 8'h01);

    wire [3:0] outRegK0, outRegK1, outRegK2, outRegK3;
    
    assign enRegK0 = (cnti == 4'h1) ?  1'b1 : 1'b0; 
    assign enRegK1 = (cnti == 4'h2) ?  1'b1 : 1'b0; 
    assign enRegK2 = (cnti == 4'h3) ?  1'b1 : 1'b0; 
    assign enRegK3 = (cnti == 4'h4) ?  1'b1 : 1'b0; 

    register regK0(
        .clk(clk),
        .reset(reset),
        .data(dataOutK),
        .enReg(enRegK0),
        .q(outRegK0)
    );

    register regK1(
        .clk(clk),
        .reset(reset),
        .data(dataOutK),
        .enReg(enRegK1),
        .q(outRegK1)
    );

    register regK2(
        .clk(clk),
        .reset(reset),
        .data(dataOutK),
        .enReg(enRegK2),
        .q(outRegK2)
    );

    register regK3(
        .clk(clk),
        .reset(reset),
        .data(dataOutK),
        .enReg(enRegK3),
        .q(outRegK3)
    );

    wire [3:0] outRegCsd0, outRegCsd1, outRegCsd2, outRegCsd3;
    wire enRegCsd0, enRegCsd1, enRegCsd2, enRegCsd3;

    assign enRegCsd0 = (sel_i == 4'h1) ? 1'b1 : 1'b0;
    assign enRegCsd1 = (sel_i == 4'h2) ? 1'b1 : 1'b0;
    assign enRegCsd2 = (sel_i == 4'h3) ? 1'b1 : 1'b0;
    assign enRegCsd3 = (sel_i == 4'h4) ? 1'b1 : 1'b0;

    register regCsd0(
        .clk(clk),
        .reset(reset),
        .data(dataOut),
        .enReg(enRegCsd0),
        .q(outRegCsd0)
    );

    register regCsd1(
        .clk(clk),
        .reset(reset),
        .data(dataOut),
        .enReg(enRegCsd1),
        .q(outRegCsd1)
    );

    register regCsd2(
        .clk(clk),
        .reset(reset),
        .data(dataOut),
        .enReg(enRegCsd2),
        .q(outRegCsd2)
    );

    register regCsd3(
        .clk(clk),
        .reset(reset),
        .data(dataOut),
        .enReg(enRegCsd3),
        .q(outRegCsd3)
    );

    assign Zk = (outRegK2 - outRegK1 == 2 && cnti == 4) ? 1 : 0;
    assign ZCsdK = (outRegCsd1 == - outRegCsd2 && outRegCsd1 == - outRegCsd3) ? 1 : 0;

endmodule
