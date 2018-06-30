`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/27/2018 01:16:51 PM
// Design Name: 
// Module Name: top
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


module top(

input clk,
input JA0,
output [3:0] an,
output [6:0] seg,
output JA1,
output[15:0] led
    );
    
    reg counten;
    reg outen;
    reg[21:0] count;
    reg[15:0] countf;
    reg[15:0] sw;
    reg[9:0] btncnt;
    reg[25:0] delcnt = 26'b11111111111111111111111111;
    wire btnC;

    assign led = countf;
    assign JA1 = outen;
    assign btnC = (delcnt == 26'b0) ?1'b1:1'b0;
    
    seven_seg Useven_seg(
    
    .clk (clk),
    .sw  (countf),
    .an  (an),
    .seg (seg)
    );
    
    always @(posedge clk)
    begin
    
    if(btncnt != 10'b0000000000)
    begin
    btncnt = btncnt + 1'b1;
    end
    
    else if(btnC == 1'b1)
    begin
    btncnt = 1'b1;
    outen = 1'b1;
    end
    
    if(btncnt == 10'b1111101000)
    begin
    btncnt = 10'b0000000000;
    outen = 1'b0;
    end
    
    delcnt <= delcnt + 1'b1;
    
    end
    
    
    always @(posedge clk)
    begin
    if (JA0)
    begin
        count <= count + 1;
    end
    
    else if(count != 22'b0)
    begin
    
        countf <= count[21:6];
        count <= 22'b0;
    end

  end
        
endmodule
