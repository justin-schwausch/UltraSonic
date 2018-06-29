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
input btnC,
input[15:0] sw,
output [3:0] an,
output [6:0] seg,
output JA1,
output[4:0] led
    );
    
    reg counten;
    reg[21:0] count;
    reg[21:0] countf;
    reg[4:0] dave;

    assign JA1 = btnC;
    assign led = dave;
    
    seven_seg Useven_seg(
    
    .clk (clk),
    .sw  (sw),
    .an  (an),
    .seg (seg)
    );
    
    
    always @(posedge clk)
    
    if (JA0 == 1'b1)
    begin
        count <= count + 1;
    end
    
    else if (JA0 <= 1'b0)
    begin
        countf <=count;
        count <= 22'b0;
        if (countf == 22'b1110011111101111000000) //too far
            dave <= 5'b00000;
    
        else if (countf >= 22'b1000110110011010000000) //400 cm
            dave <= 5'b00001;
        
        else if (countf >= 22'b0110101000110011100000) //300 cm
            dave <= 5'b00010;
        
        else if (countf >= 22'b0100011011001101000000) //200 cm
            dave <= 5'b00011;
                
        else if (countf >= 22'b0010001101100110100000) //100 cm
            dave <= 5'b00100;
                    

    end
        
endmodule
