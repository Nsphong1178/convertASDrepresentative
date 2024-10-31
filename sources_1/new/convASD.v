`timescale 1ns / 1ps

module convASD(
    input clk, reset, start,
    input weCsd, enable, enCnt, Load, reCsd, loadCnt, weK, reK,
    input [3:0] address,
    input [7:0] dataIn,
    output [3:0] dataOutK,
    output [7:0] dataOut,
    output Zi, Zcsd, Zcnt, 
    output done
);

    // Instantiate datapath
    datapath dp (
        .clk(clk),
        .reset(reset),
        .start(start),
        .weCsd(weCsd),
        .reCsd(reCsd),
        .weK(weK),
        .reK(reK),
        .dataIn(dataIn),
        .address(address),
        .Load(Load),
        .enable(enable),
        .enCnt(enCnt),
        .loadCnt(loadCnt),
        .dataOut(dataOut),
        .dataOutK(dataOutK),
        .Zi(Zi),
        .Zcsd(Zcsd),
        .Zcnt(Zcnt)
    );

    // Instantiate controller
controllerASD ctrl (
    .clk(clk),
    .reset(reset),
    .start(start),
    .Zi(Zi),
    .Zcsd(Zcsd),
    .Zcnt(Zcnt),          
    .Load(Load),
    .enable(enable),
    .enCnt(enCnt),
    .loadCnt(loadCnt),
    .reCsd(reCsd),
    .done(done),
    .reK(reK),            
    .weK(weK)
);


endmodule
