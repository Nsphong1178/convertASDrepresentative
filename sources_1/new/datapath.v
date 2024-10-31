`timescale 1ns / 1ps

module datapath(
    input clk, reset, start,
    input weCsd, reCsd, weK, reK, 
    input [7:0] dataIn,
    input [3:0] address,
    input Load, enable, enCnt, loadCnt,
    output [7:0] dataOut,
    output [3:0] dataOutK,
    output Zi, Zcsd, Zcnt
);

    wire [3:0] add, i, cnti;
    assign add = (start == 0) ? address : i;
    // Instantiate counter
    counter cnt(
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .Load(Load),
        .count(i)
    );

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

    memoryK memK(
        .clk(clk),
        .reset(reset),
        .we(weK),
        .re(reK),
        .dataIn(i),
        .dataOut(dataOutK),
        .address(cnti)
    );

    // Gán giá trị cho Zi và Zcsd
    assign Zcnt = (cnti == 4'h04);
    assign Zi = (i < 4'hF);
    //assign Zi = 1;
    assign Zcsd = (dataOut == 8'h01);

endmodule
