`timescale 1ns / 1ps
module simulation;

    // Inputs
    reg clk;
    reg reset;
    reg start;
    reg weCsd;
    reg [3:0] address;
    reg [7:0] dataIn;

    // Outputs
    wire [7:0] dataOut;
    wire [3:0] dataOutK;
    wire Zi;
    wire Zcsd;
    wire Zcnt;
    wire done;
    wire Load;
    wire reCsd;
    wire enable;
    wire enCnt;
    wire loadCnt;
    wire reK;
    wire weK;

    // Instantiate the convASD module
    convASD uut (
        .clk(clk),
        .reset(reset),
        .start(start),
        .weCsd(weCsd),
        .enable(enable),
        .enCnt(enCnt),
        .Load(Load),
        .loadCnt(loadCnt),
        .address(address),
        .dataIn(dataIn),
        .dataOut(dataOut),
        .dataOutK(dataOutK),
        .Zi(Zi),
        .Zcsd(Zcsd),
        .Zcnt(Zcnt),
        .weK(weK),
        .reK(reK),
        .reCsd(reCsd),
        .done(done)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10 ns clock period
    end

    // Test procedure
    initial begin
        // Initialize Inputs
        reset = 1;
        start = 0;
        weCsd = 0;
        address = 4'b0000;
        dataIn = 8'b00000000;

        // Reset the circuit
        #10 reset = 1;
        #10 reset = 0;

        // Test cases: Ghi dữ liệu vào datapath
        dataIn = 8'h1;
        address = 4'h0;
        weCsd = 1;
        #10;
        weCsd = 0;

        dataIn = 8'h1;
        address = 4'h1;
        weCsd = 1;
        #10;
        weCsd = 0;

        dataIn = 8'h0;
        address = 4'h2;
        weCsd = 1;
        #10;
        weCsd = 0;
        
        dataIn = 8'h1;
        address = 4'h3;
        weCsd = 1;
        #10;
        weCsd = 0;

        dataIn = 8'h0;
        address = 4'h4;
        weCsd = 1;
        #10;
        weCsd = 0;

        dataIn = 8'h1;
        address = 4'h5;
        weCsd = 1;
        #10;
        weCsd = 0;

        dataIn = 8'h0;
        address = 4'h6;
        weCsd = 1;
        #10;
        weCsd = 0;
        
        dataIn = 8'h1;
        address = 4'h7;
        weCsd = 1;
        #10;
        weCsd = 0;


        // Khởi động bộ điều khiển
        start = 1;

        // Chờ tín hiệu `done` kích hoạt
        wait (done == 1);
        start = 0; 
        // Monitor the done signal and ensure FSM reaches the done state
        #200;

    end



endmodule
