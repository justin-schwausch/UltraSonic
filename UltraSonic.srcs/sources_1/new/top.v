`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Name: Justin Schwausch
// Class: ECE 3331
// Project: Ultrasonic Sensor
// Target: Basys 3 Board
// Last Modified: 6/30/2018
//
// This program takes makes use of the HC-SR04 to detect proximity.
//
// The relative distance is displayed on the four seven segment displays on the Basys board
//  and on the 16 LEDs on the board.
//////////////////////////////////////////////////////////////////////////////////



module ultrasonic_proximity(

input clk, //main clock
input echo, // echo pin
output trigger, //trigger pin
output[15:0] dist, //leds
output obst,
output[4:0] us_hist
    );
    
    
        
        reg counten; //count enable reg
        reg countint; //internal reg to represent input
        reg outen; //out enable reg
        reg[21:0] count; //count reg
        reg[15:0] countf; //stores the 16 most significant bits of count
        reg[9:0] outcnt; //counts out trigger pulse
        reg[24:0] delcnt = 25'b0; //counts delay between measurements
        wire outtogg;

        reg obstreg = 1'b0; //register that holds obstacle status
        reg outupreg;
    
        assign dist = countf; //assign output leds
        assign obst = obstreg;
        assign trigger = outen; //assign trigger output
        assign outtogg = (delcnt == 25'b0) ?1'b1:1'b0; //begin trigger pulse
        

    always @(posedge clk)
    begin
    
    if(outtogg == 1'b1) //if supposed to be counting
    begin
    outcnt = 1'b1; //start counting
    outen = 1'b1; //trigger posedge
    end
    
    else if(outcnt != 10'b0000000000) //if already counting
    begin
    outcnt = outcnt + 1'b1; //continue counting
    end
    
    if(outcnt >= 10'b1111101000) //if trigger on for 10 microseconds
    begin
    outcnt = 10'b0000000000; //reset count
    outen = 1'b0; //trigger negedge
    end
    
    delcnt <= delcnt + 1'b1; //up delay count
    
    end
    
    always @(posedge clk) //take in value of JA1 to mitigate metastability
    begin
    countint <= echo;
    end

    always @(posedge clk)
    begin
    
    if(outupreg)
    begin
    outupreg <= 1'b0;
    end
    
    if (countint) //if echo detected
    begin
    if(count < 22'b1111111111111111000000)
        count <= count + 1; //count echo pulse width
    end
    
    else if(count != 22'b0) //if count isn't 0
    begin
        if(count >= 22'b0000000000001010000000)
        begin
        countf <= count[21:6]; //load 16 most sig bits into countf
        outupreg <= 1'b1;
        end
        count <= 22'b0; //reset count
    end

  end
     
     reg[4:0] hist;
     assign us_hist = hist;
     reg[15:0] mindist = 16'b0000101010100011;
        
    always @(posedge clk) //check ultrasonic
    begin
       
    if (outupreg) //if dist has been updated
    begin
   
       hist <= hist >> 1;
       
       if(countf <= mindist) //if dist is too close
       begin
       hist[4] <= 1'b1; //make the lsb in history a 1
       end
       
       else
       begin
       hist[4] <= 1'b0; //make the lsb in history a 0
       end
       
       if((hist[0] + hist[1] + hist[2] + hist[3] + hist[4] >= 2)) //if three or more of the last five us readings are too close
       begin
       obstreg <= 1'b1; //warn of obstacle
       end
       
       else
       begin
       obstreg <= 1'b0; //is no obstacle
       end
       
    end
    
    end
        
endmodule
