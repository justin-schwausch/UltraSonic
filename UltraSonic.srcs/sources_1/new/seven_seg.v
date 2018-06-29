`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/14/2018 02:45:05 PM
// Design Name: 
// Module Name: eight_bit
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


module seven_seg(
    input clk,
    input [15:0] sw,
    output [3:0] an,
    output [6:0] seg
    );
    localparam N = 18;
     
    reg [N-1:0]count; //the 18 bit counter which allows us to multiplex at 1000Hz
    always @ (posedge clk)
     begin
        begin
        count <= count + 1;
        end
     end
     
    reg [15:0]sseg; //the 7 bit register to hold the data to output
    reg [3:0]an_temp; //register for the 4 bit enable
     
    always @ (*)
     begin
      case(count[N-1:N-2]) //using only the 2 MSB's of the counter 
        
       2'b00 :  //When the 2 MSB's are 00 enable the fourth display
        begin
         sseg = sw[3:0];
         an_temp = 4'b1110;
        end
       2'b01:  //When the 2 MSB's are 01 enable the third display
        begin
         sseg = sw[7:4];
         an_temp = 4'b1101;
        end
       2'b10:
       begin
        sseg = sw[11:8];
        an_temp = 4'b1011;
       end
       2'b11:
       begin
        sseg = sw[15:12];
        an_temp = 4'b0111;
       end
       endcase
     end
   assign an = an_temp;
   
reg [6:0] sseg_temp; // 7 bit register to hold the binary value of each input given
    
   always @ (*)
    begin
     case(sseg)
      4'd0 : sseg_temp = 7'b1000000; //to display 0
      4'd1 : sseg_temp = 7'b1111001; //to display 1
      4'd2 : sseg_temp = 7'b0100100; //to display 2
      4'd3 : sseg_temp = 7'b0110000; //to display 3
      4'd4 : sseg_temp = 7'b0011001; //to display 4
      4'd5 : sseg_temp = 7'b0010010; //to display 5
      4'd6 : sseg_temp = 7'b0000010; //to display 6
      4'd7 : sseg_temp = 7'b1111000; //to display 7
      4'd8 : sseg_temp = 7'b0000000; //to display 8
      4'd9 : sseg_temp = 7'b0010000; //to display 9
      4'd10 : sseg_temp = 7'b0001000; //to display A
      4'd11 : sseg_temp = 7'b0000011; //to display b
      4'd12 : sseg_temp = 7'b1000110; //to display C
      4'd13 : sseg_temp = 7'b0100001; //to display d
      4'd14 : sseg_temp = 7'b0000110; //to display E
      4'd15 : sseg_temp = 7'b0001110; //to display F
     endcase
    end
   assign seg = sseg_temp; 
reg [26:0] count1 = 27'b0;
reg toggle = 1'b0;

always @ (posedge clk)
    begin
        begin
        count1 <= count1 + sw;
        end
    if(count1 >= 50000000)
     begin
      count1 <= count1 - 50000000;
        if(toggle == 0)
            begin
            toggle = 1;
            end
        else
            begin
            toggle = 0;
            end
        end
  end
        
endmodule
