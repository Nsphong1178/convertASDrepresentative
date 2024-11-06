`timescale 1ns / 1ps

module controllerASD(
    input clk, reset, start,
    input Zi, Zcsd, Zcnt, Zk, ZCsdK,
    output reg [3:0] sel_i,
    output reg kSel, selSaveK,
    output reg Load, enable, reCsd, done, enCnt, loadCnt, reK, weK
);

    reg [4:0] state;

    // State Machine
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 5'd0;
        end else begin
            case (state)
                5'd0: state <= 5'd1; 
                5'd1: begin
                    if (start)
                        state <= 5'd2;
                    else 
                        state <= 5'd0;
                end
                5'd2: state <= 5'd3;
                5'd3: begin
                    if (Zi)
                        state <= 5'd4;
                    else 
                        state <= 5'd11; // done
                end
                5'd4: state <= 5'd5;
                5'd5: begin
                    if (Zcsd)
                        state <= 5'd6;
                    else 
                        state <= 5'd10; // en counter i
                end 
                5'd6: state <= 5'd7;           
                5'd7: state <= 5'd8;
                5'd8: state <= 5'd9;
                5'd9: begin
                    if (Zcnt == 0)
                        state <= 5'd10;
                    else
                        state <= 5'd11; 
                end   
                5'd10: state <= 5'd3; 
                5'd11: state <= 5'd12;
                5'd12: state <= 5'd13;
                5'd13: state <= 5'd14;
                5'd14: begin
                    if(Zcnt == 1 && Zk == 1 && ZCsdK == 1)
                        state <= 5'd15;
                    else
                        state <= 5'd17;
                end
                5'd15: state <= 5'd16;
                5'd16: state <= 5'd17;
                default: state <= 5'd0;
            endcase
        end
    end

    // Control Outputs
    always @(*) begin
        Load = (state == 5'd2) ? 1'b1 : 1'b0;
        loadCnt = (state == 5'd2) ? 1'b1 : 1'b0;
        kSel = (state == 5'd15) ? 1'b1 : 1'b0;
        selSaveK = (state == 5'd15) ? 1'b1 : 1'b0;
        reCsd = (state == 5'd4) ? 1'b1 : 1'b0;
        enCnt = (state == 5'd6) ? 1'b1 : 1'b0; 
        weK = (state == 5'd7 || state == 5'd15) ? 1'b1 : 1'b0;
        reK = (state == 5'd8) ? 1'b1 : 1'b0;
        enable = (state == 5'd10) ? 1'b1 : 1'b0;
        sel_i = ((state == 5'd11) || (state == 5'd16)) ? 4'h2 :
                (state == 5'd12) ? 4'h3 :
                (state == 5'd13) ? 4'h4 : 4'h0;
      //  weCsd = (state == 5'd16) ? 1'b1 : 1'b0;
        done = (state == 5'd17) ? 1'b1 : 1'b0;
    end

endmodule
