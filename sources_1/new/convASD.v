`timescale 1ns / 1ps

module convASD(
    input clk, reset, start,
    input weCsd, enable, enCnt, Load, reCsd, loadCnt, 
    input [3:0] address,
    input [7:0] dataIn,
    output [7:0] dataOut,
    output Zi, Zcsd,
    output done
);

    // Instantiate datapath
    datapath dp (
        .clk(clk),
        .start(start),
        .reset(reset),
        .weCsd(weCsd),
        .reCsd(reCsd),
        .dataIn(dataIn),
        .Load(Load),
        .enable(enable),
        .enCnt(enCnt),
        .loadCnt(loadCnt),
        .dataOut(dataOut),
        .Zi(Zi),
        .address(address),
        .Zcsd(Zcsd)
    );

    // Instantiate controller
    controllerASD ctrl (
        .clk(clk),
        .reset(reset),
        .start(start),
        .Zi(Zi),
        .Zcsd(Zcsd),
        .Load(Load),
        .enable(enable),
        .enCnt(enCnt),
        .loadCnt(loadCnt),
        .reCsd(reCsd),
        .done(done)
    );

endmodule
