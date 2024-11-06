`timescale 1ns / 1ps
module simulation;

    // Inputs
    reg clk;
    reg reset;
    reg start;
    reg weCsd;
    reg [3:0] address;
    reg [7:0] dataIn;
    reg Zk;
    reg ZCsdK;

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
    wire [3:0] sel_i;
    wire kSel;
    wire selSaveK;

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
        .done(done),
        .sel_i(sel_i),       // Thêm kết nối sel_i
        .kSel(kSel),         // Thêm kết nối kSel
        .selSaveK(selSaveK), // Thêm kết nối selSaveK
        .Zk(Zk),             // Thêm kết nối Zk
        .ZCsdK(ZCsdK)        // Thêm kết nối ZCsdK
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

        dataIn = 8'h0;
        address = 4'h1;
        weCsd = 1;
        #10;
        weCsd = 0;

        dataIn = 8'h0;
        address = 4'h2;
        weCsd = 1;
        #10;
        weCsd = 0;
        
        dataIn = 8'h0;
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
        
        dataIn = 8'h0;
        address = 4'h7;
        weCsd = 1;
        #10;
        weCsd = 0;

        dataIn = 8'h0;
        address = 4'h8;
        weCsd = 1;
        #10;
        weCsd = 0;

        dataIn = 8'h1;
        address = 4'h9;
        weCsd = 1;
        #10;
        weCsd = 0;

        dataIn = 8'h0;
        address = 4'hA;
        weCsd = 1;
        #10;
        weCsd = 0;
        
        dataIn = 8'h0;
        address = 4'hB;
        weCsd = 1;
        #10;
        weCsd = 0;

        dataIn = 8'h0;
        address = 4'hC;
        weCsd = 1;
        #10;
        weCsd = 0;

        dataIn = 8'h0;
        address = 4'hD;
        weCsd = 1;
        #10;
        weCsd = 0;

        dataIn = 8'h0;
        address = 4'hE;
        weCsd = 1;
        #10;
        weCsd = 0;
        
        dataIn = 8'h1;
        address = 4'hF;
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
