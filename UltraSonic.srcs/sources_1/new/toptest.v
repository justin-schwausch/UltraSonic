`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/30/2018 01:07:31 PM
// Design Name: 
// Module Name: TopModule
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.03 - added ultrasonic and io (Justin)
// Additional Comments: More info in ultrasonic_proximity.v
// 
//
// PMOD Assignments:
// JA[1]:  Inductance Sensor
// JA[2]:  Ultrasonic Trigger
// JA[3]:  Ultrasonic Echo
// JA[4]:
// JA[7]:
// JA[8]:
// JA[9]:
// JA[10]:
//
// JB[1]:  ENA
// JB[2]:  IN1
// JB[3]:  IN2
// JB[4]:  ea
// JB[7]:  ENB
// JB[8]:  IN3
// JB[9]:  IN4
// JB[10]: eb
//
// JC[1]:
// JC[2]:
// JC[3]:
// JC[4]:
// JC[7]:
// JC[8]:
// JC[9]:
// JC[10]:
//
// JXADC[1]:
// JXADC[2]:
// JXADC[3]:
// JXADC[4]:
// JXADC[7]:
// JXADC[8]:
// JXADC[9]:
// JXADC[10]:
//////////////////////////////////////////////////////////////////////////////////


module toptest(
    input clk,
//    input [2:0]direction,
//    input [5:0]sw, // Speed for the motor control module set by the switches, to be removed
//    input coast, // to be removed as with brake
//    input ea, // input from the encoder of motor a
//    input eb, // input from the encoder of motor b
    input JA0, //echo from ultrasonic
    output[3:0] an, //anode for seven seg
    output[6:0] seg, //segment for seven seg
    output JA1 //trigger for ultrasonic
//    output IN1, // All that follow are motor outputs and shouldn't be moved
//    output IN2, 
//    output IN3,
//    output IN4,
//    output ENA,
//    output ENB
);
    reg brake; //stops the rover
    
    wire[15:0] msg; //wire for the message for the seven seg
    wire[15:0] dist; //distance from proximity sensor
    reg[15:0] us_mindist = 16'b0000101010100011; //minimum distance for us sensor before stop
    reg[4:0] us_hist = 5'b00000; //stores the last five us readings
    reg us_obst; //is there an obstacle detected by the us
    wire us_outup; //ultrasonic output update flag
    assign msg = dist;
    
     seven_seg Useven_seg( //instantiate the seven seg display
        .clk (clk),
        .msg (msg),
        .an  (an),
        .seg (seg)
     );
     
     top Utop( //instantiate the ultrasonic sensor
        .clk     (clk),
        .echo    (JA0),
        .trigger (JA1),
        .dist    (dist)
       // .outup   (us_outup)
      );
      
      // Motor control instantiaiton, Keep this at the bottom
//      Motor_Control Surface (
//        .Direction(direction),
//        .clk(clk),
//        .sw(sw),    // to be removed 
//        .brake(brake),
//        .coast(coast),
//        .ea(ea),
//        .eb(eb),
//        .IN1(IN1),
//        .IN2(IN2),
//        .IN3(IN3),
//        .IN4(IN4),
//        .ENA(ENA),
//        .ENB(ENB)
//     );
     
//     always @(posedge clk) //check ultrasonic
//     begin
        
//     if (us_outup) //if dist has been updated
//     begin
     
//        us_hist <= us_hist << 1; //shift history to the left, making room for a new reading in the lsb
        
//        if(dist <= us_mindist) //if dist is too close
//        begin
//        us_hist[4] <= 1'b1; //make the lsb in history a 1
//        end
        
//        else
//        begin
//        us_hist[4] <= 1'b0; //make the lsb in history a 0
//        end
        
//        if((us_hist[4] + us_hist[3] + us_hist[2] + us_hist[1] + us_hist[0]) >= 3) //if three or more of the last five us readings are too close
//        begin
//        brake <= 1'b1; //warn of obstacle
//        end
        
//        else
//        begin
//        brake <= 1'b0; //is no obstacle
//        end
        
//     end
     
//     end
            
    
endmodule
