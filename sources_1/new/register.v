`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/30/2024 06:19:06 PM
// Design Name: 
// Module Name: register
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module register(
    input clk, reset,
    input enReg,
    input [7:0] data,
    output q
    );
    always @(posedge clk or posedge reset) begin
        if(reset)
            q <= 8'h0;
        else if (enReg)
            q <= data
    end
endmodule
