`timescale 1ns / 1ps

module controllerASD(
    input clk, reset, start,
    input Zi, Zcsd, Zcnt,
    output reg Load, enable, reCsd, done, enCnt, loadCnt, reK, weK
);

    reg [3:0] state;

    // State Machine
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 4'h0;
        end else begin
            case (state)
                4'h0: state <= 4'h1; 
                4'h1: begin
                    if (start)
                        state <= 4'h2;
                    else 
                        state <= 4'h0;
                end
            //    4'h1: state <= 4'h2;
                4'h2: state <= 4'h3;
                4'h3: begin
                    if (Zi)
                        state <= 4'h4;
                    else 
                        state <= 4'hB; // done
                end
            //    4'h3: state <= 4'h4;
                4'h4: state <= 4'h5;
                4'h5: begin
                    if (Zcsd)
                        state <= 4'h6;
                    else 
                        state <= 4'h9; // en counter i
                end 
                4'h6: state <= 4'h7;           
                4'h7: state <= 4'h8;
                4'h8: state <= 4'h9;
                4'h9: begin
                    if (Zcnt == 0)
                        state <= 4'hA;
                    else
                        state <= 4'hB; 
                end   
                4'hA: state <= 4'h3; 
                default: state <= 4'h0;
            endcase
        end
    end

    // Control Outputs
    always @(*) begin
        Load = (state == 4'h2) ? 1'b1 : 1'b0;
        loadCnt = (state == 4'h2) ? 1'b1 : 1'b0;
     //   enable = (state == 4'hA || state == 4'h2) ? 1'b1 : 1'b0; // enable counter
        enable = (state == 4'hA) ? 1'b1 : 1'b0; // enable counter
        reCsd = (state == 4'h4) ? 1'b1 : 1'b0;
        done = (state == 4'hB) ? 1'b1 : 1'b0;   
        enCnt = (state == 4'h6) ? 1'b1 : 1'b0; 
        weK = (state == 4'h7) ? 1'b1: 1'b0;
        reK = (state == 4'h8) ? 1'b1: 1'b0;
    end

endmodule
