`timescale 1ns / 1ps

module datapath(
    input clk, reset, start,
    input weCsd, reCsd,
    input [7:0] dataIn,
    input [3:0] address,
    input Load, enable, enCnt, loadCnt,
    output [7:0] dataOut,
    output Zi, Zcsd
);

    wire [3:0] add, i, cnt;
    assign add = (start == 0) ? address : i;
    // Instantiate counter
    counter cnt (
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
        .count(cnt)
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

    // memory k(
    //     .clk(clk),
    //     .reset(reset),
    //     .we(),
    //     .re(),
    //     .dataIn(),
    //     .dataOut(),
    //     .address()

    // );

    // Gán giá trị cho Zi và Zcsd
    assign Zi = (i < 4'hF);
    //assign Zi = 1;
    assign Zcsd = (dataOut == 8'h01);

endmodule
