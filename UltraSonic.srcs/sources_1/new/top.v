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
output JA1,
output[4:0] LED
    );
    
    reg counten;
    reg[21:0] count;
    reg[4:0] dave;

    assign JA1 = btnC;
    assign LED = dave;
    
    always @(posedge JA0)
    begin
    
    counten <= 1'b1;
    
    end
    
    always @(negedge JA0)
    begin
    
    counten <= 1'b0;
    
    end
    
    always @(posedge clk)
    
    if (counten == 1'b1)
    begin
        count <= count + 1;
        LED <= 1'b1;
    end
    
    else if (counten <= 1'b0)
    begin
        
        if (count == 22'b1110011111101111000000) //too far
            dave <= 5'b00000;
    
        else if (count >= 22'b1000110110011010000000) //400 cm
            dave <= 5'b00001;
        
        else if (count >= 22'b0110101000110011100000) //300 cm
            dave <= 5'b00010;
        
        else if (count >= 22'b0100011011001101000000) //200 cm
            dave <= 5'b00011;
                
        else if (count >= 22'b0010001101100110100000) //100 cm
            dave <= 5'b00100;        
        

    end
        
endmodule
