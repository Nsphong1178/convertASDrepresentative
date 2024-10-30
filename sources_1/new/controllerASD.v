`timescale 1ns / 1ps

module controllerASD(
    input clk, reset, start,
    input Zi, Zcsd,
    output reg Load, enable, reCsd, done, enCnt, loadCnt
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
                        state <= 4'h8;
                end
            //    4'h3: state <= 4'h4;
                4'h4: state <= 4'h5;
                4'h5: begin
                    if (Zcsd)
                        state <= 4'h6;
                    else 
                        state <= 4'h7;
                end 
                4'h6: state <= 4'h7;           
                4'h7: state <= 4'h3;   
                default: state <= 4'h0;
            endcase
        end
    end

    // Control Outputs
    always @(*) begin
        Load = (state == 4'h2) ? 1'b1 : 1'b0;
        loadCnt = (state == 4'h2) ? 1'b1 : 1'b0;
        enable = (state == 4'h7) ? 1'b1 : 1'b0;
        reCsd = (state == 4'h4) ? 1'b1 : 1'b0;
        done = (state == 4'h8) ? 1'b1 : 1'b0;   
        enCnt = (state == 4'h6) ? 1'b1 : 1'b0; 
    end

endmodule
